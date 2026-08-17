### Ansible Advanced - Hands-On - DevOps
Why Ansible? Provisioning. Configuration management. Continuous delivery. Application deployment. Security compliance.

# Setup environment
- With Oracle VM VirtualBox or Docker
docker run -it -d mmumshad/ubuntu-ssh-enabled
docker ps
docker inspect [container id]
docker run -it -d mmumshad/ubuntu-ssh-enabled # run two more times to create two more containers

cat > inventory.txt 
target1 ansible_host=[ipaddress for first docker container] ansible_ssh_pass=Passw0rd
target2 ansible_host=[ipaddress for second docker container] ansible_ssh_pass=Passw0rd
target3 ansible_host=[ipaddress for third docker container] ansible_ssh_pass=Passw0rd

ansible target* -m ping -i inventory.txt

docker run -d kodekloud/ubuntu-ssh-enabled:stable
docker inspect <container-id-name>
ssh <container-ip> #Username: root Password: Passw0rd

# Web Application
cat > inventory.txt
[db_and_web_servers]
db_and_web_server1 ansible_ssh_pass=Passw0rd ansible_host=192.168.1.14
db_and_web_server2 ansible_ssh_pass=Passw0rd ansible_host=192.168.1.15

cat > Playbook.yml
- name: Deploy a web application
  hosts: db_and_web_servers
  tasks:
    - name: Try Ping
      ping:

ansible-playbook playbook.yml -i inventory.txt
 
# File separation
host_vars/db_and_web_server.yml # name the file the same as the actual server in hte inventory file
group_vars
tasks:
- include: tasks/deploy_db.yml
- include: tasks/deploy_web.yml

# Roles
Why roles? Organize, reuse, share.

ansible-galaxy init webserver
ansible-galaxy import webserver

tasks:
- include: tasks/deploy_db.yml
- include: tasks/deploy_web.yml

or

roles:
- mysql_db
- flask_web

# Asynchronous actions
Use cases for using asynchronous actions:
- Run a process and check on it later
- Run multiple processes at once and check on them later
- Run processes and forget

tasks:
  - command: /opt/monitor_webapp.py
    async: 360  # How long to run?
    poll: 0   # How frequently to check? default 10 seconds
    register: webapp_result
  - name: Check status of tasks
    async_status: jid={{ webapp_result.ansible_job_id }}}
    register: job_result
    until: job_result.finished
    retries: 30

# Strategy
How a playbook is executed in ansible. e.g. Install dependencies, install MySQL, start DB, install Flask, run Server.

- Linear strategy (default).
- Free strategy. Each server will run the tasks independently without waiting for other tasks to finish on other servers. 
strategy: free
- Batch strategy. Based on the linear stratagy. 
serial: 3 # How many servers you would like to process together? It runs lineary strategy on three servers first, and then proceed with other servers in the next batch.

The serial directive has some advanced use cases. For example you could run the play against 2 servers first, then 3 in the next round and then the last 5 together by providing an array as input to the serial directive. This is really useful for "Rolling Updates". 
serial:
  - 2
  - 3
  - 5

For example you could specify a percentage to say execute the playbook against 20% of servers at a time.
serial: "20%"

You can develop your own custom strategy.

Ansible uses parallel processes (or forks) to communicate with remote hosts. By default, ansible can create 5 forks at a time. This is defined in the ansible configuration file (see ansible.cfg "forks = 5"). You can change it to e.g. 100 - just make sure you have sufficient CPU resources and network bandwith for this operation.

# Error handling
By default, ansible will make an attempt to complete (without error) as many servers as possible. 
In case we would like to be consistent, and stop the ansible playbook when one of the servers failed, add an option "any_error_fata;: true"

hosts: server1, server2, server3
any_errors_fatal: true

To ignore error, use "ignore_errors: yes"

    - name: "Send notification email"
      mail:
        to: devops@corp.com
        subject: Server Deployed!
        body: Web Server Deployed Successfully
      ignore_errors: yes

To fail on a condition, use "failed_when"

