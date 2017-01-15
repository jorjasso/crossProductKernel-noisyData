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

``matlab
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 15, 'cn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 20, 'cn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 15, 'cn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 20, 'cn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 15, 'cn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 20, 'cn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 15, 'cn','fuzz4')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 20, 'cn','fuzz4')"
```

## Codse Example

Another examples of queries:

SIFT
```python
python query.py  -q queries/0706.3046-img-1-22.jpg -r 7 -d SIFT -dV visualDictionary/visualDictionary16SIFT.pickle -i ballTreeIndexes/index_SIFT_W16.pickle

python query.py  -q queries/1403.3290-img-5-14.jpg -r 10 -d SIFT -dV visualDictionary/visualDictionary64SIFT.pickle -i ballTreeIndexes/index_SIFT_W64.pickle   

python query.py  -q queries/0801.2442-img-2-21.jpg -r 3 -d SIFT -dV visualDictionary/visualDictionary256SIFT.pickle -i ballTreeIndexes/index_SIFT_W256.pickle
```

SURF
```python
python query.py  -q queries/1409.1047-img-3-06.jpg -r 7 -d SURF -dV visualDictionary/visualDictionary256SURF.pickle -i ballTreeIndexes/index_SURF_W256.pickle

python query.py  -q queries/0903.1780-img-1-32.jpg -r 7 -d SURF -dV visualDictionary/visualDictionary256SURF.pickle -i ballTreeIndexes/index_SURF_W256.pickle

python query.py  -q queries/1409.1047-img-3-06.jpg -r 7 -d SURF -dV visualDictionary/visualDictionary16SURF.pickle -i ballTreeIndexes/index_SURF_W16.pickle
```


ORB
```python
python query.py  -q queries/0706.3046-img-1-22.jpg -r 7 -d ORB -dV visualDictionary/visualDictionary16ORB.pickle -i ballTreeIndexes/index_ORB_W16.pickle

python query.py  -q queries/1506.05863-img-3-21.jpg -r 7 -d ORB -dV visualDictionary/visualDictionary16ORB.pickle -i ballTreeIndexes/index_ORB_W16.pickle
```

## Computing VLAD features for a new dataset
Example VLAD with ORB descriptors with a visual dictionary with 2 visual words and an a ball tree as index. (Of course, 2 visual words is not useful, instead,  try 16, 32, 64, or 256 visual words)

Remark: Create folders: /ballTreeIndexes, /descriptors, /visualDictionary, /VLADdescriptors 

1. compute descriptors from a dataset. The supported descriptors are ORB, SIFT and SURF:
	```python
	python describe.py --dataset dataset --descriptor descriptorName --output output
	```
	*Example
	```python
	python describe.py --dataset dataset --descriptor ORB --output descriptors/descriptorORB
	```

2.  Construct a visual dictionary from the descriptors in path -d, with -w visual words:
	```python
	python visualDictionary.py  -d descriptorPath -w numberOfVisualWords -o output
	```
	*Example :
	```python
	python visualDictionary.py -d descriptors/descriptorORB.pickle  -w 2 -o visualDictionary/visualDictionary2ORB
	```

3. Compute VLAD descriptors from the visual dictionary:
	```python
	python vladDescriptors.py  -d dataset -dV visualDictionaryPath --descriptor descriptorName -o output
	```
	*Example :
	```python
	python vladDescriptors.py  -d dataset -dV visualDictionary/visualDictionary2ORB.pickle --descriptor ORB -o VLADdescriptors/VLAD_ORB_W2
	```
	
4.  Make an index from VLAD descriptors using  a ball-tree DS:
	```python
	python indexBallTree.py  -d VLADdescriptorPath -l leafSize -o output
	```
	*Example :
	```python
	python indexBallTree.py  -d VLADdescriptors/VLAD_ORB_W2.pickle -l 40 -o ballTreeIndexes/index_ORB_W2
	```

5. Query:
	```python
	python query.py  --query image --descriptor descriptor --index indexTree --retrieve retrieve
	```
        *Example
        ```python
        python query.py  -q queries/0706.3046-img-1-22.jpg -r 11 -d ORB -dV visualDictionary/visualDictionary2ORB.pickle -i ballTreeIndexes/index_ORB_W2.pickle
        ```


## Motivation

This project is part of the pipeline of DOCRetrieval project

## Installation

First install conda , then:

```python
conda create --name openCV-Python numpy scipy scikit-learn matplotlib python=3
source activate openCV-Python
conda install -c menpo opencv3=3.1.0
```

## Contributor
jorge.jorjasso@gmail.com






To run the experiments type in the MATLAB prompt

```matlab
      experiments('pima' , 15, 'cn','fuzz1')
