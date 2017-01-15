function [ filename, saveAs,delimiter, startRow,formatSpec] = readData( name , noiseLevel, option)
% read data from option, return the path  in filename and the name to save
% experiment in saveAs
%   name={'sonar', 'pima', 'spambase', 'ring', 'twonorm', 'wdbc' }
%   noiseLevel={5,10,15,20}
%   option={'nn', 'nc', 'cn'}

%---------------------------
%datasets, # classes 2
% Name          #Attributes 	#Examples

filename=strcat('datasets/',name,'-',int2str(noiseLevel),'an-',option,'-5-fold/',name,'-',int2str(noiseLevel),'an-',option,'-5-');
saveAs=strcat(name,'-',int2str(noiseLevel),'an-',option,'-5-fold.mat');

switch (name)
    case 'pima'
        delimiter = ',';
        startRow = 14;
        %formatSpec = '%n%n%n%n%n%n%n%n%s%[^\n\r]';
        formatSpec = '%n%n%n%n%n%n%n%n%s';
    case 'ring'
        delimiter = ',';
        startRow = 26;
        formatSpec='%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n';
    case 'sonar'
        delimiter = ',';
        startRow = 66;        
        formatSpec='%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%s';
    case 'spambase'
        delimiter = ',';
        startRow = 63;        
        formatSpec='%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%s'
    case 'twonorm'
        delimiter = ',';
        startRow = 26;        
        formatSpec='%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%s'
    case 'wdbc'
        delimiter = ',';
        startRow = 36;        
        formatSpec='%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%s'
end


end

