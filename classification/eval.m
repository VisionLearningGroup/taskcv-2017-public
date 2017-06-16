from __future__ import division 
import numpy as np 
import sys, os, os.path

class categories():
    def __init__(self, names):
        self.names = names
        self.num_cat = len(names)
        self.acceptable_sources = []
        for i in range(len(self.names)):
            self.acceptable_sources.append(i)

        self.truth = np.zeros(self.num_cat)
        self.source = np.zeros(self.num_cat)
        self.adaptation = np.zeros(self.num_cat)
        self.source_accuracy = np.zeros(self.num_cat)
        self.adaptation_accuracy = np.zeros(self.num_cat)

        for i in range(self.num_cat):
            self.truth[i] = 0
            self.source[i] = 0
            self.adaptation[i] = 0
            self.source_accuracy[i] = 0
            self.adaptation_accuracy[i] = 0

        self.mean_source_accuracy = 0
        self.mean_adaptation_accuracy = 0


def classification_evaluation(truth_file,source_file,adaptation_file,output_file):

    category_names = ['airplane', 'bicycle', 'bus', 'car', 'horse', 'knife', 'motorcycle', 'person', 'plant', 'skateboard', 'train', 'truck']
    categs = categories(category_names)

    with open(truth_file) as f:
        truth = [x.strip('\n') for x in f.readlines()]
    f.close()

    with open(source_file) as f:
        source = [x.strip('\n') for x in f.readlines()]
    f.close()

    with open(adaptation_file) as f:
        adaptation = [x.strip('\n') for x in f.readlines()]
    f.close()

    if len(source) == 0:
        print 'Error: source file is empty.'
        return
    elif len(adaptation) == 0:
        print 'Erorr: adaptation file is empty.'

    if len(truth) != len(source):
        print 'Error: source file does not contain the same number of elements as truth file.'
        return
    elif len(truth) != len(adaptation):
        print 'Error: adaptation file does not contain the same number of elements as truth file.'
        return

    for idx, category in enumerate(truth):
        truth_category = int(category)
        categs.truth[truth_category] += 1
        source_category = int(source[idx])
        adaptation_category = int(adaptation[idx])
        if source_category not in categs.acceptable_sources:
            print 'Error: source file contains invalid entry. Please check that all category labels are valid and that the file adheres to the specified format for evaluation.'
            return
        elif adaptation_category not in categs.acceptable_sources:
            print 'Error: source file contains invalid entry. Please check that all category labels are valid and that the file adheres to the specified format for evaluation.'
            return

        if source_category == truth_category:
            categs.source[source_category] += 1
        if adaptation_category == truth_category:
            categs.adaptation[adaptation_category] += 1

    for i in range(categs.num_cat):
        if categs.truth[i] != 0:
            categs.source_accuracy[i] = 100*float(categs.source[i]/categs.truth[i])
            categs.adaptation_accuracy[i] = 100*float(categs.adaptation[i]/categs.truth[i])

    categs.mean_source_accuracy = float(np.mean(categs.source_accuracy))
    categs.mean_adaptation_accuracy = float(np.mean(categs.adaptation_accuracy))

    with open(output_file, 'wb') as f:
        f.write('mean accuracy (source): ' + str(categs.mean_source_accuracy) + '\n')
        f.write('mean accuracy (adaptation): ' + str(categs.mean_adaptation_accuracy) + '\n\n')
        for i in range(len(categs.source_accuracy)):
            f.write(categs.names[i] + ' (source): ' + str(categs.source_accuracy[i]) + '\n')
            f.write(categs.names[i] + ' (adaptation): ' + str(categs.adaptation_accuracy[i]) + '\n\n')
    f.close()

if __name__ == '__main__':

    truth_file = 'truth_test.txt'
    source_file = 'source_result_test.txt'
    adaptation_file = 'adaptation_result_test.txt'
    output_file = 'scores_test.txt'

    classification_evaluation(truth_file, source_file, adaptation_file, output_file)