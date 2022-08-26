#!/bin/bash
#Filename: varFunc.sh
#Version: 1.8
#Creation: July 2122
#Author (GitHub): TheProtag1nist
#1518251
#------------------------------------------------------
#======================================================
# ECHO FORMATTING
#======================================================

ERROR='\033[1;91m'  #  -> RED
GOOD='\033[1;92m'   #  -> GREEN
WARN='\033[1;93m'   #  -> YELLOW
INFO='\033[1;96m'   #  -> BLUE
END='\033[0m'       #  -> DEFAULT

#------------------------------------------------------

#======================================================
# FETCHING CURRENT STAGE VARIABLE
#======================================================

source "${PWD%/}"/scriptBase/conf/rst-stage.conf

#------------------------------------------------------

#======================================================
# USEFUL VARIABLES
#======================================================

# Current User
currentUser=$(whoami)
currentHost=$(hostname)
dateTime=$(date +"%Y-%m-%d %T")

#useful_packages="net-tools git neofetch"
#junk_packages="aisleriot baobab branding-ubuntu cheese deja duplicity genisoimage gir1.2-gst-plugins-base-1.1 gir1.2-gudev-1.1 gir1.2-rb-3.0 gir1.2-totem-1.0 gir1.2-totemplparser-1.0 gir1.2-udisks-2.0 gnome-calendar gnome-mahjongg gnome-mines gnome-sudoku gnome-todo-common gnome-todo gnome-video-effects grilo-plugins-0.3-base gstreamer1.0-gtk3 guile-2.2-libs hunspell-en-gb hyphen-en-gb hyphen-en-us libabw-0.1-1 libavahi-ui-gtk3-0 libboost-filesystem1.74.0 libboost-iostreams1.74.0 libboost-locale1.74.0 libboost-thread1. libcdr-0.1-1 libclucene-contribs1v5 libclucene-core1v5 libcolamd2 libdazzle-1.0-0 libdazzle-common libdmapsharing-3.0-2 libe-book-0.1-1 libeot0 libepubgen-0.1-1 libetonyek-0.1-1 libevent-2.1-7 libexttextcat-2.0-0 libexttextcat-data libfreehand-0.1-1 libgc1 libgnome-games-support-1-3 libgnome-games-support-common libgnome-todo libgom-1.0-0 libgpgmepp6 libgpod-common libgpod4 libgrilo-0.3-0 liblangtag-common liblangtag1 liblirc-client0 liblua5.3-0 libmessaging-menu0 libmhash2 libminiupnpc17 libmspub-0.1-1 libmwaw-0.3-3 libmythes-1.2-0 libnatpmp1 libodfgen-0.1-1 liborcus-0.17-0 liborcus-parser-0.17-0 libpagemaker-0.0-0 libqqwing2v5 libraptor2-0 librasqal3 librasqal3 libraw20 librdf0 libreoffice librevenge-0.0-0 librhythmbox-core10 librsync2 libsgutils2-2 libsuitesparseconfig5 libtotem0 libuno-cppu3 libuno-purpenvhelpergcc3-3 libuno-sal3 libvisio-0.1-1 libvncclient1 libwpd-0.10-10 libwpg-0.3-3 libwps-0.4-4 libxmlsec1-nss libyajl2 lp-solve media-player-info mythes-en-us python3-bcrypt python3-fasteners python3-future python3-lib2to3 python3-lockfile python3-mako python3-markupsafe ython3-monotonic python3-paramiko python3-uno remmina rhythmbox thunderbird totem ure usb-creator-common usb-creator-gtk"
useful_packages="${PWD%/}""/scriptBase/conf/useful-packages.conf"
junk_packages="${PWD%/}""/scriptBase/conf/junk-packages.conf"
log_location="${PWD%/}""/scriptBase/logs"

reboot_stg=$(cat "${PWD%/}""/scriptBase/conf/rst-stage.conf")



function wait4user {
    read -n 1 -r -s -p "Press any key to return to menu."
}

function cvescan_install {
    echo -e "$WARN""cvescan is not installed.""$END"
    echo -e "$INFO""Begin cvescan installation.""$END"
    sudo snap install cvescan
    echo -e "$WARN""Re-checking for successful install.""$END"
    check_cve
}

