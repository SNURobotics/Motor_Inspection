function [ feature ] = feature_MFCC_tst( data, sample_rate, varargin)
%FEATURE_MFCC_STD Summary of this function goes here
%   data        : N by D matrix
%   feature     : N by d matrix

%% MFCC parameters

% scope = [100000, 150000];
scope = [1, size(data, 2) ];
% scope = [1, 200000 ];

%%  abstraction
[MFCCs, ~, ~] = melfcc( data(1, scope(1):scope(2)), sample_rate);
feature = zeros(size(data,1), size(MFCCs,1));
for i = 1 : size(data, 1)
%     data(i,:) = data(i,:)/max(abs(data(i,:)));  % normalize
    [ MFCCs, FBEs, frames ] = mfcc( data(i, scope(1):scope(2)), sample_rate, Tw, Ts, alpha, hamming, R, M, C, L );
    feature(i,:) = std(MFCCs, 0, 2);
end



end

