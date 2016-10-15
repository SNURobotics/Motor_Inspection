function [ model ] = learn_model( feature, tr_idx, method, varargin )
%LEARN_MODEL Summary of this function goes here
%   Detailed explanation goes here

X_tr = [];
y_tr = [];
for c = 1:length(tr_idx)
    X_tr = [X_tr; feature(tr_idx{c}, :)];
    y_tr = [y_tr; repmat(c, length(tr_idx{c}), 1)];
end


fn = str2func(['fitc',method]);

model = fn(X_tr, y_tr, varargin{:});

end