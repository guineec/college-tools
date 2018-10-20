import argparse
import time
from ChangeHandler import ChangeHandler
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

ap = argparse.ArgumentParser(description="Watches a potfile for changes and sends changes to a centralized potfile")
ap.add_argument("post_url", help="URL to post new entries to.")
ap.add_argument("potfile_directory", help="Path to the directory that contains the potfile to watch.")
ap.add_argument("potfile_name", help="Filename of the potfile")
args = ap.parse_args()

post_url = args.post_url
potfile = args.potfile_directory
pf_name = args.potfile_name

if not post_url.startswith("http://"):
    post_url = "http://" + post_url

handler = ChangeHandler(pf_name, post_url)
observer = Observer()
observer.schedule(handler, path=potfile, recursive=False)
observer.start()

try:
    while True:
        time.sleep(1)
except KeyboardInterrupt:
    observer.stop()
    print("Keyboard interrupt detected. Exiting")
        
    observer.join()

