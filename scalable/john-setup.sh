#!/usr/bin/env bash

get_deps=1

if [ "$1" = "no-deps" ]; then
  printf " --> no-deps: script will skip dependency installation.\n"
  get_deps=0
fi

# Get the JtR jumbo version repo
printf "Cloning JohnTheRipper... "
mkdir ~/code/
cd ~/code/
git clone https://github.com/magnumripper/JohnTheRipper.git &> /dev/null
CODE=$?
if (test $CODE -ne 0)
then
  printf "\nJohnTheRipper repo couldn't be cloned.\n"
  printf "Command 'git clone' exited with code $CODE\n"
  printf "Try running 'git clone https://github.com/magnumripper/JohnTheRipper.git' manually and checking errors.\n"
  printf "Exiting.\n"
  exit $CODE
fi
cd ../
printf "done.\n"

# Install the dependencies for JtR compilation unless no-deps argument passed
# (or at least the ones I had to install the first time)
if [ $get_deps -eq 1 ]; then
  printf "\nInstalling dependencies...\n"
  deps=(gcc libssl-dev make)
  for dep in ${deps[@]}
  do
    printf " - Attempting to install dependency $dep.\n"
    sudo apt-get install $dep
    CODE=$?
    if (test $CODE -ne 0)
    then
      printf "\n - Error installing dependency $dep.\n"
      printf " - apt-get install failed.\n"
      printf "Exiting.\n"
      exit $CODE
    fi
  done
fi

# Run JtR compile stuff
printf "\n\nCompiling JohnTheRipper... (showing output)\n"
cd ~/code/JohnTheRipper/src/
./configure && make
CODE=$?
if (test $CODE -ne 0)
then
  printf "Error compiling JohnTheRipper.\n"
  printf "Go to https://github.com/magnumripper/JohnTheRipper/blob/bleeding-jumbo/doc/INSTALL for manual compilation instructions."
  printf "Exiting.\n"
  exit $CODE
fi
cd
printf "\nJohnTheRipper compiled.\n"
printf "Read https://github.com/magnumripper/JohnTheRipper/blob/bleeding-jumbo/doc/INSTALL for details and instructions for running JtR.\n"

# That's it
printf "\nSetup complete!\n"
