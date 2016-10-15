function [ feature ] = feature_MFCC_interv( data, sample_rate)
%FEATURE_MFCC_STD Summary of this function goes here
%   data        : N by D matrix
%   feature     : N by d matrix

%% MFCC parameters

Tw = 25;           % analysis frame duration (ms)
Ts = 10;           % analysis frame shift (ms)
alpha = 0.97;      % preemphasis coefficient
R = [ 100 3700 ];  % frequency range to consider
% R = [ 10 7000 ];  % frequency range to consider
M = 20;            % number of filterbank channels
C = 13;            % number of cepstral coefficients
L = 22;            % cepstral sine lifter parameter

hamming = @(N)(0.54-0.46*cos(2*pi*[0:N-1].'/(N-1)));

%%  divide interval

N = 3;
scope = round(linspace(1, size(data,2), N+1));
% scope = sec2frame( [1.5, 5, 6, 10, 11.99], sample_rate);
N = length(scope) -1;
%%  abstraction

MFCCs = mfcc( data(1, scope(1):scope(2)), sample_rate, Tw, Ts, alpha, hamming, R, M, C, L );
d = size(MFCCs,1);
feature = zeros(size(data,1), d * N);
for i = 1 : size(data, 1)
%     data(i,:) = data(i,:)/max(abs(data(i,:)));  % normalize
    for j = 1:N
        [ MFCCs, ~, ~ ] = mfcc( data(i, scope(j):scope(j+1)), sample_rate, Tw, Ts, alpha, hamming, R, M, C, L );
        feature(i,d*(j-1)+1:d*j) = std(MFCCs, 0, 2);
    end
    
    
end



end

