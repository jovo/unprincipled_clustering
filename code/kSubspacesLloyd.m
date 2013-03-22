function [clusterind, Uk] = kSubspacesLloyd(X,k,d,maxIter)
% X is the matrix of data vectors (columns).
% k is the number of clusters.
% d is the dimension of clusters.
% maxIter is the number of subspace clustering iterations.

[m, n] = size(X);

% tX=zeros(size(X));
% for j=1:n
%     tX(:,j)=X(:,j);
% end
% Uk=nnfisuimd(tX,k,d);
Uk=nnfisuimd(X,k,d);

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
%             residual(i)= norm(x - U*(U\x));
            residual(i)= norm(x - U*(U'*x));
        end
        [~, assig(j)] = min(residual);
    end

    
    % Estimate subspaces

    for i=1:k
        Y = X(:,(assig==i));
        [U, ~, ~] = svd(Y);
        Uk{i} = U(:,1:d);
    end
    
end


clusterind = assig;
    
    