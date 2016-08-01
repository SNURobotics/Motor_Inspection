function [ feature ] = feature_exctraction( data, feature_name, opt )
%FEATURE_EXCTRACTION Summary of this function goes here
%   Detailed explanation goes here

fn = str2func(['feature_', feature_name]);
if nargin < 3
    feature = fn(data);
else
    feature = fn(data, opt);
end


end

