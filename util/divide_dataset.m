function [ trIdx, tstIdx ] = divide_dataset( index, training_ratio )
%DIVIDE_DATASET Summary of this function goes here
%   Detailed explanation goes here

trIdx = cell(3,1);
tstIdx = cell(3,1);
for c = 1:length(index)
    rand_idx = sort(randperm(length(index{c}), round(length(index{c})*training_ratio)));
    trIdx{c} = index{c}(rand_idx);
    tstIdx{c} = index{c};
    tstIdx{c}(rand_idx) = [];
end

end

