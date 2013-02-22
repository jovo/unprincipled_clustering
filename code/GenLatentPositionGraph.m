function [A, P] = GenLatentPositionGraph(X)

P=X*X'; % probability matrix
[n,~]=size(P);
A=double(P>rand(n,n)); % adjacency matrix
A=tril(A,-1);
A=A'+A; % symmetric adjacency matrix