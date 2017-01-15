function [MF_Data,fuzzyParams]=getFuzzyData(X,y, option,fuzzyParams)
% return a Membership degree data (MF_Data) and membership function
% parameteres (fuzzyParams) from dataset X and labels y.
% fuzzyParams is a cell containing the fuzzy parameters for each variable
% per class
% option =1 gaussian MF , with m=median and s=quartile1-quartile2
% option =2 gaussian MF , with m=median and s=FWHM/(2*sqrt(2*log(2))),
% option =3 the MF is the histogram
% option =4 the MF is (1+NormalizedHistogram)/2

% [MF_Data,~]=getFuzzyData(Z,yTest, option,fuzzyParams)
% returns the mebership degree based on the fuzzy parameters fuzzyParams
 ban=0;
if nargin ==4
    ban=1;
end
% get the MF from data
[~,col]=size(X);
tam=50; % to estimate the sample for fuzzy sets

nroClasses= length(unique(y));
if ban==0
fuzzyParams=cell(nroClasses,col); % number of fuzzy datasets, number of labels, number of variables
end
% 
% Membership dataSet
[row,col]=size(X);
MF_Data=zeros(row,col);
mftype='gaussmf';
for label=unique(y)'
    for nCol=1:col
        
        if (label==-1 )
            classData=2;
        else
            classData=1;
        end
        
        ind = y==label;
        Var=X(ind,nCol);
        
        switch lower(option)
            
            case 1%
                %MF1 =gaussian MF , with m=median and s=quartile1-quartile2
                %------------------------------------------------
                if ban==0
                q=quantile(Var,[0.25, 0.5, 0.75]) ;
                fuzzyParams{classData,nCol}=[abs(q(3)-q(1)),q(2)];
                end
                %fuzzy dataset I                
                MF_Data(ind,nCol)=evalmf(Var,fuzzyParams{classData,nCol},mftype);
                
                
            case 2%
                %MF2=gaussian MF , with m=median and s=FWHM/(2*sqrt(2*log(2))),
                %------------------------------------------------
                %
                %FWHM=2sqrt(2 ln 2) * sigma
                if ban==0
                q=quantile(Var,[0.25, 0.5, 0.75]) ;
                FWHM=abs(q(3)-q(1));
                sig=FWHM/(2*sqrt(2*log(2)));
                fuzzyParams{classData,nCol}=[sig,q(2)];
                end
                %fuzzy dataset II                
                MF_Data(ind,nCol)=evalmf(Var,fuzzyParams{classData,nCol},mftype);
                
            case 3%
                %MF3
                %----------------
                if ban==0
                [~,x]=hist(Var,tam);
                f=hist(Var,tam) ./ max(hist(Var,tam));
                fuzzyParams{classData,nCol}=[x;f]; % position and degree MF
                %fuzzy dataset III
                end
                mfparams=fuzzyParams{classData,nCol};
                MF_Data(ind,nCol)=membershipDegree(Var,mfparams(2,:),mfparams(1,:));% membershipDegree(x,f,pos)
                MF_Data(isnan(MF_Data))=0;
            case 4%
                %MF4
                %-----------------------
                if ban==0
                [~,x]=hist(Var,tam);
                f=(1+hist(Var,tam) ./ max(hist(Var,tam)))/2;
                fuzzyParams{classData,nCol}=[x;f];% position and degree MF
                end
                %fuzzy dataset IV
                mfparams=fuzzyParams{classData,nCol};
                MF_Data(ind,nCol)=membershipDegree(Var,mfparams(2,:),mfparams(1,:));
                MF_Data(isnan(MF_Data))=0;
        end
 
        
    end
end