#------------------------------------------------------
#======================================================
# NETWORK FUNCTIONS
#======================================================

function IPv6_disable() {
    sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
    sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
    sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1
}

function IPv6_enable() {
    echo -e "$WARN" "Now Enabling IPv6.""$END"
    sudo sysctl -w net.ipv6.conf.all.disable_ipv6=0
    sudo sysctl -w net.ipv6.conf.default.disable_ipv6=0
    sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=0
}

function ssh_access_allow {
    sudo systemctl enable --now ssh
    sudo ufw allow 22/tcp
    echo -e "$WARN" "SSH access has be allowed.""$END"

}

function ssh_access_deny(){
    echo -e "$ERROR" "Active SSH connection terminating.""$END"
    sudo systemctl disable --now ssh
    sudo ufw deny 22/tcp
    echo -e "$WARN" "SSH access is now denied.""$END"
}

function generate_key(){
    echo -e "$WARN" "Removing existing keys.""$END"
    sudo rm -v /etc/ssh/ssh_host_*
    echo -e "$WARN" "Gernerating new keys.""$END"
    sudo dpkg-reconfigure openssh-server
    echo -e "$GOOD" "SSH keys have been re-generated.""$END"
    echo -e "$INFO" "Restarting SSH service with new keys.""$END"
    sudo systemctl restart ssh
}

function remove_legacyRemote(){
    echo -e "$WARN" "Removing insecure remote access packages.""$END"
    sudo apt remove ftp
    sudo apt purge telnet
    sudo apt purge remmina
}

function rec_net_settings(){
    echo -e "$WARN" "Making changes to network settings.""$END"
    sudo cp "${PWD%/}"/scriptBase/conf/sysctl.conf /etc/sysctl.conf
    
    sudo ufw default deny outgoing
    sudo ufw allow http
    sudo ufw allow https
    sudo ufw allow from 1.1.1.1 proto tcp to any port 53
    sudo ufw allow from 1.0.0.1 proto tcp to any port 53
    sudo ufw enable
}

#------------------------------------------------------
#======================================================
# MAINTENANCE FUNCTIONS
#======================================================

function source_update(){
    sudo apt update 
}

function system_upgrade(){
    echo -e "$INFO""Fetching latest updates.""$END"
    sudo apt update
    echo -e "$INFO""Downloading & installing any new upgrades.""$END"
    sudo apt-get full-upgrade -qq --yes --force-yes
    echo -e "$INFO""Updating Snap packages.""$END"
    sudo snap refresh
    echo -e "$GOOD""Installation complete!""$END"
}

function useful_packages_auto(){
    echo -e "$INFO""Now Installing:-""$END"
    echo -e "$INFO" && cat "$useful_packages" && echo -e "$END"
    #echo -e """$END"
    #cat "${PWD%/}""/scriptBase/conf/useful-packages.conf"
    #sudo apt install "$useful_packages"
    < "$useful_packages" xargs sudo apt install -y
}

function remove_junk_packages(){

    echo -e "$WARN""Now removing bloatware & reducing your attack surface.""$END"
    echo -e "$INFO""The following packages are going to be removed:-"
    #cat "$junk_packages"
    cat "$junk_packages" && echo -e "$END"
    < "$junk_packages" xargs sudo apt remove -y

    sudo apt autoremove

}

function unattended_updates_setup(){
    echo -e "$INFO" "Now installing unattended-upgrades.""$END"
    sudo apt install unattended-upgrades
    sudo dpkg-reconfigure -plow unattended-upgrades
}

function disk_usage(){
    echo -e "$INFO" "Your system disks:-" "$END"
    lsblk
    echo -e "$INFO" "Disk usage:- " "$END"
    df -h
    wait4user
    bash "${PWD%/}"/scriptBase/lib/lib2.sh
}

function standard_acc_create(){
    echo -e "$INFO" "Now starting new user setup." "$END"
    echo "What is the username you would like to use?"
    read -p "$user_input_name" username

    sudo adduser --quiet --disabled-password --shell /bin/bash --home /home/"$username" "$username"


#   sudo useradd "$username"
    echo "What is the password you would like to use? (min. 8 characters)"
    read -p "$user_input_pass" password
#  sudo passwd "$username"
#  $password
#  $password

    echo "$username:$password" | sudo chpasswd
    echo -e "$GOOD""The user $username has been created!""$END"
    echo -e "$WARN""If errors have occurred during this process, user may still have been created."
}


