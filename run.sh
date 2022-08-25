#!/bin/bash
#Filename: run.sh
#Version: 1.44
#Creation: Aug 2022
#Author (GitHub): TheProtag0nist
#1508250
#------------------------------------------------------
#======================================================
# SOURCE FUNCTIONS
#======================================================

source "${PWD%/}"/scriptBase/lib/varFunc.sh


#======================================================
# DEBUG FILE ANNOUNCE
#======================================================
clear
echo "------------------------------------------------------"
echo "Welcome "$currentUser". I am run file."
echo "------------------------------------------------------"

#------------------------------------------------------
#======================================================
# USER MENU
#======================================================

echo "
How would you like to run this system hardening tool? 

1) I would like the process to be automatic, requiring minimal input from me.
2) I would like to manually choose my hardening options or make a quick change.


0) I would like to close this script.

Select one: 
"

read userRun

case $userRun in
#------------------------------------------------------
#======================================================
# AUTOMATIC HARDENING OF SYSTEM
#======================================================
 	1 )

# Confirmation that user is happy for reboots.
clear
echo "------------------------------------------------------"
echo "IMPORTANT INFORMATION ABOUT THIS PROCESS"
echo "------------------------------------------------------"
echo "This process consists of more than 1 reboot to apply changes."
echo -e "$WARN""This will be performed automatically.""$END"
echo "
"
echo "While the production of this tool involved product testing, you may still encounter bugs & issues."
echo "If you do encounter bugs / issues, this can be raised via the GitHub repo."
echo "The GitHub repo is there as a source of obtaining the tool & as a way of tracking current bugs."
echo "By confirming the below prompt I can confirm that I have understood the risk of using this tool."
echo -e "$WARN""The author can not provide support if a device becomes unavailable, data lost or other issues arise following the use of the tool.""$END"
echo "
"
echo -e "$WARN" "** Important for Ubuntu Desktop Edition users **" "$END"
echo "Following a reboot you will need to re-open the script & select the automation process again. 
The process will continue onwards once done so."
echo "
"
echo -n "Do you understand the above & wish to continue with using this automated process? [Y / N]"
   	read userConfirm
   		case $userConfirm in
				y) 
   					auto_all
					;;

				Y) 
					auto_all
					;;

				n ) 
					echo "OK, returning back to previous menu...";
					bash "${PWD%/}"/run.sh
					;;
				N ) 
					echo "OK, returning back to previous menu...";
					bash "${PWD%/}"/run.sh
					;;
				* ) 
					echo -e "$ERROR""User response error. Please enter the letter Y or N.""$END"
					;;
   			esac

#		echo "I have done nothing..."
 		;;

#------------------------------------------------------
#======================================================
# OPTION TO USE TOOL MANUALLY
#======================================================

 	2 )
		clear
		bash "${PWD%/}"/scriptBase/core.sh
 		;;
 		
#------------------------------------------------------
#======================================================
# USER VALIDATION & EXIT
#======================================================
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
					clear
					bash "${PWD%/}"/run.sh
					;;
				Y)
					clear
					bash "${PWD%/}"/run.sh
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