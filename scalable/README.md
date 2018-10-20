# Tools - Scalable Computing  
Anything that might help with assignments/practical work for scalable computing.  
Any details for the files in here can be found below.  
  
## john-setup.sh  
Installs dependencies and compiles JohnTheRipper on a fresh ubuntu instance in case any saved images go missing.  
Run this first:  
```
wget https://raw.githubusercontent.com/guineec/college-tools/master/scalable/john-setup.sh && chmod +x john-setup.sh
```   
Then run:
```
./john-setup.sh
```  
... and JtR should be cloned into home and compiled, ready to go.  
  
Optionally, the dependency installations can be skipped (this is useful if running on a local machine that has all dependencies satisfied).  
To do this just pass the no-deps argument:  
```
./setup.sh no-deps
```

## hashcat-setup.sh  
Configures GPU environment for use with hashcat, and attempts to install hashcat on the instance.  Currently only supports Tesla P100 and V100 GPUs. Tested only on ubuntu 16.04, so it may not work with other versions.  
  
To use, just use `wget` the script like this (and make it executable):  
```  
wget https://raw.githubusercontent.com/guineec/college-tools/hashcat-setup/scalable/hashcat-setup.sh
chmod +x hashcat-setup.sh
```  
Then run with `./hashcat-setup.sh`  

      
## jtr-cheat-sheet.pdf
A reference for JohnTheRipper common commands. From [this website](https://countuponsecurity.files.wordpress.com/2016/09/jtr-cheat-sheet.pdf).  
  
  
## results-formatter.py  
**Requires python 3**  
Format results of a hash-cracking exercise to upload to submitty  
USAGE:  
```
python3 results-formatter.py <path-to-.hashes-file> <path-to-potfile>
```  
If you haven't modified anything, your potfile is probably in your `JohnTheRipper/run/` directory, and is named `john.pot`      
Outputs a .broken file with the same name as the passed .hashes file, containing properly formatted results.    

## charlimit.py  
**Requires python 3**  
Search a file line by line and copy all lines whose length in characters matches a given limit into a new file. Can be handy to trim the size of wordlists for use in JtR.    
USAGE:  
```
python3 charlimit.py <path-to-wordlist.txt> <limit>
```    
**NOTE:** This will take some time to run on large files, but a lot of the time it will significantly decrease the wordlist.    
  
    
## compound_words.py  
**Requires python 3**  
Take a list of words and output all possible permutations of that list.  
USAGE:  
```  
python3 compound_words.py [options] <path-to-wordlist.txt>  
```  
***NOTE:*** Again, this will take some time to run on larger lists.  
  
## Potfile Watcher Server  
Sets up a server for use with the pot file watcher service. Allows multiple instances to run john/hashcat and write to the same potfile by posting
changes to this server which will run on one of your instances.  
Source for this can be found in the centralize-potfile directory. It's a simple, not very secure php scipt but it gets the job done.  
To run the one step setup do the following:
```  
wget https://raw.githubusercontent.com/guineec/college-tools/master/scalable/pot-watch-server-setup.sh  
chmod +x pot-watch-server-setup.sh  
./pot-watch-server-setup.sh
```  
This will attempt to install dependencies and start the ubuntu apache server.  
Alternatively, grab the source from the centralize-potfile directory and modify/serve however you see fit.  
  
If setup using the script, the combined potfiles will be located in /var/www/html/centralize-potfile/ directory. Alternatively, they can be accessed at http://your-instance-IP/centralize-potfile/index.php where a list of all available files is made for download.      
  
To add a custom potfile, copy & rename the combined.php script and modify the POTFILE_NAME constant inside the script to a the desired new potfile's name, and POST to /your-new-name.php instead of /combined.php from the watcher. 
  
**NOTE** This isn't 100% guaranteed to work, so don't use its potfile as a source for john/hashcat. Inspect it, make sure it's ok, make a copy and use that!  
  
## Potfile watcher  
The client service for the potfile watcher. Watches the provided potfile for changes, and posts new entries to the server (which is setup by following the instructions above).  
  
To setup the watcher environment, run the following commands:  
```  
wget https://raw.githubusercontent.com/guineec/college-tools/master/scalable/pot-watcher-setup.sh
chmod +x pot-watcher-setup.sh
./pot-watcher-setup.sh
```  
This will copy the script files to the ~/watcher directory and install the pip dependencies required to run the watcher.  
  
The watcher script can then be run as follows:  
```  
python3 ~/watcher/watcher.py <POST_URL> <potfile_dir> <potfile_path>
```    
Where:  
 - POST_URL is the url to post changes to - i.e. http://your-instance-IP/centralize-potfile/combined.php  
 - potfile-dir is the path to the directory that contains the potfile  
 - potfile-path is the filepath of the potfile to watch.  
