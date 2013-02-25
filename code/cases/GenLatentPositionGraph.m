function [A, P] = GenLatentPositionGraph(X,dampen)

P=X*X'; % probability matrix

if nargin==2
    P=P*dampen;
    P(1:n,1:n)=(1/dampen)*P(1:n,1:n);
    P(n+1:2*n, n+1:2*n)=(1/dampen)*P(n+1:2*n,n+1:2*n);
end

[n,~]=size(P);
A=double(P>rand(n,n)); % adjacency matrix
A=tril(A,-1);
A=A'+A; % symmetric adjacency matrix