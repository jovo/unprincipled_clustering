
clear all;
clc;
close all;

%% load data

thingy = 'eigen2'; % which thingy to load
switch thingy
    case 'graph' % whole graphs
        load('../data/M87102217_fiber.mat')
        tic
        [u,s,v]=svds(fibergraph,2);
        time.svd=toc;       
        clear fibergraph
        save('../data/M87102217_embedding','u','s','v')
        
    case 'eigen100' % top 100 eigenvectors of lcc
        load('../data/M87102217_eigvect.mat')
        
    case 'eigen2' % top 2 eigvectors of lcc
        load('../data/M87102217_embedding')
        
end

%%  cluster


Xhat=u';
tic
[clusterind Uk tocs_ksubspaces] = kSubspacesLloyd(Xhat,70,1,20);
time.ksubspace=toc
% clusterind=clusterind-1.5;

% trueind=[zeros(1,nn), ones(1,nn)]-.5; 

% min(sum((clusterind-trueind).^2),sum((-clusterind-trueind).^2))/(n)

tic
[L,C, tocs_kmeans] = kmeanspp(Xhat,70);
time.kmeans=toc
% L=L-1.5;

% min(sum((L-trueind).^2),sum((-L-trueind).^2))/(2*n)

save('../data/clustered'); %,'clusterind','Uk','u','s','v','L','C','time','tocs_ksubspaces','tocs_kmeans')
%%

% load('../data/clustered');
%%
% Xhat=u';


figure;
subplot(311);
idx=find(clusterind==1);
plot(Xhat(1,idx),Xhat(2,idx),'ro');
hold on;
idx=find(clusterind==2);
plot(Xhat(1,idx),Xhat(2,idx),'bo');

subplot(312);
idx=find(L==1);
plot(Xhat(1,idx),Xhat(2,idx),'ro');
hold on;
idx=find(L==2);
plot(Xhat(1,idx),Xhat(2,idx),'bo');

load('../data/M87102217concomp.mat')
subplot(313);
idx=find(lcc < 100);
plot(Xhat(1,idx),Xhat(2,idx),'ro');
hold on;
idx=find(lcc > 100);
plot(Xhat(1,idx),Xhat(2,idx),'bo');
