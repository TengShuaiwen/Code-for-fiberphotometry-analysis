function error = sem(x,varargin)
% error = sem(x,varargin):  Compute the standard error of the mean(SEM)
%
% Syntax
%		error = sem(x,varargin)
%       e.g. sem(magic(3)); sem(magic(3),1); sem(magic(3),2);
%
% Input
%		x: vector or matrix
%		varargin: none or 1 or 2
%
% Output
%		SEM
 
% Version: 2.0, 10 August 2018
% Author:  Penglai Liu
% E-mail:  penglailiu@gmail.com


if isempty(varargin)
    if numel(mean(x))==1                                % sem([1,2,3,4,5])
        error = std(x,0)/sqrt(numel(x));
    elseif numel(mean(x))>1                             % sem(magic(5))
        error = std(x,0,1)/sqrt(size(x,1));
    end
end 

if ~isempty(varargin)                                   % sem(magic(5),1)
    error = std(x,0,varargin{:})/sqrt(size(x,varargin{:}))%varargin是一个元胞数组，varargin{:}是调用所有未被指定变量的输入参数
end

end