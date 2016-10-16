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
    % default
    %     [ MFCCs, ~, ~ ] = melfcc( data(i, scope(1):scope(2)), sample_rate);
    % Malcolm Slaney's mfcc
%     [ MFCCs, ~, ~ ] = melfcc( data(i, scope(1):scope(2)), sample_rate, 'wintime', 0.016, 'lifterexp', 0, 'minfreq', 133.33, 'maxfreq', 6855.6, 'sumpower', 0);
    % HTK's MFCC
    [ MFCCs, ~, ~ ] = melfcc( data(i, scope(1):scope(2)), sample_rate, 'nbands', 20, 'lifterexp', -22, 'maxfreq', 8000, 'sumpower', 0, 'fbtype', 'htkmel', 'dcttype', 3);
%     [ MFCCs, ~, ~ ] = melfcc( data(i, scope(1):scope(2)), sample_rate, 'nbands', 20, 'lifterexp', -22, 'minfreq', 100, 'maxfreq', 3700, 'sumpower', 0, 'fbtype', 'htkmel', 'dcttype', 3);
    feature(i,:) = std(MFCCs, 0, 2);
end



end

