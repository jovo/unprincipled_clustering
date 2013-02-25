function [A, P] = GenLatentSubspaceGraph(X,dampen)

P=(X*X');
dampen=1;%;.3;
P=P*dampen;
P(1:n/2,1:n/2)=(1/dampen)*P(1:n/2,1:n/2);
P(n/2+1:n, n/2+1:n)=(1/dampen)*P(n/2+1:n,n/2+1:n);

A=double(P>rand(n,n)); % adjacency matrix
A=tril(A,-1);
A=A'+A; % symmetric adjacency matrix
