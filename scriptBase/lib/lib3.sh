#!/bin/bash
#Filename: lib3.sh
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
echo "SECURITY"
echo "------------------------------------------------------"

#------------------------------------------------------
#======================================================
# SOURCE FUNCTIONS
#======================================================

source "${PWD%/}"/scriptBase/lib/varFunc.sh

#------------------------------------------------------
#======================================================
# USER MENU
#======================================================

echo "

1) Install ClamAV.
2) Install rootkit detector packages.
3) Install fail2ban. (Disabled, broken in this release.)
4) Put root account into lockdown mode.
5) Unlock root account / disable lockdown mode.

0) Return to Main Menu.

Select one: 
"

read userOpt

case $userOpt in
 	1 )
		clamav_install
		wait4user 
		bash "${PWD%/}"/scriptBase/lib/lib3.sh
 		;;

 	2 )
		rootkit_install
		wait4user 
		bash "${PWD%/}"/scriptBase/lib/lib3.sh
 		;;
 	3)
		#fail2ban_install
		echo -e "$ERROR""This feature is broken during this release therefore it has been disabled.""$END"
		wait4user 
		bash "${PWD%/}"/scriptBase/lib/lib3.sh
		;;
	4)
		root_acc_on
		wait4user 
		bash "${PWD%/}"/scriptBase/lib/lib3.sh
		;;

	5)
		root_acc_off
		wait4user 
		bash "${PWD%/}"/scriptBase/lib/lib3.sh
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
					bash "${PWD%/}"/scriptBase/lib/lib3.sh
					;;
				Y) 
					bash "${PWD%/}"/scriptBase/lib/lib3.sh
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