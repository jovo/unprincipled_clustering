function [X, A, U, D] = GenEmbedPlotRSubspaceG(n,d,mu,sigma)

% generate graph
[X] = GenerateLatentSubspacePositions(n,d,mu,sigma);
[A] = GenLatentPositionGraph(X);

% embed graph
[U, D] = eigs(A,2); % eigen decomposition
% D(D<0)=0;
Xhat = U*D; %^(1/2);
    
% plot results
plotLatentPositionGraph(A,X,Xhat, 1);