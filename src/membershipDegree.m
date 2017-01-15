function mf = membershipDegree(x,f,pos)
%UNTITLED Summary of this function goes here
%   eval membership degree of var values based on membership function f
%   (D dimensional vector) as a function of pos (D dimensional vector)
mf = interp1(pos,f,x);% linear interpolation

% %only for plot
% indTrim=find(isnan(mf)); % trim nan values
% mf(indTrim)=[];
% x(indTrim)=[];
% 
% %plot
% plot(pos,f,'r')
% hold on
% plot(x,mf,'o');

end

% membershipDegree([1,2374 1,25 3,13 0,44],aaa(2,:),aaa(1,:))

