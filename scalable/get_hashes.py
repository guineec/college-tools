#!/usr/bin/env python3

import requests
import argparse

ap = argparse.ArgumentParser("Get hashes for infernoball assignment from given url")
ap.add_argument("URL", type=str, help="URL from which to get the hashes")
ap.add_argument("-o", "--outfile", type=str, help="Filename to output hashes to")
ap.add_argument("-p", "--print", action="store_true")
args = ap.parse_args()

outfile = ""
if args.outfile:
    outfile = args.outfile
else:
    outfile = args.URL.split("/")[-1] + ".out.hashes"

res = requests.get(args.URL)
js = res.json()

if args.print:
    for h in js['hashes']:
        print(h)
else:
    with open(outfile, "w+") as of:
        for h in js['hashes']:
            of.write(h + "\n")

