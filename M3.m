clear; clc; close all;

%% %%%%%%%%%%%%
%% Préambule %%
%% %%%%%%%%%%%%

load("fcno03fz.mat");

%% Découpage en trames

L = length(fcno03fz);
power_divide = 8;
N = L/2^power_divide;
% Sans recouvrement
M = reshape(fcno03fz, [N, 2^power_divide])';
% Avec recouvrement 50%
B = buffer(fcno03fz, N, N/2, 'nodelay')';

%%  Génération du bruit
db = 5;
Pbr  = (10^(db/10));
Psig = sum(fcno03fz.^2)/L;
sigm = Psig/Pbr;

M_noise = M + randn(size(M)).*sqrt(sigm);
B_noise = B + randn(size(B)).*sqrt(sigm);

%% Fenetrage

M_win = (M'.*hamming(N))';
B_win = (B'.*hamming(N))';


%% Reconstruction du signal

V_M = reshape(M_win', [L,1]);

B_M = zeros(N/2,2^(power_divide+1));
B_M(:,1) = B_win(1,1:N/2);
for i = 2:2^(power_divide+1)-1
    B_M(:,i) = B_win(i,1:N/2) + B_win(i-1,(N/2+1):N);
end
B_M(:,i+1) = B_win(i,N/2+1:N);
B_M = reshape(B_M, [L,1]);