- command: cat /var/log/server.log
  register: command_output
  failed_when: "'ERROR' in command_output.stdout"
  
# Templating - Jinja2
{{ }}, {% %} => Jinja2 templating

Filters: upper, lower, title, etc
{{ my_name | upper }}
{{ my_name | lower }}
{{ my_name | title }}
{{ my_name | replace("Bond", "Bourne") }}
{{ first_name | default("James") }} {{ my_name }} # James Bond
{{ [1, 2, 3] | min }}
{{ [1, 2, 3] | max }}
{{ [1, 2, 3, 2], | unique }} # 1,2,3
{{ [1, 2, 3, 4] | union([4, 5]) }} # 1,2,3,4,5
{{ [1, 2, 3, 4] | intersect([4, 5]) }} # 4
{{ 100 | random }}
{{ ["The", "name", "is", "Bond"] | join(" ") }}
{{ "/etc/hosts" | basename }} # hosts
{{ "c:\windows\hosts" | win_basename }} # hosts
{{ "c:\windows\hosts" | win_splitdrive }} # ["c:", "\windows\hosts"]
{{ "c:\windows\hosts" | win_splitdrive | first }} # "c:"
{{ "c:\windows\hosts" | win_splitdrive | last }} # "\windows\hosts"

-
  name: Test valid IP Address
  hosts: localhost
  vars:
    ip_address: 192.168.1.6
  tasks:
  - name: Test IP Address
    debug:
      msg: IP Address = {{ ip_address | ipaddr }}

# Lookups
File lookup - to look for information outside of ansible, e.g. in a different file. 
Example CSV file - credentials.csv

Hostname, Password
Target1, Passw0rd
Target2, Passw0rd

{{ lookup('csvfile', 'target1 file=/tmp/credentials.csv delimiter=,') }} # Passw0rd

There are aslo other lookup plugins: INI, DNS, MongoDB

-
  name: Test Connectivity
  hosts: web_server
  vars:
    ansible_ssh_pass: "{{ lookup('csvfile', 'web_server file=credentials.csv delimiter=,') }}"
  tasks:
  - name: Ping target host
    ping:
      data: "Test"

Example INI file - crdentials.ini

# Credentials File

[web_server]
password=Passw0rd

[db_server]
password=Passw0rd

-
  name: Test Connectivity
  hosts: web_server
  vars:
    ansible_ssh_pass: "{{ lookup('ini', 'password section=web_server file=credentials.ini') }}"
  tasks:
  - name: Ping target host
    ping:
      data: "Test"

# Vault
nsible vault helps store credentials (passwords) data in the encrypted format. 

- Encrypt the current inventory file
ansible-vault encrypt inventory.txt
ansible-playbook playbook.yml -i inventory.txt -ask-vault-pass # don't want to paste the password every time
ansible-playbook playbook.yml -i inventory.txt -vault-password-file ~./vault_pass.txt # still not the best option
ansible-playbook playbook.yml -i inventory.txt -vault-password-file ~./vault_pass.py # the safest way
ansible-vault view inventory.txt
ansible-vault create inventory.txt

# Dynamic inventory
Inventory information that ansible retrieves programmatically when the ansible playbok is ran (not defined in a static file).  

Using inventory python scipt:
ansible-playbook playbook.yml -i inventory.py
./inventory.py --list
./inventory.py --host web

There are examples of dynamic scripts for Cobbler, AWS, Azure, Google Compute Engine, Openstack, VMware, Docker etc.

# Custom modules
Need to develop custom python script:
- import JSON, import AnsibleModule, Instantiate AnsibleModule.

ansible-doc debug # documentation for module "debug"

All built-in modules are located by default under /usr/lib/python2.7/dist-packages/ansible/modules
Role - place it under library folder inside project
Across projects - place anywhere and input using env variable ANSIBLE_LIBRARY

Check "ansible playAble" project - a tool to create custom modules (with ansible playbooks).

# Plugins
Action, connection, filter, lookup, strategy, callback plugins.
