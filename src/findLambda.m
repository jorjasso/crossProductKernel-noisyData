% jorge.jorjasso@gmail.com,
% modified version of findLambda.m
%  at
% https://github.com/jorjasso/SMDD-group-anomaly-detection/blob/master/findLambda.m
% date 09 set 2015
function quantiles=findLambda(X)
% function lambda=findLambda(S); finds the lambda parameter for a RBF
% kernel

[n,m]=size(X);
factor=n;

if factor <1000
    M=sqdistAll(X,X);
    quantiles=quantile(M(:),[0.1, 0.5, 0.9]) ;
    
else
    % randomly pick up 1000 points
    ind =randperm(length(X),1000);   
    M=sqdistAll(X(ind,:),X(ind,:));
    quantiles=quantile(M(:),[0.1, 0.5, 0.9]) ;
    
end