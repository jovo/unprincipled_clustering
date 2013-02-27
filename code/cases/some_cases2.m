clc; clear; close all;


% rdpg parameters
mu0 = [0.8, 0.4]/4; % mean 0
mu1 = [0.2, 0.5]/2; % mean 1
rdpgparams.mu = [mu0, mu1];
rdpgparams.sig = 0.04; % stan dev
rdpgparams.d = 2;

% subspace params
subparams.rank=1;         % rank of *each* subspace
subparams.nSubspaces=2;   % number of subspaces
subparams.shift=1;        % mean shift of subspaces
subparams.DimAmbient=2;   % ambient dimension
if subparams.DimAmbient < subparams.nSubspaces * subparams.rank,
    display('dim is too small'),
    break,
end



for i = 1:4;
    switch i
        case 1 % small sparse graph
            n = 100; % # vertices
            [X, A, U, D] = GenEmbedPlotGraph(n,rdpgparams,'RRDPG',i);
        case 2 % large sparse graph
            n = 5000;
            [X, A, U, D] = GenEmbedPlotGraph(n,rdpgparams,'RRDPG',i);
        case 3  % small subspace graph
            n=200;                 % number of vertices
            [X, A, U, D] = GenEmbedPlotGraph(n,subparams,'Subspace',i);
        case 4  % large subspace graph
            n=5000;     % number of samples
            [X, A, U, D] = GenEmbedPlotGraph(n,subparams,'Subspace',i);
    end
end


