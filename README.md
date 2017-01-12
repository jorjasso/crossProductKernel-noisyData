# kernels On Fuzzy Sets and SVM on NoiseData

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
