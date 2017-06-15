import os
import logging

import numpy as np

from adda.data import DatasetGroup
from adda.data.dataset import register_dataset, FilenameDataset

ROOT_DIR = '/scratch/challenge_run/'


@register_dataset('vda2017s')
class VDA2017Synthetic(DatasetGroup):
    num_classes = 12
    base_path = os.path.join(ROOT_DIR, 'vj6')
    file_names = {
        'train-all': 'train_all.txt',
        'train-grey': 'train_grey.txt',
    }

    def __init__(self, path=None, shuffle=True, download=False):
        DatasetGroup.__init__(self, 'vda2017s', path=path, download=False)
        self.image_shape = (384, 216, 3)
        self.label_shape = ()
        self.shuffle = shuffle

        for split in self.file_names.keys():
            with open(os.path.join(self.base_path, self.file_names[split])) as f:
                img_file_names, labels = zip(*[line.split() for line in f.readlines()])

            full_file_names = [os.path.join(self.base_path, x) for x in img_file_names]

            dataset = FilenameDataset(full_file_names, list(map(int, labels)), 'png')
            setattr(self, split, dataset)


@register_dataset('vda2017coco')
class VDA2017Coco(DatasetGroup):
    num_classes = 0  # updated in init
    base_path = os.path.join(ROOT_DIR, 'coco')
    file_names = {
        'train': 'train_all_cat.txt'
    }

    def __init__(self, path=None, shuffle=True, download=False):
        DatasetGroup.__init__(self, 'vda2017coco', path=path, download=False)
        self.image_shape = (None, None, 3)
        self.label_shape = ()
        self.shuffle = shuffle

        for split in self.file_names.keys():
            with open(os.path.join(self.base_path, self.file_names[split])) as f:
                img_file_names, labels = zip(*[line.split() for line in f.readlines()])

            full_file_names = [os.path.join(self.base_path, x) for x in img_file_names]
            int_label_list = list(map(int, labels))
            self.num_classes = max(self.num_classes, np.max(int_label_list)+1)
            dataset = FilenameDataset(full_file_names, int_label_list, 'jpeg')
            setattr(self, split, dataset)

        logging.info('detected %d classes in input data' % self.num_classes)
