import subprocess
from shutil import copyfile
from os import listdir
from os.path import isfile, join

class TestRunner:

    def __init__(self):
        self.loaded_files = self.load_tests()
        self.make_executeable()

    def make_executeable(self):
        make = subprocess.check_output(["make"], cwd="../")
        copyfile("../a.out", "copy.out")

    def load_tests(self):
        p = "autot"
        files = dict()
        for f in listdir(p):
            fpath = join(p, f)
            if(isfile(fpath)):
                files[f[:-2]] = fpath
        return files

    def nth_file(self, n):
        return self.loaded_files[sorted(self.loaded_files.keys())[n-1]]

    def display_files(self):
        i = 1
        for k, v in self.loaded_files.items():
            print("\t", i, k)
            i += 1
        
    def content(self, n):
        file = self.nth_file(n)
        with open(file) as f:
            text = str.join("\t", f.readlines())
            print(text)

    def run_test(self, file_or_num):
        file = None
        try:
            file = self.nth_file(int(file_or_num))
        except Exception:
            file = self.loaded_files[file_or_num]
            pass
        with open(file) as f:
            text = str.join("\t", f.readlines())
            print("running:")
            print(text)
            try:
                proc = subprocess.Popen(["./copy.out"], stdout=subprocess.PIPE, stdin=subprocess.PIPE, stderr=subprocess.PIPE)
                data, err = proc.communicate(text.encode(), timeout=15)
                rt_code = proc.returncode
                print("\n", "-" * 40)
                print("\nOUT:\n ", data.decode())
                print("\nERR:\n", err.decode())
                print("exit: ", rt_code)
            finally:
                proc.kill()
    
    def io(self):
        while True:
            try:
                print(">> type exit to close or disp to show files, use run <filenumber> or run <name> to run a program use show <num> do display content")
                i = input()
                if i.startswith("disp"):
                    self.display_files()
                elif i.startswith("show"):
                    c = i[4:].strip()
                    self.content(int(c))
                elif i.startswith("run"):
                    c = i[3:].strip()
                    self.run_test(c)
                elif i == "exit":
                    exit(0)
            except Exception as e:
                print("error while executing command", e)



TestRunner().io()