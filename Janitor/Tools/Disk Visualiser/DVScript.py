import os
import glob

def get_subfolders(path):
    try:
        return glob.glob(path+'/*')
    except:
        return []
    
def get_link(path):
    return os.path.islink(path)

    

