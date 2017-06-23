function [mat] = condSep(vec,varargin)
%turns vec into a matrix with a column for each condition (varargin) inputted

i=1;
while i <= length(varargin)
    mat(:,i) = vec(varargin{i});
    i=i+1;
end