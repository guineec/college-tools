# Tools - Scalable Computing  
Anything that might help with assignments/practical work for scalable computing.  
Any details for the files in here can be found below.  
  
## setup.sh  
Installs dependencies and compiles JohnTheRipper on a fresh ubuntu instance in case any saved images go missing.  
Run this first:  
```
wget https://raw.githubusercontent.com/guineec/college-tools/master/scalable/setup.sh && chmod +x setup.sh
```   
Then run:
```
./setup.sh
```  
... and JtR should be cloned into home and compiled, ready to go.  
  
Optionally, the dependency installations can be skipped (this is useful if running on a local machine that has all dependencies satisfied).  
To do this just pass the no-deps argument:  
```
./setup.sh no-deps
```
    
## jtr-cheat-sheet.pdf
A reference for JohnTheRipper common commands. From [this website](https://countuponsecurity.files.wordpress.com/2016/09/jtr-cheat-sheet.pdf).  
  
  
## results-formatter.py  
**Requires python 3**  
Format results of a hash-cracking exercise to upload to submitty  
USAGE:  
```
python3 results-formatter.py <path-to-.hashes-file> <path-to-potfile>
```  
If you haven't modified anything, your potfile is probably in your JohnTheRipper/run/ folder, and is named john.pot    
Outputs a .broken file with the same name as the passed .hashes file, containing properly formatted results.    

## charlimit.py  
**Requires python 3**  
Search a file line by line and copy all lines whose length in characters matches a given limit into a new file. Can be handy to trim the size of wordlists for use in JtR.    
USAGE:  
```
python3 charlimit.py <path-to-wordlist.txt> <limit>
```    
**NOTE:** This will take some time to run on large files, but a lot of the time it will significantly decrease the wordlist.    