```
which uses the pima dataset, with 15% noise level, cn=clean training noise test estrategy and and membership functions.



```matlab
%pima 
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 15, 'cn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 20, 'cn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 15, 'cn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 20, 'cn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 15, 'cn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 20, 'cn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 15, 'cn','fuzz4')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 20, 'cn','fuzz4')"

%sonar 
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 20, 'nn','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 20, 'nn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 20, 'nn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 20, 'nn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 20, 'nn','fuzz4')"

 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 20, 'nc','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 20, 'nc','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 20, 'nc','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 20, 'nc','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 20, 'nc','fuzz4')"

 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 20, 'cn','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 20, 'cn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 20, 'cn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 20, 'cn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 20, 'cn','fuzz4')"
 
%'ring' 
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('ring' , 20, 'nn','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('ring' , 20, 'nn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('ring' , 20, 'nn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('ring' , 20, 'nn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('ring' , 20, 'nn','fuzz4')"

 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('ring' , 20, 'nc','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('ring' , 20, 'nc','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('ring' , 20, 'nc','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('ring' , 20, 'nc','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('ring' , 20, 'nc','fuzz4')"

 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('ring' , 20, 'cn','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('ring' , 20, 'cn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('ring' , 20, 'cn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('ring' , 20, 'cn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('ring' , 20, 'cn','fuzz4')"

%'spambase' 
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('spambase' , 20, 'nn','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('spambase' , 20, 'nn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('spambase' , 20, 'nn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('spambase' , 20, 'nn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('spambase' , 20, 'nn','fuzz4')"

 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('spambase' , 20, 'nc','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('spambase' , 20, 'nc','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('spambase' , 20, 'nc','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('spambase' , 20, 'nc','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('spambase' , 20, 'nc','fuzz4')"

 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('spambase' , 20, 'cn','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('spambase' , 20, 'cn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('spambase' , 20, 'cn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('spambase' , 20, 'cn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('spambase' , 20, 'cn','fuzz4')"
 
 %'twonorm' 
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('twonorm' , 20, 'nn','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('twonorm' , 20, 'nn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('twonorm' , 20, 'nn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('twonorm' , 20, 'nn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('twonorm' , 20, 'nn','fuzz4')"

 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('twonorm' , 20, 'nc','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('twonorm' , 20, 'nc','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('twonorm' , 20, 'nc','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('twonorm' , 20, 'nc','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('twonorm' , 20, 'nc','fuzz4')"

 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('twonorm' , 20, 'cn','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('twonorm' , 20, 'cn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('twonorm' , 20, 'cn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('twonorm' , 20, 'cn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('twonorm' , 20, 'cn','fuzz4')"
 
  %'wdbc' 
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('wdbc' , 20, 'nn','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('wdbc' , 20, 'nn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('wdbc' , 20, 'nn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('wdbc' , 20, 'nn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('wdbc' , 20, 'nn','fuzz4')"

 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('wdbc' , 20, 'nc','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('wdbc' , 20, 'nc','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('wdbc' , 20, 'nc','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('wdbc' , 20, 'nc','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('wdbc' , 20, 'nc','fuzz4')"

 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('wdbc' , 20, 'cn','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('wdbc' , 20, 'cn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('wdbc' , 20, 'cn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('wdbc' , 20, 'cn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('wdbc' , 20, 'cn','fuzz4')"
 ```
