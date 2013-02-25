function X = GenLatentPositionsRDPG(n,params)

d=params.d;         % dimension of latent space
mu=params.mu;       % means
sigma=params.sig;   % variances

mu0 = mu(1:d);
mu1 = mu(d+1:end);

X0 = sigma*randn(n/2,d)+repmat(mu0',1,n/2)';
X1 = sigma*randn(n/2,d)+repmat(mu1',1,n/2)';
X = [X0; X1]; % in R^(n x d)
