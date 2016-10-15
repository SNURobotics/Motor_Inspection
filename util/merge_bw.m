function [ info ] = merge_bw( info )
%MERGE_BW Summary of this function goes here
%   Detailed explanation goes here

info.index{2} = [info.index{2}, info.index{3}];
info.index(3) = [];
info.label(info.label==3) = 2;

end

