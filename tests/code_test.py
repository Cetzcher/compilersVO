## code tester tool for testing actual created code 
# use //@retrurn in the first line to set expected output
# for example 
# //@return 10 // always returns 10
import subprocess
from shutil import copyfile
from os import listdir
from os.path import isfile, join

def load_tests():
        p = "autot"
        files = []
        for f in listdir(p):
            fpath = join(p, f)
            if(isfile(fpath) and fpath.endswith(".code")):
                files += [fpath]
        return files

def assemble(filepath):
    print("assembling", filepath)
    subprocess.run("./executeable < ./{} > res.s".format(filepath))

def bundle(ccode, link):
    pass
    

def run_single_file(filename): 
    pass

def get_return_code(filetext):
    pass


make = subprocess.check_output(["make"], cwd="../")
copyfile("../codea", "executeable")
files = load_tests()
assemble(files[0])
