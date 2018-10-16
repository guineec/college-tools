import argparse

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

delim = args.delim if args.delim else "\n"
wordf = args.wordsfile
words = []

with open(wordf, "r") as f:
  file_contents = f.read()
  words = file_contents.split(delim)
  for i in range(0, len(words) - 1):
    words[i] = words[i].strip()

with open(outfile, "w") as f:
  for wordi in words:
    for wordj in words:
      comp_wrd = wordi + wordj
      if len(comp_wrd) > len(words[0]):
        f.write(comp_wrd + "\n")
