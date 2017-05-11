%% pre-setup
clc, clear all;
addpath(genpath('..\lib'));
addpath(genpath('..\util'));

%%  load data
load('..\data\dataset01\import.mat');

%%  iterative test
N_test = 5000;
info_copy = info;
% info_copy = use_only_olds(info);
% info_copy = use_only_dataset(info, 1);
% info_copy = merge_bw(info);
for f = 1:20
    cnf_pr_sum = zeros(2);
    feature = feature_extraction(data, 'MFCC_delta_std', info.sampling_rate, f);
    for i=1:N_test
        %  divide dataset
        [tr_idx, tst_idx] = divide_dataset(info_copy.index, 0.85);
        
        %  training
        model = learn_model(feature, tr_idx(1:2),'svm');
        
        %  prediction
        [cnf_pr, ~] = predict_label(feature, tst_idx(1:2), model);
        cnf_pr_sum = cnf_pr_sum + cnf_pr;
        
        %   display current state
        clc;
        fprintf('%d-th test\n', i);
        cnf_pr_avr(:,:,f) = cnf_pr_sum / i
    end
end

clear confusion_cnt confusion_pr i