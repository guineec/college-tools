import sys

if len(sys.argv) != 3:
  sys.stderr.write("ERROR: Invalid number of arguments!\n")
  sys.stderr.write("Usage: python charlimit.py <path-to-wordlist> <char-limit>\n")
  sys.exit(11)

pname, fp, limit = sys.argv
outfile = fp.replace(".txt", "") + "_limit_" + limit + ".txt"

with open(fp, "r", encoding="ISO-8859-1") as f, open(outfile, "w+") as of:
  lines = 0
  occurences = 0
  for line in f:
    if len(line.rstrip()) == 8:
      of.write(line)
      occurences += 1
      print("Lines processed: " + str(lines), end="     \r")
    
    lines += 1

print("\n\nFinished.")
print("Lines read: " + str(lines))
print("Lines of exactly " + str(limit) + " characters: " + str(occurences))
percent = float(occurences) / float(lines)
percent = round(percent, 2)
print("New file size is " + str(percent) + "% of source file size.")

