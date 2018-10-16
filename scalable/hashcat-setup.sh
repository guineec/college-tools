#!/usr/bin/env bash

printf "GPU Type: [1]:Tesla P100 [2]:Tesla V100\n"
read -s -n 1 GPU

if [ $GPU = 1  ]; then
	printf "Getting driver... "
	driver_loc="http://us.download.nvidia.com/tesla/396.44/nvidia-diag-driver-local-repo-ubuntu1604-396.44_1.0-1_amd64.deb"
	driver_name="nvidia-diag-driver-local-repo-ubuntu1604-396.44_1.0-1_amd64.deb"
elif [ $GPU = 2  ]; then
	printf "Getting driver... "
	driver_loc="http://us.download.nvidia.com/tesla/396.44/nvidia-diag-driver-local-repo-ubuntu1604-396.44_1.0-1_amd64.deb"
	driver_name="nvidia-diag-driver-local-repo-ubuntu1604-396.44_1.0-1_amd64.deb"
fi

wget -q $driver_loc
code=$?

if [ $code -ne 0  ]; then
	printf "FAILED.\n"
	printf "wget exited with non-zero code $code\n"
	exit $code
fi
printf "DONE.\n"

printf "Running update/upgrade cycle... \n"

sudo apt update
code1=$?
sudo apt upgrade
code2=$?
sudo apt-get install build-essential
code3=$?
sudo apt-get install linux-image-extra-virtual
code4=$?

if [ $code1 -ne 0 ] | [ $code2 -ne 0 ] | [ $code3 -ne 0 ] | [ $code4 -ne 0 ]; then
	printf "FAILURE.\n"
	printf "One or more apt commands exited with non-zero status.\n"
	printf "Try running update/upgrade cycle manually to remedy the problem.\n"
	exit 11
fi

printf "Unpacking driver...\n"
sudo dpkg -i "$driver_name"
code=$?
if [ $code -ne 0 ]; then
	printf "FAILURE.\n"
	exit $code
fi
printf "Unpack complete.\n"
sudo apt-get update
code=$?
if [ $code -ne 0 ]; then
	printf "apt-get update failed, exiting.\n"
	exit $code
fi
sudo apt-get install cuda-drivers
code=$?
if [ $code -ne 0 ]; then
	printf "apt-get install failed, exiting\n"
	exit $code
fi

sudo apt-get install hashcat
code=$?
if [ $code -ne 0 ]; then
	printf "couldn't install hashcat from apt. Try installing manually.\n"
	printf "CONTINUING WITHOUT HASHCAT INSTALL, DRIVERS SHOULD STILL BE INSTALLED.\n"
fi

printf "\nReboot required for install to complete.\n"
printf "\nReboot now? [y]es/[n]o\n"
read -s -n 1 reboot_opt

if [ "$reboot_opt" = "y" ] | [ "$reboot_opt" = "Y" ]; then
	printf "Install complete.\n"
	printf "Rebooting...\n"
	sudo reboot
else
	printf "No reboot option selected.\n"
	printf "Install complete. A reboot is required to finish setup.\n"
	printf "Run `sudo reboot` to finish setup.\n"
fi

