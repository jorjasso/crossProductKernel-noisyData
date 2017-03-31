# Cross product kernels on fuzzy sets

## Synopsis
Experiments using cross product kernels on fuzzy sets and SVM on PIMA attribute Noise data.
Experiments described in the paper: Fuzzy set similarity using kernels on fuzzy sets.
Reference:

**_Guevara, Jorge  and Canu, Stephane and Hirata Jr, Roberto Cross product kernels on fuzzy sets for fuzzy set similarity, 
2017 IEEE International Conference on Fuzzy Systems - FUZZ-IEEE 2017_**

---
## Prerequisites
* SVM-KM from http://asi.insa-rouen.fr/enseignants/~arakoto/toolbox/  (included)
* MATLAB 2013a for the experiments
* R for the plots
* All the twelve 5-fold versions of the PIMA and SONAR noise attribute data set from the Keel repository http://sci2s.ugr.es/keel/attributeNoise.php (pima-5an-nn, pima-10an-nn, etc). **Put the datasets in separate folders  within the datasets folder, i.e., /datasets/pima-5an-cn-5-fold/<nowiki>*</nowiki>.dat**

## Code Example

To run an  experiment using the cross product kernels on fuzzy sets (linear, exponential and gaussian) usint the first fuzzification approach described in the paper (fuzz1) on the  clean train - noise test (cn) version of the data with 15% level of noise level type in the MATLAB prompt:

```matlab
      experiments('pima' , 15, 'cn','fuzz1')
```
To run all the experiments for the PIMA attribute noisy datasets using screen run this:

```matlab
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 5, 'cn','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 10, 'cn','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 15, 'cn','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 20, 'cn','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 5, 'cn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 10, 'cn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 15, 'cn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 20, 'cn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 5, 'cn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 10, 'cn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 15, 'cn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 20, 'cn','fuzz2')"
```

## Generating a cvs file with the results
This generate a csv with all the results. Run the MATLAB script:
```matlab
testResultsIntoCVS
```
## Generating some  plots
Run the R script
```R
getPlots
```
Run the Matlab script
```matlab
generateFigures
```

## Motivation

This project is part of my research on kernels on fuzzy sets

## Contributor
jorge.jorjasso@gmail.com

