#! /usr/bin/python2.7

import os
import argparse

test__folder = "check"

#colored OK and KO
OK = '\033[92mOK\033[0m'
KO = '\033[91mKO\033[0m'
YOK = '\033[93mOK\033[0m'

#argparse
parser = argparse.ArgumentParser(description='test suite.')
parser.add_argument("-a", "--all",\
        help='Execute the test suite on all categories (option by default if\
        none is chosen).',\
        action='store_true')
parser.add_argument("-c", "--categories",\
        help='Display the categories and\
        percentage of successful tests for each\
        of them without displaying the tests.',\
        action='store_true')
parser.add_argument("-f", "--final",\
        help='-f and -final: Display only the\
        percentage of successful tests for all the tests.',\
        action='store_true')
parser.add_argument("-n", "--number",\
        help='Display the number of successful tests on the total number of\
        tests instead of percentage.',\
        action='store_true')
parser.add_argument("-e", "--select",\
        help='Execute the test suite only on the\
        category/ies passed in argument.',
        action='append')
args = parser.parse_args()
os.system("touch " + test__folder + "/err.log")
os.system("make -C test")

#gets the category list
dirs = os.popen("ls " + test__folder + "/tests", "r").read()
dirs = dirs.split("\n")

total_nbtest = 0
total_nbtest_KO = 0
total_nbtest_OK = 0

#foreach category
for test_category in dirs:
    if test_category == "":
        break
    files = os.popen("ls " + test__folder + "/tests/" + test_category,\
                     "r").read()
    files = files.split("\n")

    if args.select != None and not (test_category in args.select):
        continue

    if test_category == "lexer":
        prg = test__folder + "/test_prg/lexer_test "
    else:
        prg = "./42sh -c "

    category_nbtest = 0
    category_nbtest_OK = 0

    #foreach test file
    for test_file in files:
        if test_file == "":
            break

        with open(test__folder + "/tests/" + test_category + "/" + test_file)\
                  as testfile:
            tests = testfile.read()
            tests = tests.split("####\n")

            #for current test
            for test in tests:
                if test == "":
                    break
                test = test.split("--\n", 4)
                test[1] = test[1][:len(test[1]) - 1]
                if test_category == "lexer":
                    stdout = "" + test__folder + "/test_prg/lexer_test '"\
                             + test[1]
                    stdout += "' 2> " + test__folder + "/err.log"
                    stdout = os.popen(stdout, "r").read()
                    stdout = stdout[:len(stdout) - 0]
                elif test_category == "option_parser":
                    stdout = "" + test__folder + "/test_prg/option_test "
                    stdout += test[1] + " 2> " + test__folder + "/err.log"
                    stdout = os.popen(stdout, "r").read()
                elif test_category == "variables":
                    stdout = "echo '" + test[1] + "' | ./42sh 2> " +\
                    test__folder + "/err.log"
                    stdout = os.popen(stdout, "r").read()
                else:
                    stdout = prg + "'" + test[1] + "'"
                    stdout += " 2> " + test__folder + "/err.log"
                    stdout = os.popen(stdout, "r").read()

                ex_out = test[3]

                with open("" + test__folder + "/err.log") as errfile:
                    stderr = errfile.read()

                ret = os.popen("echo $?", "r").read()
                ex_ret = test[2]

                ex_err = test[4]
                test_print = "Category: " + test_category + " Test: " +\
                test[0][:len(test[0]) - 1]

                total_nbtest += 1
                category_nbtest += 1

                if ret == ex_ret and stdout == ex_out and stderr == ex_err:
                    total_nbtest_OK += 1
                    category_nbtest_OK += 1
                    test_print = "[" + OK + "] " + test_print
                else:
                    test_print = "[" + KO + "] " + test_print + " invalid "

                if ret != ex_ret:
                    test_print += "return"
                if stdout != ex_out:
                    test_print += "stdout"
                if stderr != ex_err:
                    test_print += "stderr"

                if (not args.final and not args.categories) or args.all:
                    print(test_print)

    if args.categories:
        if args.number:
            if (100 * category_nbtest_OK / category_nbtest < 40):
                print(test_category + ": %d/%d Tests" % (category_nbtest_OK,\
                      category_nbtest) + " [" + ROK + "]")
            elif (100 * category_nbtest_OK / category_nbtest < 80):
                print(test_category + ": %d/%d Tests" % (category_nbtest_OK,\
                      category_nbtest) + " [" + YOK + "]")
            else:
                print(test_category + ": %d/%d Tests" % (category_nbtest_OK,\
                      category_nbtest) + " [" + OK + "]")
        else :
            if (100 * category_nbtest_OK / category_nbtest < 40):
                 print(test_category + ": %d%%" % (100 * category_nbtest_OK /
                    category_nbtest) + " [" + ROK + "]")
            elif (100 * category_nbtest_OK / category_nbtest < 80):
                print(test_category + ": %d%%" % (100 * category_nbtest_OK /
                    category_nbtest) + " [" + YOK + "]")
            else:
                print(test_category + ": %d%%" % (100 * category_nbtest_OK /
                    category_nbtest) + " [" + OK + "]")

if args.final:
    if (100 * total_nbtest_OK / total_nbtest < 40):
        print("%d%% Tests" % (100 * total_nbtest_OK / total_nbtest)\
              + " [" + ROK + "]")
    elif (100 * total_nbtest_OK / total_nbtest < 80):
        print("%d%% Tests" % (100 * total_nbtest_OK / total_nbtest)\
              + " [" + YOK + "]")
    else:
        print("%d%% Tests" % (100 * total_nbtest_OK / total_nbtest)\
              + " [" + OK + "]")

if args.number:

    if (100 * total_nbtest_OK / total_nbtest < 40):
        print("%d/%d Tests" % (total_nbtest_OK, total_nbtest) +\
                " [" + ROK + "]")
    elif (100 * total_nbtest_OK / total_nbtest < 80):
        print("%d/%d Tests" % (total_nbtest_OK, total_nbtest) +\
                " [" + YOK + "]");
    else:
        print("%d/%d Tests" % (total_nbtest_OK, total_nbtest) +\
                " [" + OK + "]")

os.system("rm -f " + test__folder + "/err.log")
os.system("rm -f " + test__folder + "/testfile")
