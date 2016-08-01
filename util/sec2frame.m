function [ f ] = sec2frame( t, sample_rate )
%SEC2FRAME Summary of this function goes here
%   Detailed explanation goes here

f = floor(t * sample_rate + 1);
% f = floor( f * 1000 ) / 1000;

end

