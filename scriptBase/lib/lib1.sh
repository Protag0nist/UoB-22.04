#!/bin/bash
#Filename: lib1.sh
#Version: 1.7
#Creation: July 2022
#Author (GitHub): TheProtag0nist
#1508250
#------------------------------------------------------
#======================================================
# SOURCE FUNCTIONS
#======================================================

source "${PWD%/}"/scriptBase/lib/varFunc.sh

#------------------------------------------------------
#======================================================
# DEBUG FILE ANNOUNCE
#======================================================
clear
echo "------------------------------------------------------"
echo "NETWORKING SETTINGS"
echo "------------------------------------------------------"
#------------------------------------------------------
#======================================================
# USER MENU
#======================================================
echo "

1) Enable IPv6 Traffic.
2) Disable IPv6 Traffic.
3) Enable SSH remote access.
4) Re-generate SSH key.
5) Disable SSH remote access.
6) Remove all remote access packages.
7) Implement recommended network hardening settings.

0) Return to Main Menu.

Select one: 
"


read userOpt

case $userOpt in
 	1 )
		IPv6_enable
		;;

	2 )
		IPv6_disable
		;;
	3)
		ssh_access_allow
		;;
	4)
		generate_key
 		;;
 	5)
		ssh_access_deny
 		;;
 	6)
		remove_legacyRemote
		;;
	7)
		rec_net_settings
		;;
 	0 )
	# Reloads core for main menu options.
		clear
		bash "${PWD%/}"/scriptBase/core.sh
 		;;
  	*)
	# Returns an error when user inputs incorrect response.
   		echo -n "Invalid Option. Try again? [Y / N]"
   		read userYN
   			case $userYN in
				y) 
					bash "${PWD%/}"/scriptBase/lib/lib1.sh
					;;
				Y) 
					bash "${PWD%/}"/scriptBase/lib/lib1.sh
					;;
				n ) 
					echo "exiting...";
					exit
					;;
				N ) 
					echo "exiting...";
					exit
					;;
				* ) 
					echo -e "$ERROR""User response error. Terminating Program...""$END"
					;;
   			esac
 esac