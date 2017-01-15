% jorge.jorjasso@gmail.com,
% NOT modified version of SVM_MONQP.m in TSK-kernels-Low-quality
%  at
%  https://github.com/jorjasso/TSK-kernels-Low-quality/blob/master/SVM_MONQP.m
% date 09 set 2015
function [b,alph1,pos]=SVM_MONQP(G,y,C)
% SVM
% input  G = kernel matrix,  y=labels C= regularization parameter,
G=(y*y').*G;
n=length(G);
G=G+eps*eye(n);
[~,p]=chol(G);
if (p~=0)
    for j=eps*2.^0:1:40
        G=G+j*eye(n);
        [~,p]=chol(G);
        if p==0
            break
        end
    end
end

%e=ones(n,1);

%optimization
%-----------------
l = 10^-11; 
%l=0.000000001;
verbose = 0;
 
e=ones(n,1);

[alph1, b, pos] = monqp(G,e,y,0,C,l,verbose);
                 

% 
% 
% %indices
% %---------
% th=getThreshold(alph);% getThreshold
% %Io=find(alph>th);      % sv expansion 0<alph<=C
% I2=find(alph>=C-th);  % sv errors    alph==C
% I1=setdiff(Io,I2);     % sv  0<alph<C
% I3=setdiff([1:1:n],Io);
% 
% 
% 
% %to standarize tue output
% %------------------------
% alph1=zeros(n,1);
% alph1(Io)=alph;
% 
% 
% rho=-lambda;
% %pause

