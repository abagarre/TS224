clear; clc; close all;

%% %%%%%%%%% %%
%% Préambule %%
%% %%%%%%%%% %%

load("fcno03fz.mat");

L = length(fcno03fz);
power_divide = 8;
N = L/2^power_divide;

s = fcno03fz';

%% Génération du bruit
db = 10;
Pbr  = (10^(db/10));
Psig = sum(fcno03fz.^2)/L;
sigm = Psig/Pbr;

s_bruit = fcno03fz' + randn(1,L).*sqrt(sigm);

%% Découpage et fenêtrage

B_win = decoupage(s_bruit, N);



%% Reconstruction du signal

B_M = reconstruction(B_win, power_divide, N, L);



figure(2), plot_axis(0, B_M, "Signal reconstruit", "Temps", "Amplitude");