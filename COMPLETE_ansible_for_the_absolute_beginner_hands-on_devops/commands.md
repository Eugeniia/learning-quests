### Ansible for the Absolute Beginner

# Ansible configuration files
/etc/ansible/ancible.cfg
$AMSIBLE_CONFIG

# Useful commands
ansible-config list
ansible-config view
ansible-config dump

# Inventory
/etc/ansible/hosts

# Ansible facts
var: ansible_facts
gather_facts: no
gathering = implicit (by default in ansible.cfg file)

# Ansible playbooks
ansible-doc -l
ansible-playbook playbook.yml
ansible-playbook --help
ansible-playbook playbook.yml --check (check mode: to do a dry-run)
ansible-playbook playbook.yml --check --diff (diff mode: to see the changes before and after)
ansible-playbook playbook.yml --syntax-check (to run syntax check)

# Ansible Lint - a command-line tool that performs linting on Ansible playbooks, roles, and collections.
ansible-lint playbook.yml

# Ansible Modules
- System (User, Group, Hostname, Iptables, Lvg, Lvol, Make, Mount, Ping, Timezone, Systemd, Service)
- Commands (Command, Expect, Raw, Script, Shell)
- Files (Acl, Archive, Copy, File, Find, Lineinfile, Replace, Stat, Template, Unarchive)
- Database (Mongodb, Mssql, Mysql, Postgresql, Proxysql, vertica)
- Cloud (Amazon, Atomic, Azure, Centrylink, Cloudscale, Cloudstack, Digital Ocean, Docker, Google, Linode, Openstack, Rackspace, Smartos, Softlayer, VMware)
- Windows (Win_copy, Win_command, Win_domain etc)
- More....

# Ansible Plugins
- Invemtory solution for real-time data. Require the ability to provision cloud resources with custom configurations. Dynamically configure.

A plugin - a piece of code that modifies the functionality of Ansible, enhances various aspects of Ansible and provide a flexible and powerful way to customize. 

- Inventory plugin, module plugin, acttion plugin, callback plugin, Lookup plugin, Filter plugin, Connection plugin.

# Modules & Plugins Index
Comprehensive resource offering detailed information on Ansible's available modules and plugins. Navigate Ansible's extensive modules and plugins, helping yo find the right tool for optial automation.

Key features:Search and filtering. Detailed documentaion. Version compatibility. Community contributions.

# Ansible Handlers, Roles and Collections
Ansible Handlers: Tasks triggered by events/notifications. Defined in playbook, executed when notified by a task. Manage actions based on system state/configuration changes. 

Ansible Roles: The goal is to make your work reusable for other tasks or projects within your organization or outside globally. Roles also help organize your code within ansible. 

ansible-galaxy init [role_name]

/etc/ansible/roles (default ansible location. defined as roles_path in the ansible configuration file)

ansible-galaxy search mysql (searching the role for mysql)
ansible-galaxy install geerlingguy.mysql -p ./roles (to install under current .roles directory)
ansible-galaxy list
ansible-galaxy dump| grep ROLE

Ansible Collections: a way to package and distribute modules, roles, plugins, etc. A self-contained unit. Community and vendor-driven. 
Benefits: expanded functionality, modularity and reusability, simplified distribution and management.

ansible-galaxy collection install network.cisco 

# Ansible Templates
Jinja2 filters + ansible filters (e.g. infra-specific). File extension is j2.

# Setup test cluster
1. Install ansible on "student-node"
sudo yum install ansible -y
2. Create an Ansible configuration file under /home/bob/playbooks directory and disable the SSH host key checking for Ansible.
vi /home/bob/playbooks/ansible.cfg

[defaults]
host_key_checking = False

3. Create an Ansible inventory file called inventory for host node01 under /home/bob/playbooks directory. Below are the details of node01:
Hostname: node01
User: bob
Password: caleston123

vi /home/bob/playbooks/inventory

node01 ansible_host=node01 ansible_ssh_pass=caleston123

cd /home/bob/playbooks
ansible -i inventory node01 -m ping -v (test it out using ansible ping)

4. We already have an inventory file /home/bob/playbooks/inventory. Add an alias for node02 host in it. Find the below details for the node02 host:
Hostname: node02
User: bob
Password: caleston123

vi /home/bob/playbooks/inventory

node02 ansible_host=node02 ansible_ssh_pass=caleston123

cd /home/bob/playbooks
ansible -i inventory node02 -m ping -v

5. Create a group called web_nodes in /home/bob/playbooks/inventory inventory file, further add node01 and node02 as a member of this group.

vi /home/bob/playbooks/inventory

[web_nodes]
node01
node02

6. Represent the below given data in Ansible Inventory format in /home/bob/playbooks/inventory_table file

Server Alias	Server Name	OS	User	Password
sql_db1	sql01.xyz.com	Linux	root	Lin$Pass
sql_db2	sql02.xyz.com	Linux	root	Lin$Pass
web_node1	web01.xyz.com	Win	administrator	Win$Pass
web_node2	web02.xyz.com	Win	administrator	Win$Pass
web_node3	web03.xyz.com	Win	administrator	Win$Pass

