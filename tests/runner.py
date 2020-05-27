import subprocess
from shutil import copyfile
from os import listdir
from os.path import isfile, join

class Runner: 

    def __init__(self):
        self.output = "";

    def make_executeable(self):
        self.output += "executing makefile ... \n"
        make = subprocess.check_output(["make"], cwd="../")
        self.output += str(make)
        copyfile("../codea", "copy.out")
        self.output += "\n"

    def load_tests(self):
        p = "autot"
        files = []
        for f in listdir(p):
            fpath = join(p, f)
            if(isfile(fpath)):
                self.output += "\tloading file " + str(fpath) + "\n"
                files += [fpath]
        return files
    
    def run_tests(self):
        files = self.load_tests()
        report = []
        for f in files:
            with open(f) as test_file:
                lines = str.join("\t", test_file.readlines())
                formated = ""
                formated += "\n\tcontents of " + f + ":\n"
                formated += "\t======================= \n "
                formated += "\t" + lines + "\n"
                formated += "\t======================= \n "
                formated += "\tend of " + f + "\n"
                print(lines)
                test_res = self.run_test(lines, f)
                _, typeR = test_res
                if typeR != "SUCCESS":
                    self.output += formated
                report += [test_res]
        
        self.output += "\n\t\t\t   Report\n"
        self.output += "\t\t=============================== \n "

        success = 0
        cnt = 0
        for n, t in report:
            if t == "SUCCESS":
                self.output += "\033[94m"
                success += 1
            elif t == "FAILED":
                self.output += "\033[91m"
            else:
                self.output += "\033[93m"
            
            cnt += 1
            self.output += "\t\t " + n + "\t" + t + "\n"
            self.output += "\033[0m"
        self.output += "\t\t   " + str(success) + " of " + str(cnt) + " passed\n"
        self.output += "\t\t=============================== \n "
        

    def run_test(self, text, filename):
        expected_exit = filename[-1]
        print("running file ...", filename)
        proc = subprocess.Popen(["./copy.out"], stdout=subprocess.PIPE, stdin=subprocess.PIPE)
        try:
            data = proc.communicate(text.encode(), timeout=5)[0].decode()
            formated = ""
            formated += "output of " + filename + "\n"
            formated += str(data)
            formated += "\n\n\t\tEXIT CODE: " + str(proc.returncode) + " EXPECTED: " + str(expected_exit) + "\n"
            if str(proc.returncode) == expected_exit:
                formated += "\t\t SUCCESS!\n\n"
                return (filename, "SUCCESS")
            else:
                self.output += formated
                self.output += "\t\t FAILED! \n\n"
                return (filename, "FAILED")
        except Exception:
            print("timeout while running: ", filename)
            return (filename, "WARNING")
        finally:
            proc.kill()

    def create_out_file(self, text):
        pass

r = Runner()
r.make_executeable()
r.run_tests()
print(r.output)
