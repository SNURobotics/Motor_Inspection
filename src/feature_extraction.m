function [ feature ] = feature_extraction( data, feature_name, varargin )
%FEATURE_EXCTRACTION Summary of this function goes here
%   Detailed explanation goes here

fn = str2func(['feature_', feature_name]);

feature = fn(data, varargin{:});

end

