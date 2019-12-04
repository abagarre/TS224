function [B_win] = decoupage(sig, power_divide, N)

%% Découpage en trames

L = length(sig);
% Avec recouvrement 50%
B = buffer(sig, N, N/2, 'nodelay')';


%% Fenetrage

B_win = (B'.*hamming(N))';


end

