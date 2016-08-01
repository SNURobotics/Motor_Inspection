function [ confusion_mat_pr, confusion_mat_cnt ] = predict_label( feature, tst_idx, model )
%PREDICT_TESTSET Summary of this function goes here
%   Detailed explanation goes here

X_tst = [];
y_tst = [];
for c = 1:length(tst_idx)
    X_tst = [X_tst; feature(tst_idx{c}, :)];
    y_tst = [y_tst; repmat(c, length(tst_idx{c}), 1)];
end

[label, ~] = predict(model, X_tst);

confusion_mat_pr = zeros(length(tst_idx));
confusion_mat_cnt = zeros(length(tst_idx), 'int32');

for c = 1:length(tst_idx)
   for p = 1:length(tst_idx)
       result = label(y_tst==c)==p;
       confusion_mat_pr(c,p) = mean(result);
       confusion_mat_cnt(c,p) = sum(result);
   end
end


end

