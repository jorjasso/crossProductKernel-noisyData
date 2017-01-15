%% Figure of fuzzy sets used in the first fuzzyfication approach

x=-1:0.01:1
q=quantile(x,[0.25, 0.5, 0.75])
sig=abs(q(3)-q(1))/(2*sqrt(2*log(2)));
y=evalmf(x,[sig,q(2)],'gaussmf');

fig=figure; 
hax=axes;
plot(x,y)
xlabel('Attribute values','FontSize',15,'FontWeight','bold','Color','k')
set(gca,'XLim',[-1.1 1.1]);
set(gca,'XTick',[-1:0.5:1])
set(gca,'XTickLabel',[-1:0.5:1])
%size of the ticks
set(gca, 'FontSize', 14)

hold on 
% vertical lines
line([ q(1) q(1)],[0 1],'Color',[.3 .3 .3],'LineStyle','--')
line([ q(3) q(3)],[0 1],'Color',[.3 .3 .3],'LineStyle','--')
% text on the plot
txt1 = '$\leftarrow 2\sqrt{2\log 2}\;\sigma \rightarrow$';
text(q(2)-0.3,0.3,txt1,'FontSize',18,'Interpreter','latex')

%% Figure of fuzzy sets used in the second fuzzyfication approach

                

x=-1:0.01:1
tam=50

f=hist(x,tam) ./ max(hist(x,tam));
fuzzyParams{classData,nCol}=[x;f]; % position and degree MF
mfparams=fuzzyParams{classData,nCol};
y=membershipDegree(x,mfparams(2,:),mfparams(1,:));% membershipDegree(x,f,pos)
 
y=evalmf(x,[sig,q(2)],'gaussmf');

fig=figure; 
hax=axes;
plot(x,y)
xlabel('Attribute values','FontSize',15,'FontWeight','bold','Color','k')
set(gca,'XLim',[-1.1 1.1]);
set(gca,'XTick',[-1:0.5:1])
set(gca,'XTickLabel',[-1:0.5:1])
%size of the ticks
set(gca, 'FontSize', 14)

hold on 
% vertical lines
line([ q(1) q(1)],[0 1],'Color',[.3 .3 .3],'LineStyle','--')
line([ q(3) q(3)],[0 1],'Color',[.3 .3 .3],'LineStyle','--')
% text on the plot
txt1 = '$\leftarrow 2\sqrt{2\log 2}\;\sigma \rightarrow$';
text(q(2)-0.3,0.3,txt1,'FontSize',18,'Interpreter','latex')


[f,x]=hist(randn(10000,1),50);%# create histogram from a normal distribution.
g=1/sqrt(2*pi)*exp(-0.5*x.^2);%# pdf of the normal distribution

%#METHOD 1: DIVIDE BY SUM
figure(1)
bar(x,f/sum(f));hold on
plot(x,g,'r');hold off

%#METHOD 2: DIVIDE BY AREA
figure(2)
bar(x,f/trapz(x,f));hold on
plot(x,g,'r');hold off

%#METHOD 2: DIVIDE BY the Max element on the histogram
figure(3)
bar(x,f./max(f));hold on
plot(x,g,'r');hold off



%% Read data set
        delimiter = ',';
        startRow = 14;
        %formatSpec = '%n%n%n%n%n%n%n%n%s%[^\n\r]';
        formatSpec = '%n%n%n%n%n%n%n%n%s';



%%

pathDataSet='attribute_noise_5_cn/banana-5an-cn/training.dat'
fid = fopen(pathDataSet);
format = '%n %n %n';
C = textscan(fid, format,'delimiter', ',');
X=cell2mat(C(1:2));
y=grp2idx(C{1,3});

plot(X(:,1),X(:,2),'.')
hold on
figure
hist(X(:,1))
hold on
figure
hist(X(:,2))

quantile(X(:,1),[0.25, 0.5, 0.75])
quantile(X(:,2),[0.25, 0.5, 0.75])


pathDataSet='attribute_noise_20_nn/banana-20an-nn/training.dat'
fid = fopen(pathDataSet);
format = '%n %n %n %n %s';
C = textscan(fid, format,'delimiter', ',');
X=cell2mat(C(1:2));
y=grp2idx(C{1,5});

figure
hist(X(:,2))

%contraceptive dataset (nop, only some the feature four)
% @relation  contraceptive
% @attribute Wife_age integer[16,49]
% @attribute Wife_education integer[1,4]
% @attribute Husband_education integer[1,4]
% @attribute Children integer[0,16]
% @attribute Wife_religion integer[0,1]
% @attribute Wife_working integer[0,1]
% @attribute Husband_occupation integer[1,4]
% @attribute Standard-of-living integer[1,4]
% @attribute Media_exposure integer[0,1]
% @attribute Contraceptive_method{1,2,3}
% @inputs Wife_age, Wife_education, Husband_education, Children, Wife_religion, Wife_working, Husband_occupation, Standard-of-living, Media_exposure
% @outputs Contraceptive_method

