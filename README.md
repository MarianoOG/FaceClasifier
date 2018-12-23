# FACE CLASIFIER

The objective of the project is to use an Artificial Neural Network to classify between photos of two male subjects. We extracted features of the subject’s eyes, nose and mouth using Minimum Eigenvalue Algorithm to extract the corner points. Then, this information is reduced to a vector that will be used as an input for the Artificial Neural Network Training and Classification.

## How to use it?

Follow this steps:

1. Clone this repository.
2. Run the *main.m* file using *src* as the current folder in Matlab.
3. Chose the desired image from *img* folder.
4. Visualize the results.

## How is it structured?

In the general the program is divided in the following files and folders:

* [Data](data): Contains *Subject0.mat* & *Subject1.mat* Matlab databases that have the data of extracted features of the corresponding subject images.
* [Images](img): Contains the images used in this program it has two subfolders named *Subject0* and *Subject1* with two hundred image files that are photos of each subject.
  * NOTE: The original set of images are from the MIT and can be found [here](http://cbcl.mit.edu/software-datasets/heisele/facerecognition-database.html).
* [Output](out): with the *net.mat* file that is a Matlab database containing the ANN created by *neuralNetworkTraining.m* the folder also contains a net92.mat file that is a copy of Matlab database containing the best ANN obtained with 92.8% of accuracy.
* [Source Code](src): it has the following functions and scripts.
  * createFeatureDatabase.m: Matlab Script that creates Subject0.mat and Subject1.mat files using featureExtraction.m function iteratively over all the images of each subject.
  * *extractObject.m*: Matlab function that can extract the portion of an image containing a face, mouth or eyes.
  * *featureExtraction.m*: Matlab function that can calculate the features of one particular image.
  * *main.m*: Main Matlab Script that shows how the neural network can be used for classification.
  * *neuralNetworkTraining.m*: Matlab Script that creates, trains and saves the ANN.
  * *processImages.m*: Matlab Script that changes the format of the images from .pgm to .jpg and renames in ascendant order for each subject.

## How it works?

The program has 4 main stages, preprocessing, feature extraction, training and classification. This stages are described below.

### Preprocessing

The original images where converted from .pgm to .jpg extension. This change, along with the renaming makes the further processing easier and faster since iterations can be done in a straight way. We also eliminate some not needed information from the original files metadata.

### Feature extraction

This is made in the following way:

1.  First, we find the eyes, nose and mouth using the CascadeObjectDetector function from the vision toolbox of Matlab.
2.  Then, we extract the Minimum Eigenvalue corner points of each of this sections of the face.
3.  We combine this results in the original image.
4.  After this, we create a new image using this points and their Metric.
5.  We resize this image to 10 by 10 pixels in order to process less data in the training of the NN.
6.  The next thing to do is convert this matrix into a vector of 100 elements.
7.  The final vector will be the normalized version of the previous one that is calculated by dividing the vector by the maximum value of it.

### Training Neural Network

For training to be done properly we divide the data set in the following way:
* 70% (140 images of each subject) for training,
* 15% (30 images of each subject) for validation and,
* 15% (30 images of each subject) for testing.

We used 20 layers of hidden neurons in a Feed Forward Neural Network.

### Classification

We can test over any image of the dataset our trained NN to obtain a classification. The program will display your current image, its parts (eyes, nose and mouth) and the corner points along with the percentage of certainty of the classification.

## What results did we obtained?

We got a 92.8% overall accuracy in our best result. From the confusion matrix we can see that Subject0 will be classified correctly 94.5% of the times and 91% of the times for a Subject1.

## License

This work is under the [MIT License](LICENSE).
