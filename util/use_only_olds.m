function [ info_old ] = use_only_olds( info )
%SAMPLE_OLD_MOTORS Summary of this function goes here
%   Detailed explanation goes here

num_old_samples = [100, 50, 49];    %   good, worst, bad
info_old.label = int16([]);
info_old.index = cell(1,3);
for c = 1:length(info.index)
    info_old.index{c} = info.index{c}( 1:num_old_samples(c) );
    info_old.label = [ info_old.label, repmat(c, 1, num_old_samples(c) ) ];
end



end

