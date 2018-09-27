import os
import sys

if len(sys.argv) < 2:
    sys.stderr.write("Error: No password hash file provided!\n")
    sys.exit(11)

# Use JtR show to get the cracked passwords
print("Getting cracked passwords...", end=" ")
hash_path = sys.argv[1]
wd = os.getcwd()
output_path = wd + "/" + hash_path.replace(".hashes", ".broken")
os.system("~/code/JohnTheRipper/run/john --show " + hash_path + "> " + output_path)
print("done.")

# Begin formatting
print("Generating output...", end=" ")
with open(output_path, "r+") as outf, open(hash_path, "r") as hashf:
    formatted_output = ""
    hashes = hashf.readlines()
    outlines = outf.readlines()
    index = 0
    for line in outlines:
        curr_hash = hashes[index].rstrip()
        line = line.replace("?:", "")
        if index != len(outlines) - 1 and index != len(outlines) - 2:
            formatted_output = formatted_output + curr_hash + " " + line
        index += 1
    
    outf.seek(0)
    outf.write(formatted_output)
    outf.close()
    hashf.close()

print("done.")
print("Output file " + hash_path.replace(".hashes", ".broken") + " generated.")

