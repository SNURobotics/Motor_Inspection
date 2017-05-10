function [ feature ] = feature_MFCC_std( data, sample_rate, dim)
%FEATURE_MFCC_STD Summary of this function goes here
%   data        : N by D matrix
%   feature     : N by d matrix

%% MFCC parameters

% scope = [100000, 150000];
scope = [1, size(data, 2) ];
% scope = [1, 200000 ];

% Tw = 25;           % analysis frame duration (ms)
% Ts = 10;           % analysis frame shift (ms)
% alpha = 0.97;      % preemphasis coefficient
% R = [ 100 3700 ];  % frequency range to consider
% % R = [ 10 7000 ];  % frequency range to consider
% M = 20;            % number of filterbank channels
% C = 13;            % number of cepstral coefficients
% L = 22;            % cepstral sine lifter parameter


% original parameter
% Tw = 25;           % analysis frame duration (ms)
% Ts = 10;           % analysis frame shift (ms)
% alpha = 0.97;      % preemphasis coefficient
% % R = [ 300 3700 ];  % frequency range to consider
% R = [ 10 7000 ];  % frequency range to consider
% M = 20;            % number of filterbank channels
% C = 13;            % number of cepstral coefficients
% L = 22;            % cepstral sine lifter parameter

% highly tuned parameter
% Tw = 10;           % analysis frame duration (ms)
% Ts = 5;           % analysis frame shift (ms)
% alpha = 0.95;      % preemphasis coefficient
% R = [ 250 3650 ];  % frequency range to consider
% % R = [ 10 7000 ];  % frequency range to consider
% M = 40;            % number of filterbank channels
% C = 11;            % number of cepstral coefficients
% L = 10;            % cepstral sine lifter parameter

% best performance parameter with linear SVM(not much tuned)
Tw = 25;           % analysis frame duration (ms)
Ts = 10;           % analysis frame shift (ms)
alpha = 0.97;      % preemphasis coefficient
R = [ 100 3700 ];  % frequency range to consider
% R = [ 10 7000 ];  % frequency range to consider
M = 20;            % number of filterbank channels
C = 13;            % number of cepstral coefficients
L = 22;            % cepstral sine lifter parameter

if nargin < 3
    dim = C;
end


% hamming_func = @(N)(0.54-0.46*cos(2*pi*[0:N-1].'/(N-1)));
hamming_func = @(N)(hamming(N));


%%  abstraction
MFCCs = mfcc( data(1, scope(1):scope(2)), sample_rate, Tw, Ts, alpha, hamming_func, R, M, dim, L );
feature = zeros(size(data,1), size(MFCCs,1));
for i = 1 : size(data, 1)
%     data(i,:) = data(i,:)/max(abs(data(i,:)));  % normalize
    [ MFCCs, FBEs, frames ] = mfcc( data(i, scope(1):scope(2)), sample_rate, Tw, Ts, alpha, hamming_func, R, M, dim, L );
    
    feature(i,:) = std(MFCCs, 0, 2).';
end



end

