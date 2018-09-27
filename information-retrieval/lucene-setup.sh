#!/usr/bin/env bash

# Get lucene bundle into the current directory
printf "Downloading lucene bundle zip... "
url="http://ftp.heanet.ie/mirrors/www.apache.org/dist/lucene/java/7.5.0/lucene-7.5.0.tgz"
wget $url &> /dev/null
code=$?
if [ $code -ne 0 ]; then
  printf "\nError: wget failed.\n"
  printf "This script uses a fixed mirror to get lucene - this mirror may not exist anymore. Otherwise check exit code.\n"
  printf "MIRROR USED: $url"
  printf "\n\nExiting due to errors.\n"
  exit $code
fi
printf "done.\n"

# Extract the downloaded zip
printf "Extracting files... "
tar -xvzf ./lucene-7.5.0.tgz &> /dev/null
code=$?
if [ $code -ne 0 ]; then
  printf "\nError: tar unzip failed.\n"
  printf "Ensure tar is installed and the zip file downloaded fully and correctly.\n"
  printf "\nExiting due to errors.\n"
  exit $code
fi
printf "done.\n"

# Add required JARs to classpath
printf "Adding entries to CLASSPATH... "
version=7.5.0
current_dir=`pwd`
current_dir="$current_dir"
core_jar_path="$current_dir/lucene-$version/core/lucene-core-$version.jar"
qparser_jar_path="$current_dir/lucene-$version/queryparser/lucene-queryparser-$version.jar"
analyzers_jar_path="$current_dir/lucene-$version/analysis/common/lucene-analyzers-common-$version.jar"
lucene_demo_jar_path="$current_dir/lucene-$version/demo/lucene-demo-$version.jar"
printf $SHELL | grep zsh &> /dev/null
rc_file="$HOME/.zshrc"
code=$?
if [ $code -ne 0 ]; then
  rc_file="$HOME/.bashrc"
fi
cat $rc_file > rc_backup.txt
printf "\n# Add lucene executables to classpath (delete this to reset classpath)\nexport CLASSPATH=$core_jar_path:$qparser_jar_path:$analyzers_jar_path:$lucene_demo_jar_path\n\n" >> $rc_file
printf "done.\n"

# Remove tar package
printf "Cleaning up... "
rm lucene-7.5.0.tgz
printf "done.\n"
printf "Lucene setup complete.\n"

printf "\nThis script has taken care of all the steps before the \"Indexing Files\" section on http://lucene.apache.org/core/7_5_0/demo/overview-summary.html#overview.description\n"
printf "This configuration can be tested by following the next steps at this website. If it has not worked, lucene will need to be removed and manually configured.\n"
printf "\nNOTE: This script has added a global CLASSPATH variable in $rc_file file. If you need to clear the CLASSPATH, just delete the corresponding export statement from $rc_file.\n"
printf "\nJust in case, a backup of your $rc_file before it was edited was made and can be found in this directory at rc_backup.txt.\n"
printf "\nAssuming all went well, you'll need to run the command '. $rc_file' in the terminal window to reload the environment with this new variable.\n"