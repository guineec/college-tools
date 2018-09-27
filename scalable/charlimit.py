import sys

if len(sys.argv) != 3:
  sys.stderr.write("ERROR: Invalid number of arguments!\n")
  sys.stderr.write("Usage: python charlimit.py <path-to-wordlist> <char-limit>\n")
  sys.exit(11)

pname, fp, limit = sys.argv
outfile = fp.replace(".txt", "") + "_limit_" + limit + ".txt"

with open(fp, "r") as f, open(outfile, "w+") as of:
  lines = 0
  occurences = 0
  for line in f:
    if len(line.rstrip()) == 8:
      of.write(line)
      print("Lines processed: " + str(lines))
      print(str(limit) + " character lines: " + str(occurences))
    
    lines += 1