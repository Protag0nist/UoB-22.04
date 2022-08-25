#!/bin/bash
#Filename: lib2.sh
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
echo "SYSTEM HEALTH & MAINTENANCE"
echo "------------------------------------------------------"
#------------------------------------------------------
#======================================================
# USER MENU
#======================================================

echo "

1) Update source list.
2) Check for recent updates, install them & reboot.
3) Install useful diagnostic packages.
4) Remove bloatware from normal OS install type.
5) View disk usage.
6) Create a standard user account.

0) Return to Main Menu.

Select one: 
"

read userOpt

case $userOpt in
 	1 )
		clear
		source_update
		wait4user 
		bash "${PWD%/}"/scriptBase/lib/lib2.sh
 		;;
 	2)
		clear
		system_upgrade
		read -n 1 -r -s -p "Press to reboot."
		#reboot
		;;

 	3 )
		clear
		useful_packages_auto
		wait4user
		bash "${PWD%/}"/scriptBase/lib/lib2.sh
 		;;

 	4)
		clear
		remove_junk_packages
		wait4user
		bash "${PWD%/}"/scriptBase/lib/lib2.sh
		;;

	5)
		clear
		disk_usage
		wait4user
		bash "${PWD%/}"/scriptBase/lib/lib2.sh
		;;

	6)
		clear
		standard_acc_create
		wait4user
		bash "${PWD%/}"/scriptBase/lib/lib2.sh
		;;

# Re-load core for main menu options.
 	0 )
		clear
		bash "${PWD%/}"/scriptBase/core.sh
 		;;
  	*)
	# Returns an error when user inputs incorrect response.
   		echo -n "Invalid Option. Try again? [Y / N]"
   		read userYN
   			case $userYN in
				y) 
					bash "${PWD%/}"/scriptBase/lib/lib2.sh
					;;
				Y) 
					bash "${PWD%/}"/scriptBase/lib/lib2.sh
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