import os
import glob
import plistlib

def get_names_paths():
    main_dir = os.path.expanduser('~')
    paths = [glob.glob('/Applications/*.app'),glob.glob('/Applications/**/*.app'),glob.glob(os.path.join(main_dir, '**/*.app'))]
    names_paths = []
    app_names = []
    for folder in paths:
        for file in folder:
            name = str(file).split('/')[-1][:-4]
            if name not in app_names:
                app_names.append(name)
                names_paths.append([name, file])
    return sorted(names_paths, key=lambda x: x[0])

def get_icon(path):
    info = os.path.join(path,'Contents/Info.plist')
    with open(info, 'rb') as file:
        try:
            icon = plistlib.load(file)['CFBundleIconFile']
            if '.icns' not in icon:
                icon += '.icns'
        except:
            return glob.glob(os.path.join(path, 'Contents/Resources/*.icns'))[0]
    return os.path.join(path, 'Contents/Resources', icon)
    
def get_files(name_path):
    main_dir = os.path.expanduser('~')
    path = os.path.join(name_path[1], 'Contents/Info.plist')
    path_found = False
    with open(path, 'rb') as file:
        try:
            BundleID = plistlib.load(file)['CFBundleIdentifier']
            path_found = True
        except:
            pass
    del_files = {'Application Support':[], 'Application Support/CrashReporter':[], 'Application scripts':[], 'Caches':[], 'Containers':[], 'Developer':[], 'Group Containers':[], 'HTTPStorages':[], 'LaunchAgents':[], 'Logs':[], 'Preferences':[], 'Preferences/ByHost':[], 'Receipts':[], 'Saved Application State':[], 'SyncedPreferences':[], 'Temporary Files':[], 'WebKit':[]}
    temp = [set(), set(), set(), set(), set()]
    for f in del_files.keys():
        if path_found:
            bundles = [os.path.join(main_dir, 'Library', f, '*'+BundleID+'*'), os.path.join('/Library', f, '*'+BundleID+'*'), '/var/db/receipts/*'+BundleID+'*', '/private/var/folders/**/**/C/*'+BundleID+'*', '/private/var/folders/**/**/T/*'+BundleID+'*']
            for pos in range (len(bundles)):
                temp[pos] |= set(glob.glob(bundles[pos]))
        case = [name_path[0], name_path[0].lower(), name_path[0].upper()]
        for name in case:
            names = [os.path.join(main_dir, 'Library', f, '*'+name+'*'), os.path.join('/Library', f, '*'+name+'*'), '/var/db/receipts/*'+name+'*', '/private/var/folders/**/**/C/*'+name+'*', '/private/var/folders/**/**/T/*'+name+'*']
            for pos in range (len(names)):
                temp[pos] |= set(glob.glob(names[pos]))
    for file in list(temp[0]):
        folder = file.split('/')[4]
        if folder in del_files:
            del_files[folder].append(file)
    for file in list(temp[1]):
        folder = file.split('/')[2]
        if folder in del_files:
            del_files[folder].append(file)
    del_files['Receipts'] += list(temp[2])
    del_files['Caches'] += list(temp[3])
    del_files['Temporary Files'] += list(temp[4])
    return {folder:files for folder,files in del_files.items() if files}
    
def get_size(path):
    size = 0
    for paths, dirs, files in os.walk(path):
        for f in files:
            file_path = os.path.join(paths, f)
            if not os.path.islink(file_path):
                try:
                    size += os.path.getsize(file_path)
                except:
                    pass
    return size
    
def get_app_size(path, del_files):
    total = 0
    files = sum(del_files.values(), [])
    all_files = files + [path]
    for path in all_files:
        try:
            total += get_size(path)
        except:
            pass
    return total
