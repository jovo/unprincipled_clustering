function X = GenLatentPositions(n,params,kind)

% generate latent positions
switch kind
    case 'RRDPG'
        X = GenLatentPositionsRDPG(n,params);
    case 'Subspace'
        X = GenLatentSubspacePositions(n,params);
end
