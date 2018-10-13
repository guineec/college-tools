import argparse
import itertools

ap = argparse.ArgumentParser()
ap.add_argument("wordsfile", type=str, help="File containing words to compound")
ap.add_argument("--output", type=str, required=False, help="Output file path")
ap.add_argument("--delim", type=str, required=False, help="Delimiter in input file that splits individual words.")
args = ap.parse_args()

outfile = ""
if args.output:
  outfile = args.output
else:
  outfile = args.wordsfile + ".compounded"

delim = args.delim if args.delim else " "
wordf = args.wordsfile
words = []

with open(wordf, "r") as f:
  file_contents = f.read()
  words = file_contents.split(delim)
  for i in range(0, len(words) - 1):
    words[i] = words[i].strip()

with open(outfile, "w") as f:
  compounds = list(itertools.permutations(words))
  print(compounds)
