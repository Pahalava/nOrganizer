import logging
import os
from shutil import copyfile

logging.basicConfig(level=logging.INFO, format='%(asctime)s %(levelname)s: %(message)s',
                    datefmt='%d-%b-%Y %I:%M:%S %p')
SCAN_DIR = "_unsorted"


class Organizer:
    """Helps to get base details and some base functions for Organizer"""

    def __init__(self, resource_folder, root_folder, data_type, data_subtype=None, file_ext=".xlsx"):
        self.resource_folder = resource_folder
        self.root_folder = root_folder if root_folder is not None else __file__
        self.data_type = data_type
        self.data_subtype = data_subtype
        self.file_ext = file_ext

    def get_resource_metadata(self, is_directory=True):
        result = self.resource_folder
        if is_directory:
            logging.debug("Resource Directory: {0}".format(result))
            return result
        result += "\\" + self.data_type
        if self.data_subtype is not None:
            result += "_" + self.data_subtype
        result += self.file_ext
        logging.debug("Resource Meta-file: {0}".format(result))
        return result

    def get_base_metadata(self, is_directory=True):
        result = self.root_folder + "\\" + self.data_type + "\\." + self.data_type.lower()
        if is_directory:
            logging.debug("Base Directory: {0}".format(result))
            return result
        result += "\\" + self.data_type
        if self.data_subtype is not None:
            result += "_" + self.data_subtype
        result += self.file_ext
        logging.debug("Base Meta-file: {0}".format(result))
        return result

    def get_root_directory(self):
        result = self.root_folder
        logging.debug("Root Directory: {0}".format(result))
        return result

    def get_sub_base_directory(self):
        result = self.root_folder + "\\" + self.data_type
        if self.data_subtype is not None:
            result += "\\" + self.data_subtype
        logging.debug("Sub-base Directory: {0}".format(result))
        return result

    def get_scan_directory(self):
        result = Organizer.get_sub_base_directory(self) + "\\" + SCAN_DIR
        logging.debug("Scan directory: {0}".format(result))
        return result

    @staticmethod
    def is_file_exists(self, file, is_directory=True):
        if is_directory:
            return os.path.isdir(file)
        return os.path.isfile(file)

    def create_folders(self, folders):
        if Organizer.is_file_exists(self, Organizer.get_sub_base_directory(self)):
            logging.info("Base folder exists at {0}".format(Organizer.get_sub_base_directory(self)))
        else:
            os.makedirs(Organizer.get_sub_base_directory(self), exist_ok=True)
            logging.info("Base folder created at {0}".format(Organizer.get_sub_base_directory(self)))
        os.chdir(Organizer.get_sub_base_directory(self))
        file_counter = 0
        for folder in folders:
            try:
                os.makedirs(folder, exist_ok=True)
                file_counter += 1
            except OSError as e:
                print("Error occurred for", folder, ": ", e.args)
        logging.info("{0} of {1} folders created!".format(file_counter, len(folders)))

    def validate_master_file(self):
        if Organizer.is_file_exists(self, Organizer.get_base_metadata(self, False), False):
            logging.info("Master file exists at {0}".format(Organizer.get_base_metadata(self, False)))
        else:
            if Organizer.is_file_exists(self, Organizer.get_resource_metadata(self, False), False):
                os.makedirs(Organizer.get_base_metadata(self), exist_ok=True)
                copyfile(Organizer.get_resource_metadata(self, False), Organizer.get_base_metadata(self, False))
                logging.info("Metafile created at {0}".format(Organizer.get_base_metadata(self, False)))
            else:
                logging.error(
                    "Resource, {0}, master template is not available!".format(
                        Organizer.get_resource_metadata(self, False)))

    @staticmethod
    def move_file(self, old_folder, new_folder, old_name, new_name, create_copy=False):
        logging.debug("Moving file {0}\\{1} to {2}\\{3}- creating copy: {4}".format(old_folder, old_name, new_folder,
                                                                                    new_name, create_copy))
        os.makedirs(new_folder, exist_ok=True)
        if create_copy:
            copyfile(old_folder + '\\' + old_name, new_folder + '\\' + new_name)
            logging.info("Copied {0}\\{1} to {2}\\{3}".format(old_folder, old_name, new_folder, new_name))
        else:
            os.rename(old_folder + '\\' + old_name, new_folder + '\\' + new_name)
            logging.info("Moved {0}\\{1} to {2}\\{3}".format(old_folder, old_name, new_folder, new_name))

    @staticmethod
    def is_in_char_range(c0, c1, c2):
        return True if c0 in range(ord(c1), ord(c2) + 1) else False
