import os
import glob

def add_folders(dirs):
    temp = []
    for x in glob.glob(dirs):
        if get_file_size(x) != 0:
            temp.append([x.split('/')[-1], x])
    return temp

def get_folders():
    main_dir = os.path.expanduser('~')

    cache = [["",""]]
    cache_dirs = [os.path.join(main_dir,'Library/Caches/*'), '/private/var/folders/**/**/C/*']
    for folder in glob.glob(os.path.join(main_dir, 'Library/Containers/**/Data/Library/Caches')):
        if len(glob.glob(folder+'/*')) != 0:
            cache.append([folder.split('/')[5], folder])
    for dirs in cache_dirs:
        cache += add_folders(dirs)

    logs = [["",""]]
    logs_dirs = [os.path.join(main_dir,'Library/Logs/*'), '/Library/Logs/*']
    for dirs in logs_dirs:
        logs += add_folders(dirs)
    
    temp_files = [["",""]]
    temp_files += add_folders('/private/var/folders/**/**/T/*')

    disk_images = [["",""]]
    disk_dirs = [os.path.join(main_dir, 'Documents'),os.path.join(main_dir, 'Downloads'), os.path.join(main_dir, 'Desktop')]
    for d in disk_dirs:
        for paths, dirs, files in os.walk(d):
            for f in files:
                if f[-4:] == '.dmg':
                    disk_images.append([f.split('/')[-1], os.path.join(paths, f)])

    xcode_junk = [["",""]]
    xcode_dirs = [os.path.join(main_dir, 'Library/Developer/Xcode/DerivedData/*'), os.path.join(main_dir, 'Library/Developer/CoreSimulator/Caches/*')]
    for dirs in xcode_dirs:
        xcode_junk += add_folders(dirs)

    trash = [["",""]]
    trash += add_folders(os.path.join(main_dir,'.Trash/*'))

    folders = {'Cache Files':cache, 'Logs':logs, 'Temp Files':temp_files, 'Unused Disk Images':disk_images, 'Trash':trash, 'Xcode Junk':xcode_junk}
    for x in folders.keys():
        if len(folders[x]) != 1:
            folders[x] = folders[x][1:]
        folders[x].sort()
        
    return folders

def get_dir_size(file):
    total = 0
    total += get_file_size(file)
    if glob.glob(file+'/*') != []:
        for paths, dirs, files in os.walk(file):
            for f in files:
                file_path = os.path.join(paths, f)
                if not os.path.islink(file_path):
                    try:
                        total += os.path.getsize(file_path)
                    except:
                        pass
    return total
    
def get_file_size(file):
    try:
        return os.path.getsize(file)
    except:
        return 0

        


