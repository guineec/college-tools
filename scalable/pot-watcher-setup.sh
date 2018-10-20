#!/usr/bin/env bash

# Installs python 3 and all pip dependencies required for the watcher.py

# Perform update/upgrade cycle
printf "Performing upgrade/update cycle...\n"
sudo apt-get update && sudo apt-get upgrade
code=$?
if [ $code -ne 0 ]; then
  printf "UPGRADE CYCLE EXITED WITH CODE $code\n"
  printf "This is an error, try running manually.\n"
  printf "Aborting...\n"
  exit 10
fi
printf "DONE\n"

# Check for/install required deps
printf "Installing required dependencies...\n"
deps=("git" "python3")
for dep in ${deps[@]}
do
  command -v "$dep"
  code=$?
  if [ $code -ne 0 ]; then
    if [ "$dep" == "git" ]; then
      dep="git-all"
    fi
    sudo apt-get install "$dep"
    code=$?
    if [ $code -ne 0 ]; then
      printf "Error installing dependency $dep\n"
      printf "Try installing manually.\n"
      printf "Aborting...\n"
      exit 11
    fi
  else
    printf "Dependency $dep already satisfied, skipping.\n"
  fi
done
printf "DONE\n"

# With the deps installed, get the required files
printf "Cloning server files...\n"
git clone https://github.com/guineec/college-tools.git # Stupid, but I'm too lazy to create a separate repo
code=$?
if [ $code -ne 0 ]; then
	printf "Couldn't clone required repo. Try cloning it manually.\n"
	printf "Aborting...\n"
	# Clean up anything that was cloned
	if [ -d "./college-tools" ]; then
		rm -rf college-tools
	fi
	exit 12
fi
printf "DONE\n"

# ...and do what's needed with the files
mv college-tools/scalable/watcher ~/
code=$?
if [ $code -ne 0 ]; then
	printf "Couldn't put watcher files in home."
	printf "Aborting...\n"
	# Clean up again...
	if [ -d "./college-tools" ]; then
		rm -rf college-tools
	fi
	exit 13
fi

# Now do the pip install
printf "Inatalling pip dependencies...\n"
sudo python3 -m pip -r ~/watcher/requirements.txt 
code=$?
if [ $code -ne 0 ]; then
  printf "pip dependencies could not be installed.\n"
  printf "Try manually running 'sudo python3 -m pip install ~/watcher/requirements.txt'\n"
  printf "Install finished with errors.\n"
  # Clean up again...
	if [ -d "./college-tools" ]; then
		rm -rf college-tools
	fi
  exit 14
fi
printf "DONE.\n"

# Finish up
printf "Cleaning up...\n"
if [ -d "./college-tools" ]; then
		rm -rf college-tools
fi
printf "DONE\n"

printf "Watcher setup complete\n"
printf "Usage - python3 watcher/watcher.py <post-url> <potfile-directory> <full-potfile-path>\n"
printf "Where <post=url> is the url to post new entries to - i.e. http://0.0.0.0/centralized-potfile/combined.php\n"
printf "      <potfile-directory> is the full path of the directory containing the potfile to watch\n"
printf "      <full-potfile-path> is the full path to the .pot file to watch\n"
printf "Run python3 watcher/watcher.py -h for more help\n" 