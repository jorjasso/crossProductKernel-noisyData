# Experiments using cross product kernels on fuzzy sets and SVM on PIMA attribute Noise data

## Synopsis

Experiments of the paper: Fuzzy similarity measures between fuzzy sets using kernels on fuzzy sets
Reference:

---
## Prerequisites
* SVM-KM from http://asi.insa-rouen.fr/enseignants/~arakoto/toolbox/  (included)
* MATLAB 2013a for the experiments
* R for the plots
* all the twelve 5-fvc versions of the PIMA noise attribute data set from the Keel repository http://sci2s.ugr.es/keel/attributeNoise.php (pima-5an-nn, pima-10an-nn, etc)

## Code Example

To run an  experiment using the cross product kernels on fuzzy sets (linear, exponential and gaussian) usint the first fuzzification approach described in the paper (fuzz1) on the  clean train - noise test (cn) version of the data with 15% level of noise level type in the MATLAB prompt:

```matlab
      experiments('pima' , 15, 'cn','fuzz1')
```
To run all the experiments using screen run 

```matlab
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 15, 'cn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 20, 'cn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 15, 'cn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 20, 'cn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 15, 'cn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 20, 'cn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 15, 'cn','fuzz4')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 20, 'cn','fuzz4')"
```

## Generating a cvs files with the results
Simply run the MATLAB script
```matlab
testResultsIntoCVS
```
## Generating the plots of the AUC metrics
Run the R script
```R
getPlots
```

Additionaly the MATLAB script generateFigures generates some figures in the paper.
 -r 7 -d ORB -dV visualDictionary/visualDictionary16ORB.pickle -i ballTreeIndexes/index_ORB_W16.pickle

## Motivation

This project is part of my research on kernels on fuzzy sets

## Contributor
jorge.jorjasso@gmail.com

