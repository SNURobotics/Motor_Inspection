function [ data, info ] = save_data01( path )
%LOAD_DATA Summary of this function goes here
%   Detailed explanation goes here

%%  handling varargin
if nargin < 1
    path = '..\data\dataset01\';
end

%%  pre-define variables and constant
class_label = {'g','w','b'};
n_class = length(class_label);
n_files = zeros(1,n_class);
n_data_length = 220500;
info.index = cell(1,n_class);
file_list = cell(1,n_class);
info.label = int16([]);

%%   count number of data
for c=1:n_class
    file_list{c} = dir([path, '\',class_label{c},'*.mat']);
    n_files(c) = length(file_list{c});
    info.index{c} = int16( (1:length( file_list{c} ) ) );
    if c ~= 1
       info.index{c} = info.index{c} + n_files(c-1); 
    end
    info.label = [info.label, repmat(c, 1, length(file_list{c}))];
end

%%  load raw data
data = zeros(sum(n_files), n_data_length, 'single');
idx = 1;
for c=1:n_class  
    for i=1:length(file_list{c})
        load([path, '\',file_list{c}(i).name]);
        data(idx,:) = single(recData.');
        idx = idx+1;
    end
end

info.sampling_rate = recSampleRate;
save([path, '\','import.mat'], 'data', 'info');

end

