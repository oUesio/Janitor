import shutil

def get_disk_size():
    temp = shutil.disk_usage("/")
    return [temp[0], temp[0] - temp[2], temp[2]]