pathDataSet='attribute_noise_5_cn/contraceptive-5an-cn/training.dat'
fid = fopen(pathDataSet);
format = '%n %n %n %n %n %n %n %n %n %n';
C = textscan(fid, format,'delimiter', ',');
X=cell2mat(C(1:9));
y=grp2idx(C{1,10});

figure
hist(X(:,9))


pathDataSet='attribute_noise_20_nn/contraceptive-20an-nn/training.dat'
fid = fopen(pathDataSet);
format = '%n %n %n %n %n %n %n %n %n %n';
C = textscan(fid, format,'delimiter', ',');
Xa=cell2mat(C(1:9));
y=grp2idx(C{1,10});

figure
hist(Xa(:,9))

%quantiles quantile(x,[0.25, 0.5, 0.75])



%%scale between [-1,1]
X=bsxfun(@rdivide, 2*bsxfun(@minus, X,min(X)), (max(X)-min(X)))-1;

%%

%
% @attribute At1 real[-3.09,2.81]
% @attribute At2 real[-2.39,3.19]
% @attribute Class{-1.0,1.0}
addpath ./SVM-KM/
addpath ./crosProductkernels/
addpath ./attribute_noise_5_nn/banana-5an-nn/

clc
clear
pathDataSet='attribute_noise_5_nn/banana-5an-nn/banana-5an-nn-5-1tra.dat'
fid = fopen(pathDataSet);
format = '%n %n %n';
C = textscan(fid, format,'delimiter', ',');
X=cell2mat(C(1:2));
y=grp2idx(C{1,3});
y(y==2)=-1;

%Plot of the dataset
figure
plot(X(:,1),X(:,2),'.')

% get the MF from data
[~,col]=size(X);
tam=50 % to estimate the sample for fuzzy sets
nroFuzzyDatasets=4;
nroClasses=2;
fuzzyParams=cell(nroFuzzyDatasets,nroClasses,col); % number of fuzzy datasets, number of labels, number of variables
for label=unique(y)'
    for nCol=1:col
        
        if (label==-1 )
            classData=2;
        else
            classData=1;
        end
        
        ind=find(y==label);
        Var=X(ind,nCol);
        
        %MF1
        %gaussian MF , with m=median and s=quartile1-quartile2
        figure
        [~,x]=hist(Var,tam);
        bar(x,hist(Var,tam) ./ max(hist(Var,tam)));
        q=quantile(Var,[0.25, 0.5, 0.75]) ;
        MF1 = gaussmf(x,[abs(q(3)-q(1)) q(2)]);
        hold on
        plot(x,MF1,'r')
        
        %params
        %mfparams=[abs(q(3)-q(1)),q(2)];
        %mftype='gaussmf';
        % y=evalmf(x,mfparams,mftype);
        fuzzyParams{1,classData,nCol}=[abs(q(3)-q(1)),q(2)];
        
        %MF2
        %gaussian MF , with m=median and s=FWHM/(2*sqrt(2*log(2))),
        figure
        bar(x,hist(Var,tam) ./ max(hist(Var,tam)));
        %FWHM=2sqrt(2 ln 2) * sigma%     experiments('pima' , 5, 'nn','fuzz1') ok
%     experiments('pima' , 5, 'nn','fuzz2') ok
%     experiments('pima' , 5, 'nn','fuzz3') ok
%     experiments('pima' , 5, 'nn','fuzz4')
% 
%     experiments('pima' , 10, 'nn','crisp') ok
%     experiments('pima' , 10, 'nn','fuzz1') ok
%     experiments('pima' , 10, 'nn','fuzz2') ok
%     experiments('pima' , 10, 'nn','fuzz3') ok
%     experiments('pima' , 10, 'nn','fuzz4') ok
% 
%     experiments('pima' , 15, 'nn','crisp') ok
%     experiments('pima' , 15, 'nn','fuzz1')ok
%     experiments('pima' , 15, 'nn','fuzz2') ok
%     experiments('pima' , 15, 'nn','fuzz3') ok
%     experiments('pima' , 15, 'nn','fuzz4') ok

        FWHM=abs(q(3)-q(1));
        sig=FWHM/(2*sqrt(2*log(2)));
        MF2 = gaussmf(x,[sig q(2)]);
        hold on
        plot(x,MF2,'r')
        
        %params
        %mfparams=[sig,q(2)];
        %mftype='gaussmf';
        %y=evalmf(x,mfparams,mftype);
        fuzzyParams{2,classData,nCol}=[sig,q(2)];
        
        
        %MF3
        figure
        [~,x]=hist(Var,tam);
        bar(x,hist(Var,tam) ./ max(hist(Var,tam)));
        hold on
        f=hist(Var,tam) ./ max(hist(Var,tam));
        plot(x,f,'r')
        fuzzyParams{3,classData,nCol}=[x;f]; % position and degree MF
        
        %MF4
        figure
        [~,x]=hist(Var,tam);
        bar(x,hist(Var,tam) ./ max(hist(Var,tam)));
        hold on
        f=(1+hist(Var,tam) ./ max(hist(Var,tam)))/2;
        plot(x,f,'r')
        fuzzyParams{4,classData,nCol}=[x;f];% position and degree MF
    end
