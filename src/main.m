%% pre-setup
clc, clear all;
addpath(genpath('..\lib'));
addpath(genpath('..\util'));

%%  load data
load('..\data\dataset02\import.mat');

%%  abstract feature
feature = feature_extraction(data, 'MFCC_std2', info.sampling_rate);

%%  iterative test
N_test = 1000;
confusion_pr_avg = zeros(2);
confusion_cnt_sum = zeros(2, 'int32');

for i=1:N_test
    %  divide dataset
    
    [tr_idx, tst_idx] = divide_dataset(info.index, 0.85);
    
    %  training
    model = learn_model(feature, tr_idx(1:2),'svm');
    
    %  prediction
    [confusion_pr, confusion_cnt] = predict_label(feature, tst_idx(1:2), model);
    confusion_pr_avg = confusion_pr_avg + confusion_pr;
    confusion_cnt_sum = confusion_cnt_sum + confusion_cnt;
    
    %   display current state
    clc;
    disp(sprintf('%d-th test', i));
    current_score = confusion_pr_avg / i
end

clear confusion_cnt confusion_pr i