Group	Members
db_nodes	sql_db1, sql_db2
web_nodes	web_node1, web_node2, web_node3
boston_nodes	sql_db1, web_node1
dallas_nodes	sql_db2, web_node2, web_node3
us_nodes	boston_nodes, dallas_nodes

vi /home/bob/playbooks/inventory_table

#Web Servers
web_node1 ansible_host=web01.xyz.com ansible_connection=winrm ansible_user=administrator ansible_password=Win$Pass
web_node2 ansible_host=web02.xyz.com ansible_connection=winrm ansible_user=administrator ansible_password=Win$Pass
web_node3 ansible_host=web03.xyz.com ansible_connection=winrm ansible_user=administrator ansible_password=Win$Pass

#DB Servers
sql_db1 ansible_host=sql01.xyz.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Lin$Pass
sql_db2 ansible_host=sql02.xyz.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Lin$Pass

#Groups
[db_nodes]
sql_db1
sql_db2

[web_nodes]
web_node1
web_node2
web_node3

[boston_nodes]
sql_db1
web_node1

[dallas_nodes]
sql_db2
web_node2
web_node3

[us_nodes:children]
boston_nodes
dallas_nodes

7. Create a playbook called /home/bob/playbooks/command.yml which should execute the command to display the contents of file /etc/resolv.conf on localhost. Make sure to use command module to complete this task.

vi /home/bob/playbooks/command.yml

---
- name: Execute a command on localhost
  hosts: localhost
  connection: local
  tasks:
    - name: Execute a command
      command: cat /etc/resolv.conf

cd /home/bob/playbooks
ansible-playbook -i localhost, command.yml -vv

8. Create a playbook callled perm.yml under /home/bob/playbooks directory on student-node, an inventory file called inventory is already present under /home/bob/playbooks directory itself. Using this playbook perform below mentioned tasks:
Create an empty file called blog.txt under /opt/news/ directory on node01. Change its group owner to sam .
Create an empty file called story.txt under /opt/news/ directory on node02. Change its user owner to sam . 

vi /home/bob/playbooks/perm.yml

---
- hosts: node01
  become: true
  tasks:
    - name: Creating blog.txt file
      file:
        path: /opt/news/blog.txt
        state: touch
        group: sam

- hosts: node02
  become: true
  tasks:
    - name: Creating story.txt file
      file:
        path: /opt/news/story.txt
        state: touch
        owner: sam

cd /home/bob/playbooks
ansible-playbook -i inventory perm.yml

9. Create a playbook called file.yml under /home/bob/playbooks/ directory and use this playbook to create a file called /opt/file.txt on node01 host. The contents of the file must be This file is created by Ansible!

vi /home/bob/playbooks/file.yml

---
- hosts: node01
  become: true
  tasks:
    - name: create a file
      copy:
        dest: /opt/file.txt
        content: "This file is created by Ansible!"

cd /home/bob/playbooks
ansible-playbook -i inventory file.yml

10. Create a playbook called copy.yml under /home/bob/playbooks/ directory to copy /usr/src/blog/index.html file to both nodes i.e node01 and node02 at location /opt/blog.

vi /home/bob/playbooks/copy.yml

---
- hosts: all
  become: true
  tasks:
    - copy:
        src:  /usr/src/blog/index.html
        dest: /opt/blog
        remote_src: yes

cd /home/bob/playbooks
ansible-playbook -i inventory copy.yml

11. Write a playbook called replace.yml under /home/bob/playbooks/ directory on student-node host, an inventory file called inventory is already present under /home/bob/playbooks directory. Perform below given tasks using this playbook:
We have a file called /opt/music/blog.txt on node01. Using Ansible replace module replace string Kodekloud with Ansible in that file.
We have a file called /opt/music/story.txt on node02. Using Ansible replace module replace the string Ansible with Kodekloud in that file.

vi /home/bob/playbooks/replace.yml

---
- hosts: node01
  become: true
  tasks:
    - replace:
        path: /opt/music/blog.txt
        regexp: 'Kodekloud'
        replace: 'Ansible'

- hosts: node02
  become: true
  tasks:
    - replace:
        path: /opt/music/story.txt
        regexp: 'Ansible'
        replace: 'Kodekloud'

cd /home/bob/playbooks
ansible-playbook -i inventory replace.yml

12. he playbook /home/bob/playbooks/banana.yml has a variable defined called fruit. There are two tasks written in this playbook to print a text.
Use the when conditional to print I am a Banana if the value of fruit is banana otherwise it should print I am not a Banana.

vi /home/bob/playbooks/banana.yml

---
- name: 'Am I a Banana or not?'
  hosts: localhost
  connection: local
  vars:
    fruit: banana
  tasks:
    - command: 'echo "I am a Banana"'
      when: fruit == "banana"

    - command: 'echo "I am not a Banana"'
      when: fruit != "banana"

cd /home/bob/playbooks
ansible-playbook -i localhost, banana.yml -vv

13. The playbook /home/bob/playbooks/fruits.yml currently runs an echo command to print a fruit name. Add a loop directive (i.e with_items) in the task to print all fruits defined under the fruits variable.