end
close all
%plot(fuzzyParams{3,2,2}(1,:),(fuzzyParams{3,2,2}(2,:)))

%plot membership funcionts for each variable

%% Data sets with membership functions
% four fuzzy datasets (one fuzzy data set for each membership function)
% First Fuzzy Dataset
[row,col]=size(X);
fuzzyMFD1=zeros(row,col);
fuzzyMFD2=zeros(row,col);
fuzzyMFD3=zeros(row,col);
fuzzyMFD4=zeros(row,col);
mftype='gaussmf';

for label=unique(y)'
    for nCol=1:col
        if (label==-1 )
            classData=2;
        else
            classData=1;
        end
        ind=find(y==label);
        Var=X(ind,nCol);
        
        %fuzzy dataset I
        mfparams=fuzzyParams{1,classData,nCol};
        fuzzyMFD1(ind,nCol)=evalmf(Var,mfparams,mftype);
        
        %fuzzy dataset II
        mfparams=fuzzyParams{2,classData,nCol};
        fuzzyMFD2(ind,nCol)=evalmf(Var,mfparams,mftype);
        
        %fuzzy dataset III
        mfparams=fuzzyParams{3,classData,nCol};
        fuzzyMFD3(ind,nCol)=membershipDegree(Var,mfparams(2,:),mfparams(1,:));% membershipDegree(x,f,pos)
        
        %fuzzy dataset IV
        mfparams=fuzzyParams{4,classData,nCol};
        fuzzyMFD4(ind,nCol)=membershipDegree(Var,mfparams(2,:),mfparams(1,:));
    end
end
figure
plot(fuzzyMFD1(:,1),fuzzyMFD1(:,2),'.')
figure
plot(fuzzyMFD2(:,1),fuzzyMFD2(:,2),'.')
figure
plot(fuzzyMFD3(:,1),fuzzyMFD3(:,2),'.')
figure
plot(fuzzyMFD4(:,1),fuzzyMFD4(:,2),'.r')

%close all
%% experiments
%   name={'sonar', 'pima', 'ring','spambase', 'twonorm', 'wdbc' }
%   noiseLevel={20}
%   option={'nn', 'nc', 'cn'}
%   datasetOption={'crisp', 'fuzz1','fuzz2','fuzz3','fuzz4'}

%pima 
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 15, 'cn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 20, 'cn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 15, 'cn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 20, 'cn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 15, 'cn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 20, 'cn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 15, 'cn','fuzz4')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('pima' , 20, 'cn','fuzz4')"

%sonar tolstoi

 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 5, 'nn','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 5, 'nn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 5, 'nn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 5, 'nn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 5, 'nn','fuzz4')"

 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 5, 'nc','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 5, 'nc','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 5, 'nc','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 5, 'nc','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 5, 'nc','fuzz4')"

 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 5, 'cn','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 5, 'cn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 5, 'cn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 5, 'cn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 5, 'cn','fuzz4')"
 
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 10, 'nn','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 10, 'nn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 10, 'nn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 10, 'nn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 10, 'nn','fuzz4')"

 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 10, 'nc','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 10, 'nc','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 10, 'nc','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 10, 'nc','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 10, 'nc','fuzz4')"

 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 10, 'cn','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 10, 'cn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 10, 'cn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 10, 'cn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 10, 'cn','fuzz4')"
 
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 15, 'nn','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 15, 'nn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 15, 'nn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 15, 'nn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 15, 'nn','fuzz4')"

 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 15, 'nc','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 15, 'nc','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 15, 'nc','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 15, 'nc','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 15, 'nc','fuzz4')"

 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 15, 'cn','crisp')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 15, 'cn','fuzz1')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 15, 'cn','fuzz2')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 15, 'cn','fuzz3')"
 screen  -d -m matlab -nodisplay -nosplash -r    "experiments('sonar' , 15, 'cn','fuzz4')"
 
 
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
 
 
 
%'ring' puchkin
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

%'spambase' tolstoi
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
 %
%  Error in getFuzzyData (line 52)
%                 MF_Data(ind,nCol)=evalmf(Var,fuzzyParams{classData,nCol},mftype);
% 
% Error in experiments (line 63)
%             [MF_Training,fuzzyParams]=getFuzzyData(Training,y,
%             fuzzyDataSetOption);

 %'twonorm' lowe
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
 
  %'wdbc' hulk4
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


%% formatSpec
s=[];
n=30
for i=1:n
    s=strcat('%n',s);
end
s
% checkar codigo con mlintrpt

%% 
