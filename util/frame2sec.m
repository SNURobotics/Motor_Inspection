function [ t ] = frame2sec( f, sample_rate )
%FRAME2SEC Summary of this function goes here
%   Detailed explanation goes here

t = (f-1) / sample_rate;

end

