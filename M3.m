clear; clc; close all;

%% %%%%%%%%% %%
%% Préambule %%
%% %%%%%%%%% %%

load("fcno03fz.mat");

L = length(fcno03fz);
power_divide = 8;
N = L/2^power_divide;

%% Découpage et fenêtrage

B_win = decoupage(fcno03fz, power_divide, N);

%% Reconstruction du signal

B_M = reconstruction(B_win, power_divide, N, L);

plot_axis(0, B_M, "Signal reconstruit", "Temps", "Amplitude");