#------------------------------------------------------
#======================================================
# SECURITY FUNCTIONS
#======================================================

function clamav_install() {
        echo -e "$INFO""Now installing clamav.""$END"
        sudo apt install clamav clamav-daemon
        echo -e "$GOOD""clamAV install finished.""$END"
        echo -e "$WARN""Stopping service to update virus definitions.""$END"
        sudo systemctl stop clamav-freshclam.service
        echo -e "$INFO""Updating your virus definitions.""$END"
        sudo freshclam
        echo -e "$GOOD""Definition update complete.""$END"
        echo -e "$GOOD""Restarting service.""$END"
        sudo systemctl start clamav-freshclam.service
        sudo systemctl status clamav-freshclam.service

}

function rootkit_install() {
        echo "Beginning installation of chkrootkit & RKHunter packages."
        
        echo -e "$INFO""Stage 1: RKHunter.""$END"
#        sudo apt install rkhunter
#        sudo apt-get install rkhunter
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends rkhunter
        echo -e "$GOOD""Stage 1 Finished.""$END"

        echo -e "$INFO""Stage 2: chkrootkit.""$END"
        sudo apt install chkrootkit
        echo -e "$GOOD""Stage 2 Finished.""$END"
}

function sys_mal_scan() {

    sudo clamscan -r /
    echo -e "$INFO""Beginning scan with chkrootkit.""$END"
    touch "$log_location"/chkroot-scan_"$dateTime".txt
    sudo chkrootkit > "$log_location"/chkroot-scan_"$dateTime".txt
    echo -e "$GOOD""Scan with chkrootkit complete.""$END"
    sudo rkhunter -c | tee "$log_location"/rkhunter-scan_"$dateTime".txt

}

function fail2ban_install() {
        echo -e "$INFO""Now installing fail2ban.""$END"
        sudo apt install fail2ban
        sudo systemctl status fail2ban.service
        
#        sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

}

function root_acc_on() {
    echo  -e "$WARN" "Root account has been enabled. (Not Recommended)" "$END"
    sudo passw -u root
}


function root_acc_off() {
    echo -e "$GOOD""Root account has be locked.""$END"
    sudo passwd -l root
}

#------------------------------------------------------
#======================================================
# DOC + AUDIT FUNCTIONS
#======================================================

function save_cmds {
    cat ${HOME}/.bash_history > ${HOME}/Documents/history_"$dateTime".txt

}

function installed_apps() {
    touch "$log_location"/installed_apps_"$dateTime".txt
    dpkg-query -l > "$log_location"/installed_apps_"$dateTime".txt
    cat "$log_location"/installed_apps_"$dateTime".txt
}

function check_cve() {
if [ "$(which cvescan)" = '/snap/bin/cvescan' ]

then
    echo -e "$GOOD""CVE Scan is installed.""$END"
    echo -e "$INFO" "Starting scan..." "$END"
    touch "$log_location"/present_vulns_"$dateTime".txt
    cvescan > "$log_location"/present_vulns_"$dateTime".txt

    echo -e "$INFO""Your results have also been saved to the logs folder.""$END"

    echo -n "Would you like to view the results now? [Y / N]"
        read cve_logs_YN
            case $cve_logs_YN in
                y) 
                    clear
                    cat "$log_location"/present_vulns_"$dateTime".txt
                    wait4user
#                    bash "${PWD%/}"/scriptBase/lib/lib4.sh
                    ;;
                Y) 
                    clear
                    cat "$log_location"/present_vulns_"$dateTime".txt
                    wait4user
#                    bash "${PWD%/}"/scriptBase/lib/lib4.sh
                    ;;
                n ) 
#                    bash "${PWD%/}"/scriptBase/lib/lib4.sh
                    ;;
                N ) 
#                    bash "${PWD%/}"/scriptBase/lib/lib4.sh
                    ;;
                * ) 
                    echo -e "$ERROR""User response error.""$END"
