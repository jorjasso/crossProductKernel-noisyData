%% -------
%This script reads all the experimental results stored in 'resultsMAT/PIMA/*.mat'
%It retrieve the test estatistics from each .MAT (dataset)  and save them into a cvs file 

mat = dir('resultsMAT/PIMA/*.mat')
fid = fopen('resultsPIMA.csv', 'w') ;
varNames={'Dataset', 'fuzzyfication' 'kernelOption', '100-Err_Rate', '100-Err_RateA','100-Err_RateN','AUC,TP', 'TN', 'FP', 'FN', 'TPR', 'SPC', 'PPV', 'NPV', 'FPR', 'FDR', 'ACC', 'F1', 'MCC'}
fprintf(fid, '%s,', varNames{1,1:end},varNames{1,3:end-1}) ;
fprintf(fid, '%s\n',varNames{1,end}) ;

% formatSpec
s=[];
n=35
for i=1:n
    s=strcat('%f,',s);
end
s

%test
for q = 1:length(mat)
    disp(mat(q).name)
end
%
for q = 1:length(mat)
    
    cont = load(strcat('resultsMAT/PIMA/',mat(q).name));
    dataName = mat(q).name
    fuzzyficationType=cont.datasetOption
    % Test statistics
    %----------------------------
    %stat=[TP TN FP FN TPR SPC PPV NPV FPR FDR ACC F1 MCC];
    %[Err_Rate, Err_RateA,Err_RateN,~,AUC,stat]=computeError(yTest,ypred);
    %statistics{i,j,3}=[kernelOption, 100-Err_Rate, 100-Err_RateA,100-Err_RateN,AUC,stat];
    %---------------
    
    j=1;
    %STAT=cell(length(kernelList))
    %varNames={'list of C values','list  gamma values','CV mean std','CV mean sv','mean acc', 'mean auc','Tr mean sv','Tr mean acc','Tr mean auc','Test mean acc', 'Test mean acc cl -1', 'Test mean acc cl 1', 'Test mean auc','Test std acc', 'Test std auc'}
    for kernelOption=cont.kernelList
        % results for kernel indexed by j in kernel list
        % names=[kernelOption, 100-Erar_Rate, 100-Err_RateA,100-Err_RateN,AUC,TP TN FP FN TPR SPC PPV NPV FPR FDR ACC F1 MCC]
        results{j}=[mean(cell2mat(cont.statistics(:,j,3))) std(cell2mat(cont.statistics(:,j,3)))];
        formatSpec=strcat('%s,%s,',s,'%f\n')
        fprintf(fid, formatSpec,dataName,fuzzyficationType, results{j});
        %fclose(fid) ;

      %  dlmwrite('vals.csv', results{j}, '-append')
       % fid = fopen('vals_V.csv', 'a') ;
        j=j+1
    end
    
    
end
fclose(fid) ;

