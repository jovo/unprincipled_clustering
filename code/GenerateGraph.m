function [A, X] = GenerateGraph(n,d,mu,sigma)
%   n: number vertices
%   d: # dimensions of latent positions

mu0 = mu(1:d);
mu1 = mu(d+1:end);

X0 = sigma*randn(n/2,d)+repmat(mu0',1,n/2)';
X1 = sigma*randn(n/2,d)+repmat(mu1',1,n/2)';
X  = [X0; X1];  % in R^(n x d)
 
P=X*X';                 % probability matrix
A=double(P>rand(n,n));  % adjacency matrix
A=tril(A,-1);           
A=A'+A;                 % symmetric adjacency matrix