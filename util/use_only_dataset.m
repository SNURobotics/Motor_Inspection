function [ info_new ] = use_only_dataset( info, dataset_index)
%USE_ONLY_DATASET Summary of this function goes here
%   Detailed explanation goes here

num_old_samples = [100, 50, 49];    %   good, worst, bad
info_new.label = int16([]);
info_new.index = cell(1,3);

if dataset_index == 1
    for c = 1:length(info.index)
        info_new.index{c} = info.index{c}( 1:num_old_samples(c) );
        info_new.label = [ info_new.label, repmat(c, 1, num_old_samples(c) ) ];
    end
elseif dataset_index == 2
    for c = 1:length(info.index)
        info_new.index{c} = info.index{c}( num_old_samples(c)+1:end );
        info_new.label = [ info_new.label, repmat(c, 1, length(info_new.index{c}) ) ];
    end
else
    info_new = info;
end


end

