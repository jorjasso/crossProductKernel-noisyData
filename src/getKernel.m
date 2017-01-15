% jorge.jorjasso@gmail.com,
% modified version of gridSearch.m in TSK-kernels-Low-quality
%  at
%  https://github.com/jorjasso/TSK-kernels-Low-quality/blob/master/getKernel.m
% date 09 set 2015
function G = getKernel(option, varargin)
%varargin = X,Z, parameters=[...]
X =varargin{1};
Z=varargin{2};
kernelParam=cell2mat(varargin(3:end));
beta_par=0.5;
switch lower(option)
    %--------------------------------------
    % p(x| mu,cov)=1/L, i.e uniform
    case 1% linear kernel
        %disp('linear kernel')
        G=X*Z';
    case 2 %polinomial kernel
        %G=((X*Z'+kernelParam(1)).^kernelParam(2));
        G=((X*Z').^kernelParam);
    case 3 % gaussian kernel
        G=exp(-0.5*kernelParam*sqdistAll(X,Z));
        %-------------------------------------------------------------------
        % kernels TSK nonsingleton (antecedent part of rules) gaussian MF
        %-------------------------------------------------------------------
    case 4 % gaussian TSK no parameter
        G=kerTSK_0(X,Z);
    case 5 % gaussian TSK with parameter
        G=kerTSK_1(X,Z,kernelParam);
    case 6 % gaussian TSK with parameter (is kerTSK_0 with lambda parameter as in RBF)
        G=kerTSK_2(X,Z,kernelParam);
        %-------------------------------------------------------------------
        % kernels TSK nonsingleton (antecedent + consequent part of rules)
        %-------------------------------------------------------------------
    case 7 % Eq 6.16 (Thesis)
        XX=(X{1}+X{2})./2;
        ZZ=(Z{1}+Z{2})./2;
        G=kerTSK_0(X,Z).*(XX*ZZ');
    case 8 % same as Eq 6.16 (Thesis) but with kernel TSK1
        XX=(X{1}+X{2})./2;
        ZZ=(Z{1}+Z{2})./2;
        G=kerTSK_1(X,Z,kernelParam).*(XX*ZZ');
    case 9 % same as Eq 6.16 (Thesis) but with kernel TSK2
        XX=(X{1}+X{2})./2;
        ZZ=(Z{1}+Z{2})./2;
        G=kerTSK_2(X,Z,kernelParam).*(XX*ZZ');
    case 10 % same as Eq 6.17 (Thesis) but with kernel TSK0
        stdX=abs (X{1}-X{2})/2.3548; %sigma=(l-r)*/2*sqrt(2*log(2))
        stdZ=abs (Z{1}-Z{2})/2.3548; %sigma=(l-r)*/2*sqrt(2*log(2))
        stdX(stdX==0)=0.00000000001; %12 x 4
        stdZ(stdZ==0)=0.00000000001; %2 x 4
        mX=(X{1}+X{2})./2;           %12 x 4
        mZ=(Z{1}+Z{2})./2;           %2 x 4
        
        
        
        stdX_2=stdX.*stdX;
        stdZ_2=stdZ.*stdZ;
        
        [m,~]=size(stdX);
        [n,~]=size(stdZ);
        GG=zeros(m,n);
        for i=1:m
            for j=1:n
                GG(i,j)=dot(mX(i), (mX(i).*stdZ_2(j)+mZ(j).*stdX_2(i))/(stdX_2(i)+stdZ_2(j)));
            end
        end
        
        % as theta paremeters are for fuzzy sets in the rule, then:
        %theta=(mX.*(stdZ.*stdZ) + mZ.*(stdZ.*stdZ))./((stdZ.*stdZ) +(stdZ.*stdZ));
        G=kerTSK_0(X,Z).*GG;
    case 11 % Eq 6.17 (Thesis)
        
        stdX=abs (X{1}-X{2})/2.3548; %sigma=(l-r)*/2*sqrt(2*log(2))
        stdZ=abs (Z{1}-Z{2})/2.3548; %sigma=(l-r)*/2*sqrt(2*log(2))
        stdX(stdX==0)=0.00000000001; %12 x 4
        stdZ(stdZ==0)=0.00000000001; %2 x 4
        mX=(X{1}+X{2})./2;           %12 x 4
        mZ=(Z{1}+Z{2})./2;           %2 x 4
        
        
        
        stdX_2=stdX.*stdX;
        stdZ_2=stdZ.*stdZ;
        
        [m,~]=size(stdX);
        [n,~]=size(stdZ);
        GG=zeros(m,n);
        for i=1:m
            for j=1:n
                GG(i,j)=dot(mX(i), (mX(i).*stdZ_2(j)+mZ(j).*stdX_2(i))/(stdX_2(i)+stdZ_2(j)));
            end
        end
        
        
        G=kerTSK_1(X,Z,kernelParam).*GG;
        
    case 12 % same as Eq 6.17 (Thesis) but with kernel TSK2
        stdX=abs (X{1}-X{2})/2.3548; %sigma=(l-r)*/2*sqrt(2*log(2))
        stdZ=abs (Z{1}-Z{2})/2.3548; %sigma=(l-r)*/2*sqrt(2*log(2))
        stdX(stdX==0)=0.00000000001; %12 x 4
        stdZ(stdZ==0)=0.00000000001; %2 x 4
        mX=(X{1}+X{2})./2;           %12 x 4
        mZ=(Z{1}+Z{2})./2;           %2 x 4
        
        
        
        stdX_2=stdX.*stdX;
        stdZ_2=stdZ.*stdZ;
        
        [m,~]=size(stdX);
        [n,~]=size(stdZ);
        GG=zeros(m,n);
        for i=1:m
            for j=1:n
                GG(i,j)=dot(mX(i), (mX(i).*stdZ_2(j)+mZ(j).*stdX_2(i))/(stdX_2(i)+stdZ_2(j)));
            end
        end
        
        G=kerTSK_2(X,Z,kernelParam).*GG;
    case 13 % Eq 6.18 (Thesis)
        XX=(X{1}+X{2})./2;
        ZZ=(Z{1}+Z{2})./2;
        G=kerTSK_0(X,Z).*exp(-kernelParam*sqdistAll(XX,ZZ));
        
    case 14 % same as Eq 6.18 (Thesis) but with kernel TSK1
        XX=(X{1}+X{2})./2;
        ZZ=(Z{1}+Z{2})./2;
        
        %median heuristic
        if length(XX)+length(ZZ) > 1000
            kPer=1000;
            indX=randperm(length(XX),kPer) ;
            indZ=randperm(length(ZZ),kPer) ;
            MM=[XX(indX,:);ZZ(indZ,:)];
        else
            MM=[XX;ZZ];
        end
        M=sqdistAll(MM,MM);
        lambda=median(M(:));
        %-----------------------
        
        G=kerTSK_1(X,Z,kernelParam).*exp(-(1/lambda)*sqdistAll(XX,ZZ));
        
    case 15 % same as Eq 6.18 (Thesis) but with kernel TSK2
        XX=(X{1}+X{2})./2;
        ZZ=(Z{1}+Z{2})./2;
        %median heuristic
        if length(XX)+length(ZZ) > 1000
            kPer=1000;
            indX=randperm(length(XX),kPer) ;
            indZ=randperm(length(ZZ),kPer) ;
            MM=[XX(indX,:);ZZ(indZ,:)];
        else
            MM=[XX;ZZ];
        end
        M=sqdistAll(MM,MM);
        lambda=median(M(:));
        %-----------------------
        G=kerTSK_2(X,Z,kernelParam).*exp(-(1/lambda)*sqdistAll(XX,ZZ));
        
        
        
        %--------------------------------------------------------------------
        % substitution fuzzy distance kernel
        %--------------------------------------------------------------------
    case 16  % kernel TSK_0 as distance substitution kernel
        
        G=kerTSK_0_distance(X,Z,kernelParam);
        
    case 17 % kernel TSK_0 (Eq 6.16 (Thesis)) as distance substitution kernel
        G=kerTSK_0_distance1(X,Z,kernelParam);
        
        
    case 18 % lemma 17 thesis
        G=kerD1(X,Z,kernelParam);
    case 19 % lemma 17 thesis
        G=kerD2(X,Z,kernelParam);
        % multiple kernel fuzzy
        
    case 20 % lemma 17 thesis (variation of)
        G=kerD3(X,Z,kernelParam);
        
    case 21 % lemma 17 thesis (variation of)
        G=kerD4(X,Z,kernelParam);
        
        %----------------------------------------------------------------------
        % multiples kernels
        %----------------------------------------------------------------------
        
    case 22 % kernel id = 6
        XX=(X{1}+X{2})./2;
        ZZ=(Z{1}+Z{2})./2;
        G=beta_par*kerTSK_0(X,Z)+(1-beta_par)*exp(-0.5*kernelParam*sqdistAll(XX,ZZ));
        
    case 23 % kernel id = 7
        XX=(X{1}+X{2})./2;
        ZZ=(Z{1}+Z{2})./2;
        G=beta_par*exp(-0.5*kernelParam*sqdistAll(XX,ZZ)).*kerTSK_0(X,Z)+(1-beta_par)*exp(-0.5*kernelParam*sqdistAll(XX,ZZ));
        
    case 24 % kernel id = 8
        XX=(X{1}+X{2})./2;
        ZZ=(Z{1}+Z{2})./2;
        G=beta_par*kerD1(X,Z,kernelParam)+(1-beta_par)*exp(-0.5*kernelParam*sqdistAll(XX,ZZ));
        
    case 25 % kernel id = 9
        XX=(X{1}+X{2})./2;
        ZZ=(Z{1}+Z{2})./2;
        G=beta_par*kerD2(X,Z,kernelParam)+(1-beta_par)*exp(-0.5*kernelParam*sqdistAll(XX,ZZ));
        
        
        % fuzzyDistanceKernel.m intersectionKernel.m, considerar cada
        % variable como por ejemplo X{i,4} = gaussmf(sample,[ (temp(2)-temp(1))/(2*sqrt(2*log(2))) ,mean(temp)]);
        
        %---------------------------------
        % fuzzy distance with metrics
        % intersection kernel
        % distance substitution with intersection kernel
        % distance substitution with cross product kernels
        
        %--------------------------------------------------------------------
        % Cross product kernels
        %--------------------------------------------------------------------
        % X={(x1 X(x1)), (x2,X(x2),...,(xN,X(xN)))}
        %X{1} points :x1,...,xN
        %X{2} membership degree of points : X(x1),...,X(xN)
    case 30 % TABLE 1 linear
        
        
        [N,nVar]= size(X{1});
        [M,~]= size(Z{1});
        XX=X{1};
        ZZ=Z{1};
        
        MFX=X{2};
        MFZ=Z{2};
        G=zeros(N,M);
        GV=zeros(N,M);
        for v=1:nVar
            
            for i=1:N
                sizeXX=size(XX{i,v},1);
                for j=1:M
                    sizeZZ=size(ZZ{j,v},1);
                    %for ix=1:size(XX{i,v},1) % number of points within each cell
                    for ix=1:sizeXX % number of points within each cell
                        %for jz=1:size(ZZ{j,v},1)
                        for jz=1:sizeZZ
                            GV(i,j)=GV(i,j)+(XX{i,v}(ix,:)*ZZ{j,v}(jz,:)')*MFX{i,v}(ix)*MFZ{j,v}(jz);
                            
                        end
                    end
                    %vectorized form (useful  if there are a lot of points per cell)
                    %[ixx, jzz]=meshgrid(1:sizeXX,1:sizeZZ);
                    %GV(i,j)=sum(sum(XX{i,v}(ixx,:).* ZZ{j,v}(jzz,:),2).* MFX{i,v}(ixx,:).*MFZ{j,v}(jzz,:));
                end
            end
            G=G+GV;
            GV=zeros(N,M);
            
            % vetorized code (incomplete)
            % f = @(x)size(x,1);
            % sizeXXX=cellfun(f,XX, 'UniformOutput', false)
            % sizeZZZ=cellfun(f,ZZ, 'UniformOutput', false)
            % g=@(x,y,sx,sy) ([ixx, jzz]=meshgrid(1:sx,1:sy))
            
            
        end
        
    case 31 % TABLE 1 polynomial
        
        [N,~]= size(X{1});
        [M,nVar]= size(Z{1});
        XX=X{1};
        ZZ=Z{1};
        
        MFX=X{2};
        MFZ=Z{2};
        G=zeros(N,M);
        GV=zeros(N,M);
        for v=1:nVar
            for i=1:N
                sizeXX=size(XX{i,v},1);
                for j=1:M
                    sizeZZ=size(ZZ{j,v},1);
                    for ix=1:sizeXX % number of points within each cell
                        for jz=1:sizeZZ
                            GV(i,j)=GV(i,j)+(XX{i,v}(ix,:)*ZZ{j,v}(jz,:)').^kernelParam*MFX{i,v}(ix)*MFZ{j,v}(jz);
                            
                        end
                    end
                end
            end
            G=G+GV;
            GV=zeros(N,M);
        end
    case 32 % TABLE 1 exponential
        
        [N,~]= size(X{1});
        [M,nVar]= size(Z{1});
        XX=X{1};
        ZZ=Z{1};
        
        MFX=X{2};
        MFZ=Z{2};
        G=zeros(N,M);
        GV=zeros(N,M);
        for v=1:nVar
            for i=1:N
                sizeXX=size(XX{i,v},1);
                for j=1:M
                    sizeZZ=size(ZZ{j,v},1);
                    for ix=1:sizeXX % number of points within each cell
                        for jz=1:sizeZZ
                            GV(i,j)=GV(i,j)+exp(kernelParam*(XX{i,v}(ix,:)*ZZ{j,v}(jz,:)'))*MFX{i,v}(ix)*MFZ{j,v}(jz);
                        end
                    end
                end
            end
            G=G+GV;
            GV=zeros(N,M);
        end
        
    case 33 % TABLE 1 gaussian
        
        [N,~]= size(X{1});
        [M,nVar]= size(Z{1});
        XX=X{1};
        ZZ=Z{1};
        
        MFX=X{2};
        MFZ=Z{2};
        G=zeros(N,M);
        GV=zeros(N,M);
        for v=1:nVar
            for i=1:N
                sizeXX=size(XX{i,v},1);
                for j=1:M
                    sizeZZ=size(ZZ{j,v},1);
                    for ix=1:sizeXX % number of points within each cell
                        for jz=1:sizeZZ
                            GV(i,j)=GV(i,j)+exp(-kernelParam*norm(XX{i,v}(ix,:)-ZZ{j,v}(jz,:))^2)*MFX{i,v}(ix)*MFZ{j,v}(jz);
                        end
                    end
                end
            end
            G=G+GV;
            GV=zeros(N,M);
        end
        
        
    case 34 % linear with prod
        [N,nVar]= size(X{1});
        [M,~]= size(Z{1});
        XX=X{1};
        ZZ=Z{1};
        
        MFX=X{2};
        MFZ=Z{2};
        G=ones(N,M);
        GV=zeros(N,M);
        for v=1:nVar
            for i=1:N
                sizeXX=size(XX{i,v},1);
                for j=1:M
                    sizeZZ=size(ZZ{j,v},1);
                    for ix=1:sizeXX % number of points within each cell
                        for jz=1:sizeZZ
                            GV(i,j)=GV(i,j)+(XX{i,v}(ix,:)*ZZ{j,v}(jz,:)')*MFX{i,v}(ix)*MFZ{j,v}(jz);
                            
                        end
                    end
                end
            end
            G=G.*GV;
            GV=ones(N,M);
        end
    case 35 % polynomial with prod
        [N,~]= size(X{1});
        [M,nVar]= size(Z{1});
        XX=X{1};
        ZZ=Z{1};
        
        MFX=X{2};
        MFZ=Z{2};
        G=ones(N,M);
        GV=zeros(N,M);
        for v=1:nVar
            for i=1:N
                sizeXX=size(XX{i,v},1);
                for j=1:M
                    sizeZZ=size(ZZ{j,v},1);
                    for ix=1:sizeXX % number of points within each cell
                        for jz=1:sizeZZ
                            GV(i,j)=GV(i,j)+(XX{i,v}(ix,:)*ZZ{j,v}(jz,:)').^kernelParam*MFX{i,v}(ix)*MFZ{j,v}(jz);
                        end
                    end
                end
            end
            G=G.*GV;
            GV=ones(N,M);
        end
    case 36 % exponential with prod
        [N,~]= size(X{1});
        [M,nVar]= size(Z{1});
        XX=X{1};
        ZZ=Z{1};
        
        MFX=X{2};
        MFZ=Z{2};
        G=ones(N,M);
        GV=zeros(N,M);
        for v=1:nVar
            for i=1:N
                sizeXX=size(XX{i,v},1);
                for j=1:M
                    sizeZZ=size(ZZ{j,v},1);
                    for ix=1:sizeXX % number of points within each cell
                        for jz=1:sizeZZ
                            GV(i,j)=GV(i,j)+exp(kernelParam*(XX{i,v}(ix,:)*ZZ{j,v}(jz,:)'))*MFX{i,v}(ix)*MFZ{j,v}(jz);
                            
                        end
                    end               
                end
            end
            G=G.*GV;
            GV=ones(N,M);
        end
    case 37 % gaussian with prod
        [N,~]= size(X{1});
        [M,nVar]= size(Z{1});
        XX=X{1};
        ZZ=Z{1};
        
        MFX=X{2};
        MFZ=Z{2};
        G=ones(N,M);
        GV=zeros(N,M);
        for v=1:nVar
            for i=1:N
                sizeXX=size(XX{i,v},1);
                for j=1:M
                    sizeZZ=size(ZZ{j,v},1);
                    for ix=1:sizeXX % number of points within each cell
                        for jz=1:sizeZZ
                            GV(i,j)=GV(i,j)+exp(-kernelParam*norm(XX{i,v}(ix,:)-ZZ{j,v}(jz,:))^2)*MFX{i,v}(ix)*MFZ{j,v}(jz);
                        end
                    end            
                end
            end
            G=G.*GV;
            GV=ones(N,M);
        end
        
    case 38 %
    case 39 %
    otherwise
        disp('Unknown method.')
        
        
end
