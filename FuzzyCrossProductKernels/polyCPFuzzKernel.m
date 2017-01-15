function G = polyCPFuzzKernel( X,Z,kernelParam, varargin)
%G=polyCPFuzzKernel( X,Z,kernelParam): Polynomial kernel between fuzzy data X and Z. 
%                          X is cell(1,2), where  X{1}=cell(N,D) and X{2}=cell(N,D).
%                          each element of the cell  X{i} is a N1 x d1 matrix, representing N1
%                          D1-dimensional elements of the support of a  fuzzy set i with membership degree
%                          given by the correspondent values in cell in
%                          X{i}. kernelParam is the kernel parameter. G is the kernel matrix given by the
%                          polynomial cross product kernel on fuzzy sets
%
%G=polyCPFuzzKernel( X,Z,kernelParam,option):  option = 0 vectorized form, fast for
%                          fuzzy sets of example IV. option = 1 non vectorized form, fast for fuzzy sets of example V
%
%G=polyCPFuzzKernel( X,Z,kernelParam,option,agregation): agregation='sum' uses sum
%                          agregation between fuzzy dimensions 1,..d,..D.
%                          agregation='prod' uses product aggregation
% Example I: computing the kernel matrix for the fuzzy data in X.
%             X=cell(1,2); %  (Data, MF) = fuzzyData X
%             X{1}=cell(3,2); % six fuzzy sets: 3 observations, each observations has two fuzzy sets
%             X{2}=cell(3,2); % six sets of membership values for the observations.
%
%             %dimension D1
%             rand('twister', 5489);
%             X{1}{1,1}=rand(3,2); % values
%             X{2}{1,1}=rand(3,1); % MF
%
%             X{1}{2,1}=rand(3,2); % values
%             X{2}{2,1}=rand(3,1); % MF
%
%             X{1}{3,1}=rand(3,2); % values
%             X{2}{3,1}=rand(3,1); % MF
%
%             %dimension D2
%             X{1}{1,2}=rand(2,2); % values
%             X{2}{1,2}=rand(2,1); % MF
%
%             X{1}{2,2}=rand(2,2); % values
%             X{2}{2,2}=rand(2,1); % MF
%
%             X{1}{3,2}=rand(2,2); % values
%             X{2}{3,2}=rand(2,1); % MF
%             kernelParam=2;
%             G=polyCPFuzzKernel( X,X,kernelParam)
%
% Example II: computing the kernel matrix for the fuzzy data in X and Z using  the non-vectorized algorithm.
%             X=cell(1,2); %  (Data, MF)
%             X{1}=cell(5,1); % five fuzzy sets: 6 observations, each observations has one fuzzy set
%             X{2}=cell(5,1); % five sets of membership values for the observations.
%
%             %dimension D1
%             X{1}{1,1}=[1 2]; % values
%             X{2}{1,1}=0.1; % MF
%
%             X{1}{2,1}=[3 5]; % values
%             X{2}{2,1}=0.3; % MF
%
%             X{1}{3,1}=[5 2]; % values
%             X{2}{3,1}=0.5; % MF
%
%             X{1}{4,1}=[7 8]; % values
%             X{2}{4,1}=0.3; % MF
%
%             X{1}{5,1}=[4 8]; % values
%             X{2}{5,1}=0.1; % MF
%
%             Z=cell(1,2); %  (Data, MF)
%             Z{1}=cell(3,1); % five fuzzy sets: 6 observations, each observations has one fuzzy set
%             Z{2}=cell(3,1); % five sets of membership values for the observations.
%
%             %dimension D1
%             Z{1}{1,1}=[3 4]; % values
%             Z{2}{1,1}=0.3; % MF
%
%             Z{1}{2,1}=[3 10]; % values
%             Z{2}{2,1}=0.2; % MF
%
%             Z{1}{3,1}=[3 1]; % values
%             Z{2}{3,1}=0.1; % MF
%             kernelParam=3;
%             G=polyCPFuzzKernel( X,Z,kernelParam,1)
%
% Example III computing the kernel matrix for the fuzzy data in X and Z using  the vectorized algorithm and product aggregation among dimensions.
%             X{1}=num2cell([1 2 3 4 5]');
%             X{2}=num2cell([0.1, 0.3, 0.5, 0.3, 0.1]');
%
%             Z{1}=num2cell([3 4  3]');
%             Z{2}=num2cell([0.3, 0.2, 0.1]');
%             kernelParam=3
%             G=polyCPFuzzKernel( X,Z,kernelParam,0,'prod')
%
% Example IV
% case when vectorized form is faster
%             rand('twister', 5489);
%             X=cell(1,2)
%             N=20;
%             for d=1:2 % dimensions
%                 for i=1:N % observations
%                     X{1}{i,d}=rand(50,3); % values
%                     X{2}{i,d}=rand(50,1); % MF
%                 end
%             end
%
%             Z=cell(1,2);
%             N=15;
%             for d=1:2 % dimensions
%                 for i=1:N % observations
%                     Z{1}{i,d}=rand(50,3); % values
%                     Z{2}{i,d}=rand(50,1); % MF
%                 end
%             end
%             kernelParam=1;
%             tic
%             G=polyCPFuzzKernel(X,Z,kernelParam,0);
%             t1=toc
%             tic
%             GG=polyCPFuzzKernel( X,Z,kernelParam,1 );
%             t2=toc
%             sum(sum(G-GG))
%             [t1, t2]
%
% Examples V
% case when non vectorized form is faster
%             X{1}=num2cell(rand(100,1));
%             X{2}=num2cell(rand(100,1));
%
%             Z{1}=num2cell(rand(100,1));
%             Z{2}=num2cell(rand(100,1));
%             kernelParam=3;
%             tic
%             G=polyCPFuzzKernel(X,Z,kernelParam,0);
%             t1=toc
%             tic
%             GG=polyCPFuzzKernel( X,Z,kernelParam,1 );
%             t2=toc
%             sum(sum(G-GG))
%             [t1, t2]
% author:
%           jorge.jorjasso@gmail.com
%
% references
%
%   The cross product kernel on fuzzy sets.

% defaults
if nargin==3
    option=0; % 
    agregation='sum';
end
if nargin==4
    option=varargin{1};
    agregation='sum';
end

if nargin==5
    option=varargin{1};
    agregation=varargin{2};
end
% variables
[N,D]= size(X{1}); % nro obs x dimension
[M,~]= size(Z{1});
XX=X{1}; % support of fuzzy set
ZZ=Z{1}; % support of fuzzy set

MFX=X{2}; % membership degree of the support
MFZ=Z{2}; % membership degree of the support

if strcmp(agregation,'sum')
    G=zeros(N,M);
    GV=zeros(N,M);
else
    G=ones(N,M);
    GV=ones(N,M);
end

switch option
    case 0 % vectorized form
        sizeXX=cellfun(@(x) size(x,1), XX,'UniformOutput',0);
        sizeZZ=cellfun(@(x) size(x,1), ZZ,'UniformOutput',0);
        for d=1:D
            XXR=repmat(XX(:,d),1,M);
            ZZR=repmat(ZZ(:,d)',N,1);
            MFXR=repmat(MFX(:,d),1,M);
            MFZR=repmat(MFZ(:,d)',N,1);
            sizeXXR=repmat(sizeXX(:,d),1,M);
            sizeZZR=repmat(sizeZZ(:,d)',N,1);
            
            [ixx, jzz]=cellfun(@(sx,sz) meshgrid(1:sx,1:sz),sizeXXR,sizeZZR,'UniformOutput',0 );
            GV=cellfun(@(x,z,mx,mz, ix, iz) sum(sum(x(ix,:).*z(iz,:),2).^kernelParam.*mx(ix,:).*mz(iz,:)),XXR, ZZR,MFXR,MFZR,ixx, jzz);
            
            if strcmp(agregation,'sum')
                G=G+GV;
                GV=zeros(N,M);
            else
                G=G.*GV;
                GV=ones(N,M);
            end
            
        end
    case 1 %non-vectorized form
        for d=1:D
            
            for i=1:N
                sizeXX=size(XX{i,d},1);
                for j=1:M
                    sizeZZ=size(ZZ{j,d},1);
                    %for ix=1:size(XX{i,v},1) % number of points within each cell
                    for ix=1:sizeXX % number of points within each cell
                        %for jz=1:size(ZZ{j,v},1)
                        for jz=1:sizeZZ
                            GV(i,j)=GV(i,j)+(XX{i,d}(ix,:)*ZZ{j,d}(jz,:)').^kernelParam*MFX{i,d}(ix)*MFZ{j,d}(jz);                                                       
                        end
                    end
                    
                end
            end
            if strcmp(agregation,'sum')
                G=G+GV;
                GV=zeros(N,M);
            else
                G=G.*GV;
                GV=ones(N,M);
            end
            
            
        end
end

