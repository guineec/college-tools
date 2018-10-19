from watchdog.events import FileSystemEventHandler
import requests

class ChangeHandler(FileSystemEventHandler):
    ENDCOL = '\033[0m'
    GREEN = '\033[92m'
    RED = '\033[91m'

    def __init__(self, potfile, url):
        self.potfile = potfile
        self.url = url
        with open(self.potfile, "r") as potf:
            self.potfile_contents = potf.readlines()

    def on_modified(self, event):
        file_changed = event.src_path
        if file_changed == self.potfile:
            print("New entry detected, sending... ", end="")
            new_contents = []
            with open(self.potfile, "r") as potf:
                new_contents = potf.readlines()
            diff = list(set(new_contents) - set(self.potfile_contents))
            self.potfile_contents = new_contents
            for new_entry in diff:
                if new_entry != "\n":
                    data = { "entry": new_entry }
                    res = requests.post(self.url, data=data)
                    if res.status_code == 200:
                        print("%sSUCCESS%s" % (self.GREEN, self.ENDCOL))
                    else:
                        if res.status_code != 303:
                            print("%sFAILED%s" % (self.RED, self.ENDCOL))

