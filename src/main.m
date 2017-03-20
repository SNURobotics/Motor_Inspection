%% pre-setup
clc, clear all;
addpath(genpath('..\lib'));
addpath(genpath('..\util'));

%%  load data
load('..\data\dataset01\import.mat');

%%  abstract feature
tic;
feature = feature_extraction(data, 'MFCC_std', info.sampling_rate);
% feature = feature_extraction(data, 'MFCC_tst', info.sampling_rate);
% feature = feature_extraction(data, 'MFCC_delta_std', info.sampling_rate);
% feature = feature_extraction(data, 'MFCC_delta_raw', info.sampling_rate);
% feature = feature_extraction(data, 'Rasta_PLP_cep_std', info.sampling_rate,0,12);
% feature = feature_extraction(data, 'Rasta_PLP_spec_std', info.sampling_rate);
% feature = feature_extraction(data, 'MFCC_GMM', info.sampling_rate);
% feature = randn(size(data,1), 12);
toc;
%%  iterative test
N_test = 1000;
confusion_pr_avg = zeros(2);
confusion_cnt_sum = zeros(2, 'int32');

info_copy = info;
% info_copy = use_only_olds(info);
% info_copy = use_only_dataset(info, 1);
% info_copy = merge_bw(info);

for i=1:N_test
    %  divide dataset
    
    [tr_idx, tst_idx] = divide_dataset(info_copy.index, 0.85);
    
    %  training
    
        model = learn_model(feature, tr_idx(1:2),'svm');
    %         model = learn_model(feature, tr_idx(1:2),'svm','KernelFunction','rbf','KernelScale','auto','KKTTolerance',1e-9);
    %     model = learn_model(feature, tr_idx(1:2),'svm','KernelScale','auto');
%         model = learn_model(feature, tr_idx(1:2),'svm','Standardize', true, 'KernelFunction','rbf', 'KernelScale','auto');
    %     model = learn_model(feature, tr_idx(1:2),'svm','Standardize', false, 'KernelFunction','rbf', 'KernelScale','auto');
    %     model = learn_model(feature, tr_idx(1:2),'linear');
    %     model = learn_model(feature, tr_idx(1:2),'discr');
    %     model = learn_model(feature, tr_idx(1:2),'knn','NumNeighbors',3,'Standardize',0);
    
    %  prediction
    [confusion_pr, confusion_cnt] = predict_label(feature, tst_idx(1:2), model);
    confusion_pr_avg = confusion_pr_avg + confusion_pr;
    confusion_cnt_sum = confusion_cnt_sum + confusion_cnt;
    
    %   display current state
    clc;
    fprintf('%d-th test\n', i);
    current_score = confusion_pr_avg / i
    whole_score = sum(diag(confusion_cnt_sum)) / sum(confusion_cnt_sum(:))
end


clear confusion_cnt confusion_pr i