#                    bash "${PWD%/}"/scriptBase/lib/lib4.sh
                    ;;
            esac

    cat "$log_location"/present_vulns_"$dateTime".txt
    
else
    cvescan_install
fi

}

function create_sys_doc {
    touch "$log_location"/"$currentHost"-documentation_"$dateTime".txt
    neofetch >> "$log_location"/"$currentHost"-documentation_"$dateTime".txt

    echo "Your system disks:-" >> "$log_location"/"$currentHost"-documentation_"$dateTime".txt
    lsblk >> "$log_location"/"$currentHost"-documentation_"$dateTime".txt
    echo "Disk usage:- " >> "$log_location"/"$currentHost"-documentation_"$dateTime".txt
    df -h >> "$log_location"/"$currentHost"-documentation_"$dateTime".txt

    echo "Network Info: " >> "$log_location"/"$currentHost"-documentation_"$dateTime".txt
    ip addr >> "$log_location"/"$currentHost"-documentation_"$dateTime".txt

    echo "Users: " >> "$log_location"/"$currentHost"-documentation_"$dateTime".txt
    users >> "$log_location"/"$currentHost"-documentation_"$dateTime".txt
    echo "Groups: " >> "$log_location"/"$currentHost"-documentation_"$dateTime".txt
    groups >> "$log_location"/"$currentHost"-documentation_"$dateTime".txt

}


function lynis_check {

echo -e "$INFO""Checking for lynis install & updates...""$END"
sudo apt install lynis -y
echo -e "$INFO""Now generating audit report as low-privileged user.""$END"
lynis audit system | tee "$log_location"/lynis-test_"$dateTime".txt

}



#------------------------------------------------------
#======================================================
# AUTOMATING HARDENING
#======================================================

function auto_all {

#echo "Hello World!"

if grep -q "1" "${PWD%/}"/scriptBase/conf/rst-stage.conf
    then
    echo -e "$INFO""Beginning stage 1.""$END"
    echo "Removing bloatware"
    yes "yes" | remove_junk_packages
    yes "yes" | remove_legacyRemote
    echo "Upgrading system & its packages to latest versions."
    yes "yes" | system_upgrade
    sed -i 's/1/2/g' "${PWD%/}"/scriptBase/conf/rst-stage.conf
    echo "Rebooting..."
    sleep 6s && reboot
    exit
fi



if grep -q "2" "${PWD%/}"/scriptBase/conf/rst-stage.conf
    then
    echo "Continuing where the system left off..."
    echo -e "$INFO""Beginning stage 2.""$END"
    echo "Installing several useful packages."
    unattended-upgrades
    useful_packages_auto
    yes "yes" | clamav_install
    yes "yes" | rootkit_install
    
    sed -i 's/2/3/g' "${PWD%/}"/scriptBase/conf/rst-stage.conf
    echo "Rebooting..."
    sleep 6s && reboot
    exit
fi

if grep -q "3" "${PWD%/}"/scriptBase/conf/rst-stage.conf
    then
    echo -e "$INFO""Beginning stage 3.""$END"
    echo "Continuing where the system left off..."
    sed -i 's/3/4/g' "${PWD%/}"/scriptBase/conf/rst-stage.conf

    #Non-reboot funcs
    IPv6_disable
    ssh_access_deny
    rec_net_settings
    root_acc_off

    echo -e "$GOOD""System hardening process complete.""$END"
    echo -e "$INFO""Performing some quick auditing actions.""$END"
    echo -e "$WARN""Your audit documents will be stored in the tool's log directory.""$END"
    read -n 1 -r -s -p "Press any key when you are ready to begin the audit process."

fi

if grep -q "4" "${PWD%/}"/scriptBase/conf/rst-stage.conf
    then
    echo -e "$INFO""Beginning stage 4.""$END"
    sed -i 's/4/1/g' "${PWD%/}"/scriptBase/conf/rst-stage.conf

    #Audit actions
    create_sys_doc
    save_cmds
    installed_apps
    check_cve
    sys_mal_scan
    lynis_check

    echo -e "$GOOD""Audit complete.""$END"
    echo "Thank you for using the UoB tool."
    wait4user
    bash "${PWD%/}"/run.sh
fi

#    exit

}

#-----------------------------------------------------
#END OF FILE....