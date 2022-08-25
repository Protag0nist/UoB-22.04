#!/bin/bash
#Filename: lib4.sh
#Version: 1.71
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
echo "DOCUMENTATION & AUDITING"
echo "------------------------------------------------------"
#------------------------------------------------------
#======================================================
# USER MENU
#======================================================

echo "
Documentation & Auditing

1) Save Command History to My Documents.
2) Open list of currently installed packages.
3) Run scan for known Ubuntu vulnerabilities.
4) Create brief system documentation.
5) Conduct a security audit with lynis (Open-source audit tool).

0) Return to Main Menu.

Select one: 
"

read userOpt

case $userOpt in
 	1 )
		save_cmds
		clear
		echo -e "$INFO""Command history has been saved in ${HOME}/Documents/history_"$dateTime".txt.""$END"
		wait4user
		bash "${PWD%/}"/scriptBase/lib/lib4.sh
 		;;

 	2) 
		installed_apps
		;;

	3)
		clear
		check_cve
		wait4user
		bash "${PWD%/}"/scriptBase/lib/lib4.sh
		;;

	4)
		clear
		create_sys_doc
		echo -e "$INFO""Documentation file saved to "$log_location"/"$currentHost"-documentation_"$dateTime".txt""$END"
		wait4user
		bash "${PWD%/}"/scriptBase/lib/lib4.sh
		;;
	5)
		clear
		lynis_check
		wait4user
		bash "${PWD%/}"/scriptBase/lib/lib4.sh
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
					bash "${PWD%/}"/scriptBase/lib/lib4.sh
					;;
				Y) 
					bash "${PWD%/}"/scriptBase/lib/lib4.sh
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

