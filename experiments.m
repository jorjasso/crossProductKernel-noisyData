function experiments(name , noiseLevel, option, datasetOption)
%   name={'sonar', 'pima', 'spambase', 'ring', 'twonorm', 'wdbc' }
%   noiseLevel={5,10,15,20}
%   option={'nn', 'nc', 'cn'}
%   datasetOption={'crisp', 'fuzz1','fuzz2','fuzz3','fuzz4'}
addpath ./SVM-KM/
addpath ./datasets/
addpath ./FuzzyCrossProductKernels/
addpath ./src/
addpath ./resultsMAT/


[ filename, saveAsFilename,delimiter, startRow,formatSpec] = readData( name , noiseLevel, option);

saveAsFilename=strcat(datasetOption,saveAsFilename)


nroDatasets=5;
statistics = cell(nroDatasets,11,3);% nroDatasets x nroKernels x {CVstat, trainingStat, testStat}
statisticsPerClass=zeros(nroDatasets,2); %
for i=1:nroDatasets
    % Training sets
    
    pathDataSet=strcat(filename,int2str(i),'tra.dat');
    fileID = fopen(pathDataSet,'r');
    C = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
    fclose(fileID);
    Training=cell2mat(C(1:length(C)-1));
    y=grp2idx(C{length(C)});
    y(y==2)=-1;
    
    %Test sets
    %---------
    pathDataSet=strcat(filename,int2str(i),'tst.dat');
    fileID = fopen(pathDataSet,'r');
    C = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
    fclose(fileID);
    Test=cell2mat(C(1:length(C)-1));
    yTest=grp2idx(C{length(C)});
    yTest(yTest==2)=-1;
    
    
    % normalize data with X=zscore(X)
    [Training,mu,sigma]=zscore(Training);
    
    Test=bsxfun(@rdivide, bsxfun(@minus, Test, mu),sigma);

    
    %GET DATA  datasetOption={'crisp', 'fuzz1','fuzz2','fuzz3','fuzz4'}
    %---------------
    
    switch(datasetOption)
        case 'crisp'
            X=Training;
            Z=Test;
            kernelList=1:3; % linear, polynomial and gaussian kernel
        case 'fuzz1'
            fuzzyDataSetOption=1;
            [MF_Training,fuzzyParams]=getFuzzyData(Training,y, fuzzyDataSetOption);
            X=cell(1,2);%  {X,MF_Data}
            X{1}=num2cell(Training);
            X{2}=num2cell(MF_Training);
            
            [MF_Test,~]=getFuzzyData(Test,yTest, fuzzyDataSetOption,fuzzyParams);
            
            Z{1}=num2cell(Test);
            Z{2}=num2cell(MF_Test);
            kernelList=30:33; 
        case 'fuzz2'
            fuzzyDataSetOption=2;
            [MF_Training,fuzzyParams]=getFuzzyData(Training,y, fuzzyDataSetOption);
            X=cell(1,2);%  {X,MF_Data}
            X{1}=num2cell(Training);
            X{2}=num2cell(MF_Training);
            
            [MF_Test,~]=getFuzzyData(Test,yTest, fuzzyDataSetOption,fuzzyParams);
            
            Z{1}=num2cell(Test);
            Z{2}=num2cell(MF_Test);
            kernelList=30:33; 
            
        case 'fuzz3'
            fuzzyDataSetOption=3;
            [MF_Training,fuzzyParams]=getFuzzyData(Training,y, fuzzyDataSetOption);
            X=cell(1,2);%  {X,MF_Data}
            X{1}=num2cell(Training);
            X{2}=num2cell(MF_Training);
            
            [MF_Test,~]=getFuzzyData(Test,yTest, fuzzyDataSetOption,fuzzyParams);
            
            Z{1}=num2cell(Test);
            Z{2}=num2cell(MF_Test);
            kernelList=30:33; 
            
        case 'fuzz4'
            fuzzyDataSetOption=4;
            [MF_Training,fuzzyParams]=getFuzzyData(Training,y, fuzzyDataSetOption);
            X=cell(1,2);%  {X,MF_Data}
            X{1}=num2cell(Training);
            X{2}=num2cell(MF_Training);
            
            [MF_Test,~]=getFuzzyData(Test,yTest, fuzzyDataSetOption,fuzzyParams);
            
            Z{1}=num2cell(Test);
            Z{2}=num2cell(MF_Test);
            kernelList=30:33; 
            
    end
    
    
    %------------
    % number of samples by class [%class1, %class2]
    pc1=100*length(find(y==1))/length(y);
    statisticsPerClass(i,:)=[pc1,100-pc1];
    
        
    % partition for the  model selection using cross-validation
    kFold=10;
    CVP=cvpartition(y,'k',kFold);% split training set in training and validation indices
    
    j=1;
    for kernelOption = kernelList
        
        strInf=['DataSet = ',saveAsFilename, ' nroDatasets = ', num2str(i), '   kernel = ',num2str(kernelOption)]
        disp(strInf)
       
        
        % MODEL SELECTION
        %-----------------
        
        %grid for  kernel parameter
        %-----------------------------------------------------
        % compute gamma using median heuristic (RBF kernels) and
        % exponential kernels
        if kernelOption==3||kernelOption==32||kernelOption==33||kernelOption==36||kernelOption==37
            quantiles=findLambda(Training);
            grid_gamma=[1/quantiles(1),1/quantiles(2),1/quantiles(3)];
        end
        if kernelOption==30 || kernelOption==1||kernelOption==34 %linear kernels
            grid_gamma=1;
        end
        if kernelOption==31||kernelOption==2||kernelOption==35 % polynomials kernels
            grid_gamma=2:4;
        end
        
        % Coarse grid search on small dataset for a big training set
        %------------------------------------
        %very small dataset
        %(C,Gamma)=tune(smallTrainingSet, coarseGrid)
        N=length(Training);
        bestC=[];
        grid_C=[];
        if N>500
            disp('coarse grid search')
            tamSmallData=250;
            ind =randperm(N,tamSmallData);
            
            if strcmp(datasetOption,'crisp')
                smallX=X(ind,:);
            else
                % small fuzzy dataset
                %-------------------
                smallX{1}=X{1}(ind,:);
                smallX{2}=X{2}(ind,:);
            end
            
            CVP_small=cvpartition(y(ind),'k',5);
            % coarse grid search
        
            [bestC,bestGamma, ~, ~, ~, ~,~,~]=gridSearch(CVP_small, smallX, y(ind),kernelOption, grid_C, grid_gamma);
         
            %----------------------
        end
        
        %  Fine grid search on this grid:
        if ~isempty(bestC)
            grid_C=linspace(2^(log2(bestC)-1), 2^(log2(bestC)+1), 5);
            grid_gamma=bestGamma;
        end
        
        disp('fine grid search')
        [bestC,bestGamma, accuracy, standarDev, nrosvs, Err_RateA,Err_RateN,AUC]=gridSearch(CVP, X, y,kernelOption,grid_C,grid_gamma);
        % save cross validation statistics
        %----------------------------
        statistics{i,j,1}= [kernelOption,bestC,bestGamma,  standarDev, nrosvs, accuracy, 100-Err_RateA,100-Err_RateN,AUC];
        
        disp('training')
        %Training
        %------------------
        %Training in  (training + validation) with the best CV parameters
        ind=1:length(y);
        [b,alph1,pos, nSV, Err_Rate, Err_RateA,Err_RateN,~,AUC,~]=getStatisticsSVM(X,y,ind,ind,kernelOption, bestGamma,bestC);
        %save training  statistics
        %----------------------------
        statistics{i,j,2}=[kernelOption, nSV, 100-Err_Rate, 100-Err_RateA,100-Err_RateN,AUC];
        
        disp('testing')
        %TESTING
        %------------------------------
        
        if (kernelOption == 1 ||kernelOption == 2 || kernelOption == 3)
            X_SV=X(pos,:);
        else
            X_SV{1}=X{1}(pos,:);
            X_SV{2}=X{2}(pos,:);
        end
        
        V=getKernel(kernelOption,X_SV,Z,bestGamma);% prediction over test dataset
        ypred = V'*(y(pos).*alph1) + b;
        
        % Test statistics
        %----------------------------
        [Err_Rate, Err_RateA,Err_RateN,~,AUC,stat]=computeError(yTest,ypred);
        statistics{i,j,3}=[kernelOption, 100-Err_Rate, 100-Err_RateA,100-Err_RateN,AUC,stat];
        %---------------
        
        % TOTAL STAT
        
        j=j+1;
    end
end

saveAsFilename
save(strcat('./resultsMAT/',name,'/',saveAsFilename,'borrar'));

exit

