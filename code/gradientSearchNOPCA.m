function [xfinal mufinal cost] = gradientSearchNOPCA(A, d, numClusts, lambda, stepsize, numSteps) 
% Given a matrix A (an adjacency matrix) we're going to try to solve for x
% in the cost function
%   ||X-MU(tau)||_F^2 + lambda * ||A-X^TX||_F^2 
%
%   INPUTS:
%       A:          adjacency matrix in {0,1}^(n-x-n)
%       d:          # of embedded dimensions
%       numClusts:  # of clusters
%       lambda:     lagrange multiplier
%       stepsize:   step size
%       numsteps:   # of steps (not used)
% 
%   OUTPUTS:
%       xfinal:     final estimate of x in R^(n-x-d)
%       mufinal:    final estimate of means in R^(numClusts-x-d) 
%       cost:       final cost
% 
% mu are the means/centers of clusters, 
% tau is the assignment. 
% we will alternate, 
% 1) starting with an estimate for tau, 
% 2) and then finding mu
% 3) and x
% simultaenously with a gradient descent step. (is this true?)


n=length(A);
x=cell(1,numSteps);       % cell array of x
xx=zeros(n,d);          % temp variable for x
mu=cell(1,numSteps);      % cell array of mu
mm=zeros(numClusts,d);  % temp variable for mu
mumu=zeros(n,d);        % matrix of mu repeated
tau=zeros(1,n);         % cluster index for each data point

% initialize tau, x, mu
[U, D] = eigs(A,d);
x{1}=U(:,1:d);
[tau,mm] = kmeans(x{1},numClusts);

mumu(tau==1,:)=repmat(mm(1,:),sum(tau==1),1);
mumu(tau==2,:)=repmat(mm(2,:),sum(tau==2),1);

% Main algorithm
for k=2:numSteps

    % update x
    xx=x{k-1}; % store last version of x
    gradL = 2*xx-2*mumu+2*xx*xx'*xx-A*xx-A'*xx;
    xx =  xx - stepsize*gradL; % udpate
    x{k}=xx; % store new version
    
    % update mu    
    for c=1:numClusts
        xc=xx(tau==c,:);
        mm(c,:)=mean(xc);
    end
    mu{k}=mm;
    
    % redo tau
    for i=1:n
        xi=xx(i,:);
        for c=1:numClusts
            dists(c)=norm(xi-mm(c,:)); % calculate distances to all mu
        end
        [~, idx]=min(dists); % choose min distance center
        mumu(i,:)=mm(idx,:);   % fill repeated mu matrix with correct mu
    end

    % calculate cost
    cost=norm(xx-mumu,'fro')^2+lambda*norm(A-xx*xx','fro')^2;
    
end

% return only the final x and mu
xfinal=x{end};
mufinal=mu{end};
