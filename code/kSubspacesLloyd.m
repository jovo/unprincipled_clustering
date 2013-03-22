function [clusterind] = kSubspacesLloyd(X,k,d,maxIter)
% Cluster incomplete data vectors into subspaces.
%
% incompleteDataClustering(X,goodidxMat,goodidxVec,k,d,step_size,maxIter)
%
% X is the matrix of data vectors (columns).
%
% goodidxVec is a matrix of size (#obs) x (#columns of X).
%
% goodidxMat is a matrix of the same size as goodidxVec, but if you called
% X(vec(goodidxMat)) you'd get all the observed entries in the whole
% matrix.
%
% k is the number of clusters.
% d is the dimension of clusters.
% step_size is for grouse subspace estimation.
% maxIter is the number of subspace clustering iterations.

[m n] = size(X);

tX=zeros(size(X));
for j=1:n
    tX(:,j)=X(:,j);
end
Uk=nnfisuimd(tX,k,d);


    fprintf('\nIter #');

for iter=1:maxIter %number of k-subspace iterations
    
    if mod(iter,10)==0 || n*m > 10000
    fprintf('%d ',iter);
    end
    
    
    % Estimate cluster assignments.
    for j=1:n
        x = X(:,j);
        
        residual=zeros(1,k);
        for i=1:k
            U = Uk{i};
            residual(i)= norm(x - U*(U\x));
            
        end
        [v assig(j)] = min(residual);
    end

    
    % Estimate subspaces

    for i=1:k
        Y = X(:,(assig==i));
        [U S V] = svd(Y);
        Uk{i} = U(:,1:d);
    end
    
end


clusterind = assig;
    
    