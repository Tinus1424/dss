from os.path import isdir

def check_if_path_is_dir(file_name):
    if isdir(file_name):
        return(file_name + " is a directory")
    else:
        print(file_name + " is not a directory")

from os.path import isfile

def check_if_file_exists(file_name):
    if isfile(file_name ):
        return(file_name + " is a file")
    else:
        return(file_name + " is not a file")
    
from os.path import exists

def check_if_path_exists(file_name):
    if exists(file_name):
        return(file_name + " exists")
    else:
        return(file_name + " does not exist")

print(check_if_file_exists("9_pcdata"))
print(check_if_path_exists("9_pcdata"))
print(check_if_path_is_dir("9_pcdata"))
