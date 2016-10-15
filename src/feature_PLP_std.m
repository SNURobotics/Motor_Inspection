function [ features ] = feature_PLP_std( data, sample_rate, varargin)
%FEATURE_PLP_STD Summary of this function goes here
%   Detailed explanation goes here

scope = [1, size(data, 2) ];

%%  abstraction

[cep, spec] = rastaplp(  data(1, scope(1):scope(2) ), sample_rate, varargin{:} );
features = zeros(size(data,1), size(cep,1));

for i = 1 : size(data, 1)
%     data(i,:) = data(i,:)/max(abs(data(i,:)));  % normalize
    [ cep, spec ] = rastaplp(  data(i, scope(1):scope(2) ), sample_rate, varargin{:});
    features(i,:) = std(cep, 0, 2);
end

end

