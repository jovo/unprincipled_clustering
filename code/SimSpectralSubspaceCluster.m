%% set simulation parameters
clc; clear all;
n=100;     % number of samples
r=2;        % rank of *each* subspace
k=2;        % number of subspaces
c=0.5;        % mean shift of subspaces
sig=0.05;
kr=k*r;     % sum of ranks
d=4;   % ambient dimension
if d<kr, display('dim is too small'), break, end;

% generate data
U={};
UU=orth(randn(d,r+k-1)); % Only works for r=2
for i=1:k
    U{i}=UU(:,i:i+r-1);
end

data=[];
for i=1:k
    Y{i}=U{i}*(c*rand(r,1)*ones(1,n)+sig*randn(r,n));
    data=[data Y{i}];
end

A=data'*data;
subplot(121), imagesc(data), colorbar
subplot(122), imagesc(A), colorbar