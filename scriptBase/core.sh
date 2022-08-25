#!/bin/bash
#Filename: core.sh
#Version: 1.66
#Creation: July 2022
#Author (GitHub): TheProtag0nist
#1508250
#------------------------------------------------------
#======================================================
# SOURCE FUNCTIONS
#======================================================

source scriptBase/lib/varFunc.sh

#------------------------------------------------------
#======================================================
# DEBUG FILE ANNOUNCE
#======================================================

#echo "------------------------------------------------------"
#echo "Welcome "$currentUser". I am core file."
#echo "------------------------------------------------------"

#------------------------------------------------------
#======================================================
# USER MENU
#======================================================

echo "
This is a test menu.

1) Networking Options.
2) System Health & Maintenance.
3) Security.
4) Auditing.

0) Close this script.

Select one: 
"

read userOpt

case $userOpt in
# Loads networking script	
 	1 )
		#clear
		bash "${PWD%/}"/scriptBase/lib/lib1.sh
 		;;

# Loads Maintenance Script
 	2 )
		clear
		bash "${PWD%/}"/scriptBase/lib/lib2.sh
 		;;

# Loads Security Action Script
 	3 )
		clear
		bash "${PWD%/}"/scriptBase/lib/lib3.sh
 		;;
# Loads Script Relating to auditing
 	4 )
		clear
		bash "${PWD%/}"/scriptBase/lib/lib4.sh
 		;;

 		
# Exit the script
 	0 )
		clear
		echo "Goodbye," "$currentUser."" Thank you for using this UoB Tool!"
		exit
 		;;
 	*)
	# Returns an error when user inputs incorrect response.
   		echo -n "Invalid Option. Try again? [Y / N]"
   		read userYN
   			case $userYN in
				y) 
					bash "${PWD%/}"/scriptBase/core.sh
					;;
				Y) 
					bash "${PWD%/}"/scriptBase/core.sh
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