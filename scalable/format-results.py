import os
import sys

if len(sys.argv) < 3:
    sys.stderr.write("Error: No password hash or pot file provided!\n")
    sys.exit(11)

# Use JtR show to get the cracked passwords
print("Getting cracked passwords...", end=" ")
hash_path = sys.argv[1]
pot_path = sys.argv[2]
wd = os.getcwd()
output_path = wd + "/" + hash_path.replace(".hashes", ".broken")
print("done.")

# Begin formatting
print("Generating output...", end=" ")

print("done.")
print("Output file " + hash_path.replace(".hashes", ".broken") + " generated.")

with open(output_path, "w+") as of, open(pot_path, "r") as potf:
    for line in potf:
        formatted_line = line.replace(":", " ")
        of.write(formatted_line)

print("Formatted output written.")
print("File " + hash_path.replace(".hashes", ".broken") + " ready for submission.")
