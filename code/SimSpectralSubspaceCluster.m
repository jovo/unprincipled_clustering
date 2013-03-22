% %% set simulation parameters
% clc; clear all;
% n=100;     % number of samples per subspace
% r=2;        % rank of *each* subspace
% k=2;        % number of subspaces
% c=0;        % mean shift of subspaces
% sig=0.3;
% kr=k*r;     % sum of ranks
% d=4;   % ambient dimension
% if d<kr, display('dim is too small'), break, end;
% 
% % generate data
% U={};
% UU=orth(randn(d,r+k-1)); % Only works for r=2
% for i=1:k
%     U{i}=UU(:,i:i+r-1);
% end
% 
% data=[];
% for i=1:k
%     Y{i}=U{i}*(c*ones(r,n)+sig*randn(r,n));
%     data=[data Y{i}];
% end
% data=data+0.2*ones(d,k*n);
% 
clc; clear; close all;


% rdpg parameters
mu0 = [0.8, 0.4]/4; % mean 0
mu1 = [0.2, 0.5]/2; % mean 1
rdpgparams.mu = [mu0, mu1];
rdpgparams.sig = 0.04; % stan dev
rdpgparams.d = 2;

% subspace params
subparams.rank=1;         % rank of *each* subspace
subparams.nSubspaces=2;   % number of subspaces
subparams.shift=1;        % mean shift of subspaces
subparams.DimAmbient=2;   % ambient dimension
if subparams.DimAmbient < subparams.nSubspaces * subparams.rank,
    display('dim is too small'),
    break,
end

n=1000;
nn=n/2;
[X, A, U, D] = GenEmbedPlotGraph(n,rdpgparams,'RRDPG',1);

% P=data'*data;
% % P(P<0)=0;
% % P(P>1)=1;
% P=tril(P,-1);
% P=P+P';
% 
% A=P>rand(k*n);
% nnz(A)/numel(A)
% 
% figure(4), clf
% subplot(221), imagesc(P), colorbar
% subplot(222), spy(A,5)
% subplot(223), 
% hold on, 
% plot3(data(1,1:n), data(2,1:n), data(3,1:n),'k.');
% plot3(data(1,n+1:end), data(2,n+1:end), data(3,n+1:end),'r+');
%
% [U D V] = svds(double(A),4);
Xhat=[U*D^(1/2)]';

[clusterind Uk] = kSubspacesLloyd(Xhat,2,rdpgparams.d,20);
clusterind=clusterind-1.5;

trueind=[zeros(1,nn), ones(1,nn)]-.5; 

min(sum((clusterind-trueind).^2),sum((-clusterind-trueind).^2))/(n)

[L,C] = kmeanspp(Xhat,2);
L=L-1.5;

min(sum((L-trueind).^2),sum((-L-trueind).^2))/(2*n)


% % subplot(221), imagesc(Xhat), colorbar
% subplot(224), hold on
% plot3(Xhat(1,1:n), Xhat(2,1:n), Xhat(3,1:n),'k.'); 
% plot3(Xhat(1,n+1:end), Xhat(2,n+1:end), Xhat(3,n+1:end),'r+');

% %%
% figure(2), clf
% data1=data(:,1:n)'*Uk{1};
% data2=data(:,n+1:end)'*Uk{1};
% 
