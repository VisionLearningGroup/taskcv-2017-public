#############################################################################
# This file is part of VISDA-17 challenge code for the classification track.
# It calculates the per-category and mean accuracy of your predictions 
# compared to the ground truth.
#
# Please modify the following paths accordingly when you
# call this function:
# 1. ground_truth: path to the ground truth text file
# 2. predictions: path to the text file with your predictions 
#
#############################################################################

from __future__ import division 
import numpy as np 
import sys, os, os.path


class categories():
    def __init__(self, names):
        self.names = names
        self.num_cat = len(names)
        self.acceptable_predictionss = []
        for i in range(len(self.names)):
            self.acceptable_predictionss.append(i)

        self.truth = np.zeros(self.num_cat)
        self.predictions = np.zeros(self.num_cat)
        self.predictions_accuracy = np.zeros(self.num_cat)

        for i in range(self.num_cat):
            self.truth[i] = 0
            self.predictions[i] = 0
            self.predictions_accuracy[i] = 0

        self.mean_predictions_accuracy = 0


###########################################################################
# classification_evaluation 
# 
# inputs: ground_truth.txt and predictions.txt files
#
# output: per-category and mean accuracies printed in 'scores.txt'
#
###########################################################################

def classification_evaluation(ground_truth,predictions):

    category_names = ['aeroplane', 'bicycle', 'bus', 'car', 'horse', 'knife', 'motorcycle', 'person', 'plant', 'skateboard', 'train', 'truck']
    categs = categories(category_names)

    with open(ground_truth) as f:
        truth = [x.strip('\n') for x in f.readlines()]
    f.close()

    with open(predictions) as f:
        predictions = [x.strip('\n') for x in f.readlines()]
    f.close()

    if len(predictions) == 0:
        print 'Error: predictions file is empty.'
        return

    if len(truth) != len(predictions):
        print 'Error: predictions file does not contain the same number of elements as truth file.'
        return

    for idx, category in enumerate(truth):
        truth_category = int(category)
        categs.truth[truth_category] += 1
        predictions_category = int(predictions[idx])

        if predictions_category not in categs.acceptable_predictionss:
            print 'Error: predictions file contains invalid entry. Please check that all category labels are valid and that the file adheres to the specified format for evaluation.'
            return

        if predictions_category == truth_category:
            categs.predictions[truth_category] += 1

    for i in range(categs.num_cat):
        if categs.truth[i] != 0:
            categs.predictions_accuracy[i] = 100*float(categs.predictions[i]/categs.truth[i])

    categs.mean_predictions_accuracy = float(np.mean(categs.predictions_accuracy))

    with open('scores.txt', 'wb') as f:
        f.write('mean accuracy: ' + str(categs.mean_predictions_accuracy) + '\n\n')
        for i in range(len(categs.predictions_accuracy)):
            f.write(categs.names[i] + ': ' + str(categs.predictions_accuracy[i]) + '\n\n')
    f.close()
    

if __name__ == '__main__':

    ground_truth = 'ground_truth.txt'
    predictions = 'predictions.txt'

    classification_evaluation(ground_truth,predictions)
