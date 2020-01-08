function [B_win] = decoupage(sig, N)

%% Découpage en trames

% Avec recouvrement 50%
B = buffer(sig, N, N/2, 'nodelay')';


%% Fenetrage

B_win = (B'.*hamming(N))';


end

