function [ features ] = feature_PLP_whole_std( data, sample_rate, varargin )
%FEATURE_PLP_STD Summary of this function goes here
%   Detailed explanation goes here

scope = [1, size(data, 2) ];

%%  abstraction

features = lpc(double(data(:, scope(1):scope(2)).') , varargin{1});
features = features(:, 2:end);

return;
end

