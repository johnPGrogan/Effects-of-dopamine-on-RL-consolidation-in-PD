function sem = SEM(numPps,varargin)
% calculates standard error of the mean 
%inputs: numPps - number of participants to use for SEM - set equal to ~ to
%make automatic
%varargin - matrices of raw data [participants,conditions]
%output: returns the SEM matrix [varargins,conds]
for i = 1:size(varargin,2)%for number of matrices inputted
    X = varargin{i};%get current matrix
    [~,J] = size(X);%get number of pps & conds
    sem(i,:) = nanstd(X)/sqrt(numPps);  
end