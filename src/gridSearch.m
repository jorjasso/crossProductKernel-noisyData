% jorge.jorjasso@gmail.com,
% modified version of gridSearch. m in TSK-kernels-Low-quality
%  at https://github.com/jorjasso/TSK-kernels-Low-quality/blob/master/gridSearch.m
% date 09 set 2015
function [bestC,bestGamma, accuracy, standarDev, nrosvs, Err_RateA,Err_RateN,AUC]=gridSearch(CVP, X, y,kernelOption, grid_C, grid_gamma)

kFold=CVP.NumTestSets;

accuracy_history=zeros(1,kFold);
history_errorA=zeros(1,kFold);
history_errorN=zeros(1,kFold);
history_AUC=zeros(1,kFold);
history_sv=zeros(1,kFold);

grid_errorA=zeros(21,21);
grid_errorN=zeros(21,21);
grid_AUC=zeros(21,21);
grid_accuracy=zeros(21,21);
grid_std=zeros(21,21);
grid_nrosvs=zeros(21,21);

%----------------------------------------------------------------
ban=0;
C_min_values=zeros(1,length(grid_gamma));
%gammaFunction=@(x) 2.^x;
%paramC=2.^(-5:15);
%paramGamma=gammaFunction(5:-1:-15);
%--------------------------------------------------------------------------------------


j=1;

for gamma=grid_gamma
    
    
    %find C_min based on the kernel
    if isempty(grid_C)
        K=getKernel(kernelOption,X,X,grid_gamma(j));
        f=K*y;
        C_min=2/(max(f)-min(f));
        grid_C=logspace(log10(C_min),5,10);% from C_min to 10^5 log spaced 10 times
        C_min_values(j)=C_min;
        ban=1;
    end
    i=1;
    for C=grid_C
         
        for k = 1:kFold
            
            indTraining=CVP.training(k);
            indValidation=CVP.test(k);
            
            [~,~,~, nsV, Err_Rate,  Err_RateA,Err_RateN,~,AUC,~]=getStatisticsSVM(X,y,indTraining,indValidation,kernelOption, gamma,C);
            
            accuracy_history(k)=100-Err_Rate;
            history_errorA(k)=Err_RateA;
            history_errorN(k)=Err_RateN;
            history_AUC(k)=AUC;
            history_sv(k)=nsV;                        
        end
        
        grid_accuracy(i,j)=mean(accuracy_history);
        grid_errorA(i,j)=mean(history_errorA);
        grid_errorN(i,j)=mean(history_errorN);
        grid_AUC(i,j)=mean(history_AUC);
        grid_std(i,j)=std(accuracy_history);
        grid_nrosvs(i,j)=mean(history_sv);
        i=i+1;
    end
    j=j+1;
    if ban==1
        grid_C=[];
    end
end

%--------------------------------------------------------------------------------------

[index_C,index_gamma]=bestParammeters(grid_accuracy, grid_AUC);
if ban==1 %retrieve the grid_C for that gamma value, then searh for the best C in that grid_C
    grid_C=logspace(log10(C_min_values(index_gamma)),5,10);    
end
bestC     = grid_C(index_C);
bestGamma = grid_gamma(index_gamma);
accuracy  = grid_accuracy(index_C,index_gamma);
standarDev    = grid_std(index_C,index_gamma);
nrosvs    = grid_nrosvs(index_C,index_gamma);
Err_RateA =grid_errorA(index_C,index_gamma);
Err_RateN= grid_errorN(index_C,index_gamma);
AUC=grid_AUC(index_C,index_gamma);
end



%----------------------Search the best parammeteres---return the indexes---------------------------------------
function [f,c]=bestParammeters(grid_acuracy, grid)
[row,cols]=size(grid_acuracy);
zeroMatrix=zeros(row,cols);
index=find(grid_acuracy==max(grid_acuracy(:)));
zeroMatrix(index)=1;

% uncommnet to solve ties with number of sv's
% % to solve ties, find minimum nSV position
% zeroMatrix=grid_nrosvs.*zeroMatrix;
% [fil,col]=find(zeroMatrix==min(zeroMatrix(index)));
% f=fil(1);
% c=col(1);

% to solve ties, find the maximum AUC position
zeroMatrix=grid.*zeroMatrix;
[fil,col]=find(zeroMatrix==max(zeroMatrix(index)));
f=fil(1);
c=col(1);

end