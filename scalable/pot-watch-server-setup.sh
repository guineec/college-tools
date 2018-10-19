#!/usr/bin/env bash

# Perform update/upgrade cycle
printf "Performing update/upgrade\n"
sudo apt-get update && sudo apt-get upgrade
code=$?
if [ "$code" != "0" ]; then
	printf "UPDATE CYCLE FAILED WITH CODE $code\n"
	printf "Run manually and try again.\n"
	exit 10
fi

# Check what deps are installed and install missing ones
printf "Checking/installing required dependencies...\n"
deps=("apache2", "git", "php")
for dep in ${deps[@]}
do
	command -v $dep
	code=$?
	if [ "$code" != "0" ]; then
		printf "$dep not installed. Installing...\n"
		if [ "$dep" == $"php" ]; then
			sudo apt-get install php7.2
			code=$?
			if [ "$code" != "0" ]; then
				printf "$dep could not be installed. Try installing manually.\n"
				printf "Aborting...\n"
				exit 11
			fi
		else
			sudo apt-get install "$dep"
			code=$?
			if [ "$code" != "0" ]; then
				printf "$dep could not be installed. Try installing manually.\n"
				printf "Aborting...\n"
				exit 11
		fi
	fi
printf "DONE\n"

# With the deps installed, get the required files
printf "Cloning server files...\n"
git clone https://github.com/guineec/college-tools.git # Stupid, but I'm too lazy to create a separate repo
code=$?
if ["$code" != "0" ]; then
	printf "Couldn't clone required repo. Try cloning it manually.\n"
	printf "Aborting...\n"
	# Clean up anything that was cloned
	if [ -d "./college-tools" ]; then
		rm -rf college-tools
	fi
	exit 12
fi
printf "DONE\n"

# ...and move them to the correct location
printf "Moving files to apache root...\n"
sudo mv college-tools/scalable/centralize-potfile /var/www/html/
code=$?
if [ "$code" != "0" ]; then
	printf "Couldn't move files to /var/www/html. Check apache2 correctly installed and that this dir exists.\n"
	printf "Aborting...\n"
	# Clean up again...
	if [ -d "./college-tools" ]; then
		rm -rf college-tools
	fi
	exit 13
fi
printf "DONE\n"

# Reset apache just in case...
printf "Stop/restarting apache server...\n"
sudo service apache2 stop
sudo service apache2 start
code=$?
if [ "$code" != "0" ]; then
	printf "Couldn't restart apache.\n"
	printf "Try running sudo apache2 stop && sudo apache2 start manually.\n"
	printf "Alternatively, google how to restart apache for your specific distro and do that!\n"
fi
printf "DONE\n"

# Clean up for the final time...
printf "Cleaning up...\n"
rm -rf college-tools
printf "DONE\n"

printf "Server setup complete.\n"
printf "Default configuration will write entries to the file /var/www/html/centralized-potfile/combined.pot\n"
printf "Entries can be added by POSTing to <your-instance-ip>/centralized-potfile/combined.php?entry=<hash>:<password>\n"
printf "To write entries to a different potfile, copy the combined.php file and rename it, then edit the POTFILE_NAME constant in the php code to the path of the desired potfile\n"
printf "After doing this, POSTing to <your-instance-ip>/centralized-potfile/<renamed-copy-name>.php?entry=<hash>:<password> will write to your custom potfile.\n"

printf "This has no guarantee of working properly so don't rely on it for saving your potfiles to be submitted.\n"

