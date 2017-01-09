%% pre-setup
clc, clear all;
addpath(genpath('..\lib'));
addpath(genpath('..\util'));

%%  load data
load('..\data\dataset01\import.mat');

%%  parameters of MFCC
Tw = 25;           % analysis frame duration (ms)
Ts = 10;           % analysis frame shift (ms)
alpha = 0.97;      % preemphasis coefficient
R = [ 100 3700 ];  % frequency range to consider
% R = [ 10 7000 ];  % frequency range to consider
M = 20;            % number of filterbank channels
C = 13;            % number of cepstral coefficients
L = 22;            % cepstral sine lifter parameter
% hamming_func = @(N)(0.54-0.46*cos(2*pi*[0:N-1].'/(N-1)));
hamming_func = @(N)(hamming(N));


%%  abstraction and plot results
class = 2;
index = 10;
dim = 1;

[ MFCCs, ~, ~ ] = mfcc( data(info.index{class}(index), 10000:end), info.sampling_rate, Tw, Ts, alpha, hamming_func, R, M, C, L );
dMFCCs = deltas(MFCCs, 3);

figure;
plot(MFCCs(dim,:));
figure;
plot(dMFCCs(dim,:));

%%  plot whole results
class = 1:2;
dim = 1;
figure;
color_order = get(gca,'ColorOrder');
for c = class
    for i = info.index{c}
        [ MFCCs, ~, ~ ] = mfcc( data(i, 10000:end), info.sampling_rate, Tw, Ts, alpha, hamming_func, R, M, C, L );
        dMFCCs = deltas(MFCCs, 3);
        subplot(1,2,1);
        hold on;
        plot(MFCCs(dim,:), 'color', color_order(c,:));
        subplot(1,2,2);
        hold on;
        plot(dMFCCs(dim,:), 'color', color_order(c,:));
    end
end

