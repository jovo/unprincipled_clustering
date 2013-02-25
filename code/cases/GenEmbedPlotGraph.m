function [X, A, U, D] = GenEmbedPlotGraph(n,params,kind,nFig)

[X] = GenLatentPositions(n,params,kind);
[A] = GenLatentPositionGraph(X);

% embed graph
[U, D] = eigs(A,2); % eigen decomposition
% D(D<0)=0;
Xhat = U*D; %^(1/2);
    
% plot results
plotLatentPositionGraph(A,X,Xhat, nFig);