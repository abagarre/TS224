clear; clc; close all;

% hankel
% svd

%% Préliminaire 2

load("fcno03fz.mat");

% Bruit blanc

N = length(fcno03fz); % Nombre de points
mu = 0; % Moyenne
db = 5;

% Génération du bruit
Pbr  = (10^(db/10));
Psig = sum(fcno03fz.^2)/N;
sigm = Psig/Pbr;

s = fcno03fz' + randn(1,N).*sqrt(sigm);

figure;
subplot_axis(0, fcno03fz, 211);
subplot_axis(0, s, 212);

% Spectrogramme

Nfft = 2^8;

figure;
subplot 121, spectrogram(s, ones(1,Nfft), 128, Nfft);
subplot 122, spectrogram(fcno03fz, ones(1,Nfft), 128, Nfft);