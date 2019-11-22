%% PRÉLIMINAIRE 1

% Bruit blanc

N = 1024;
sigma = 1;
mu = 0;

b = mu + randn(1,N)*sigma;

% Théorie : Rbb(tau) = sigma^2*delta(tau)

% Estimateur non biaisé
Rbb = 
