function [foo bar] = SpectralSubspaceClustering(A,d)


[U D V] = svds(A,d);

X=[U; D*V];
% subspace cluster