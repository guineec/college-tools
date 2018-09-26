# Tools - Information Retrieval and Web Search  
Anything that might make life easier for Information Retrieval and Web Search.  
Details for files in this directory can be found below.  
  
## lucene-setup.sh  
#### Sets up Apache Lucene in the directory from which it is run.  
Currently, this script supports either #### bash or zsh ONLY.  
  
To get the script run:  
```
curl https://raw.githubusercontent.com/guineec/college-tools/master/information-retrieval/lucene-setup.sh > lucene-setup.sh && chmod +x lucene-setup.sh
```  
Then run it with:  
```
./lucene-setup.sh
```  
and finally, run:  
```
. ~/.zshrc
```  
#### OR  
```  
. ~/.bashrc
```  
Depending on which of these two shells you run.  
  
You should then be ready to follow the [official lucene example](http://lucene.apache.org/core/7_5_0/demo/overview-summary.html#overview.description), 
starting from the "Indexing Files" section (this script will take care of all the steps up to this point). If all went well with the script, you should be able
to index and search files by following that guide.  
  
  
### NOTE:  
#### This script will modify your ~/.zshrc or ~/.bashrc file.
A backup of this file is created upon running the script (look for rc_backup.txt)
and can be used to reset your rc file if anything unwanted happens due to this change.  