vi /home/bob/playbooks/fruits.yml

---
- name: 'Print fruits'
  hosts: localhost
  connection: local
  vars:
    fruits:
      - Apple
      - Banana
      - Grapes
      - Orange
  tasks:
    - command: 'echo "{{ item }}"'
      with_items: '{{ fruits }}'

cd /home/bob/playbooks
ansible-playbook -i localhost, fruits.yml -vv

14. Create a playbook called package.yml under /home/bob/playbooks/ directory to install vim-enhanced package on student-node.

vi /home/bob/playbooks/package.yml

---
- name: 'Install the required package'
  hosts: localhost
  become: yes
  connection: local
  tasks:
    - yum: 
        name: vim-enhanced
        state: present

cd /home/bob/playbooks
ansible-playbook -i localhost, package.yml

15. There is a playbook /home/bob/playbooks/copy_file.yml on student-node. It is supposed to perform below tasks but needs some modification, modify this playbook to add some conditions so that below tasks can be performed:
Copy blog.txt file present under /usr/src/condition directory on student-node to node01 under /opt/condition directory. Its user and group owner must be bob and its permissions must be 0640.
Copy story.txt file present under /usr/src/condition directory on student-node to node02 under /opt/condition directory. Its user and group owner must be sam and its permissions must be 0400.

vi /home/bob/playbooks/copy_file.yml

---
- hosts: all
  become: true
  tasks:
    - name: Copy file with owner and permissions on node01
      copy:
        src: /usr/src/condition/blog.txt
        dest: /opt/condition/blog.txt
        owner: bob
        group: bob
        mode: "0640"
      when: inventory_hostname == "node01"

    - name: Copy file with owner and permissions on node02
      copy:
        src: /usr/src/condition/story.txt
        dest: /opt/condition/story.txt
        owner: sam
        group: sam
        mode: "0400"
      when: inventory_hostname == "node02"

cd /home/bob/playbooks/
ansible-playbook -i inventory copy_file.yml

16. We already have an inventory file called inventory under /home/bob/playbooks directory on student-node. Write a playbook called lineinfile.yml under /home/bob/playbooks directory. Perform below given tasks using this playbook :
On node01, a file called /var/www/html/index.html is available. It already has some content. Using Ansible lineinfile module add the below given content in it: Welcome to KodeKloud Labs!
Also make sure to preserve the existing content and this new line must be added at the top of the file.

vi /home/bob/playbooks/lineinfile.yml

---
- hosts: node01
  become: true
  tasks:
  - lineinfile:
      path: /var/www/html/index.html
      line: 'Welcome to KodeKloud Labs!'
      state: present
      insertbefore: BOF

cd /home/bob/playbooks/
ansible-playbook -i inventory lineinfile.yml

17. a. On student-node create an Ansible playbook called service.yml under /home/bob/playbooks/ directory. Further configure it to install vsftpd package on both nodes i.e node01 and node02.
b. The playbook must start the vsftpd service on both nodes.
c. The inventory /home/bob/playbooks/inventory is already there on student-node.

vi /home/bob/playbooks/service.yml

---
- hosts: all
  become: true
  tasks:
  - name: Install httpd package
    yum: name=vsftpd state=installed

  - name: Start service
    service:
      name: vsftpd
      state: started

cd /home/bob/playbooks/
ansible-playbook -i inventory service.yml

18. Create a playbook called archive.yml under /home/bob/playbooks directory on student-node, an inventory file called inventory is already placed under /home/bob/playbooks directory`. Perform below task using this playbook:
Create an archive of /usr/src/ecommerce/ directory present on each node ie. node01 and node02. The archive name must be demo.tar.gz (make sure that archive format is tar.gz) and save it under /opt/ecommerce/ directory on each node itself.

vi /home/bob/playbooks/archive.yml

---
- hosts: all
  become: true
  tasks:
  - name: Create an archive demo.tar.gz
    archive:
      path: /usr/src/ecommerce/
      dest: /opt/ecommerce/demo.tar.gz

cd /home/bob/playbooks/
ansible-playbook -i inventory archive.yml

19. Using Ansible galaxy, install an Ansible role called geerlingguy.nodejs under /home/bob/playbooks/roles directory.

ansible-galaxy install geerlingguy.nodejs -p /home/bob/playbooks/roles

20. Create an Ansible role called package under /home/bob/playbooks/roles directory on student-node. It should install a package called nginx and should start its service as well.
Further consume this role in /home/bob/playbooks/role.yml playbook so that this role can be applied on node01

cd /home/bob/playbooks/roles/
ansible-galaxy init package
vi /home/bob/playbooks/roles/package/tasks/main.yml

---
# tasks file for nginx
- name: Install Nginx
  ansible.builtin.package:
    name: nginx 
    state: latest
- name: Start Nginx Service
  ansible.builtin.service:
    name: nginx 
    state: started

vi /home/bob/playbooks/role.yml

---
- hosts: node01
  become: true
  roles:
    - roles/package

cd /home/bob/playbooks/
ansible-playbook -i inventory role.yml
