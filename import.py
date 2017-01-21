import os
import sys
import glob
import grass.script as grass

def import_tifs(dirpath):
    for dirpath, dirname, filenames in os.walk(dirpath):
        for tif_file in filenames:
            if tif_file.lower().endswith('.tif') or tif_file.lower().endswith('.img'):
                full_path = os.path.join(dirpath, tif_file)
                grass.message('Importing %s -> %s@%s...' % (full_path, tif_file, dirpath))
                grass.run_command('r.in.gdal',input = full_path, output = tif_file[:-4])

def main():
    if len(sys.argv) == 1:
        for directory in filter(os.path.isdir, os.listdir(os.getcwd())):
            import_tifs(directory)
    else:
        import_tifs(sys.argv[1])

if __name__ == "__main__":
    main()
