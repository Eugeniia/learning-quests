### Administration of Red Hat Enterprise Linux

## Essential Linux Tools
To switch between current and previous directory:
cd - 

To display the current terinal name you are currently looged on to:
tty

Display the list of users currently logged on tot he system:
who

Display more details (than in who command):
w

Show the system current uptime (how long it has been up to):
uptime

Display the name of the user executing this command:
whoami

Display the name of the user who originaly logged in to the system:
logname

Display the user ids (e.g. uid, gid, groups):
id

Display the list of groups for the user:
groups

Display the histpory of successful user login attempts and system reboots (by reading the /var/log/wtmp file that keeps teh record of all login and logout activities):
last

Display only reboot details:
last reboot

Display history of the failed user login attempt:
uname -a

uname -s (kernel name)
uname -n (node name)
uname -r (kernel release)
uname -v
uname -p (processor type)
uname -i
uname -o (operating system name)

Change your home directory:
sudo usermod -d /home/newuserhome -m olduserhome

# Displaying and setting time and date.
1) Real-time clock (RTC) - hardware clock that is completely independent of the current state of the operating system and rund even when the computer is shutdown.
2) System clock - software clock that is maintained by kernel and its initial values is based on RTC. Once the system is booted and the system clock is initialized, the system clock is completely independent of the RTC.

Display the local, universal and RTC times + time zone etc:
timedatectl
systemctl restart systemd-timedated.service

Change the current time:
timedatectl set-time 23:26:00

Change to local time:
timedatectl set-local-rtc true

Change the date:
timedatectl set-time 2017-09-30 23:26:00

List timezones:
timedatectl list-timezones

Change the timezone:
timedatectl set-timezone Europe/Zurich

Enable NTP service:
timedatectl set-ntp yes

Display the current time:
date
date --utc
date +"%Y-%m-%d %H:%M"

Change the time:
date --set 23:26:00
date --set 23:26:00 --utc
date --set "2017-09-30 23:26:00"

Display the hardware clock:
hwclock
cat /etc/adjtime

Change the hardware clock time:
hwclock --set --date "21 Oct 2017 21:17" --utc

Synchronize the hardware time time and the current system time:
hwclock --systohc
hwclock --hctosys --utc (it's recommended to keep the hardware clock in UTC)
hwclock --hctosys --localtime

Synchronize the date and time with a remote server:
ntpdate



