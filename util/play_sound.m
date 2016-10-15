function [  ] = play_sound( dataset_type, label, index , start_t, end_t)
%PLAY_SOUND Summary of this function goes here
%   Detailed explanation goes here

if nargin < 1 |  isempty(dataset_type)
    dataset_type = 1;
end
if nargin < 2 | isempty(label)
    label = 'g';
end


path = ['..\data\dataset0',num2str(dataset_type),'\'];
file_list = dir([path, '\',label,'*.mat']);

if nargin < 3 | isempty(index)
    index = randperm(length(file_list),1);
end

load([path, '\',file_list(index).name]);

if dataset_type == 1
    data = recData;
else
    data = recData_prm;
end

data = data/max(abs(data));

total_time = frame2sec(length(data), recSampleRate);

if nargin < 4
    start_t = 0;
end
if nargin < 5
    end_t = total_time;
end

start_f = sec2frame(start_t, recSampleRate);
end_f = min(sec2frame(end_t, recSampleRate), length(data));

player = audioplayer(data(start_f:end_f), recSampleRate);
play(player);
pause(player.TotalSamples / player.SampleRate);

end

