
clear all;
clc;
close all;
load ../data/M87102217_fiber.mat
tic
[u,s,v]=svds(fibergraph,2);
toc

Xhat=u';
[clusterind Uk] = kSubspacesLloyd(Xhat,2,1,20);
% clusterind=clusterind-1.5;

% trueind=[zeros(1,nn), ones(1,nn)]-.5; 

% min(sum((clusterind-trueind).^2),sum((-clusterind-trueind).^2))/(n)

[L,C] = kmeanspp(Xhat,2);
% L=L-1.5;

% min(sum((L-trueind).^2),sum((-L-trueind).^2))/(2*n)

figure;
subplot(2,1,1);
idx=find(clusterind==1);
plot(Xhat(1,idx),Xhat(2,idx),'ro');
hold on;
idx=find(clusterind==2);
plot(Xhat(1,idx),Xhat(2,idx),'bo');

subplot(2,1,2);
idx=find(L==1);
plot(Xhat(1,idx),Xhat(2,idx),'ro');
hold on;
idx=find(L==2);
plot(Xhat(1,idx),Xhat(2,idx),'bo');