clear; clc; close all;

% hankel
% svd

%% Traitement d'une trame d'un signal de parole bruité par un bruit blanc gaussien

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

Len = length(s);
power_divide = 8;
N = Len/2^power_divide;

S = decoupage(s, power_divide, N);

L = S(1,1:120); % Construction du vecteur L
M = S(1,120:208); % Construction du vecteur M (L > M)

Matrice_hankel = hankel(L,M);

[U,Somme,V] = svd(Matrice_hankel);
D = diag(Somme);

Somme_valeur_singuliere = sum(D);

figure; hold on;
for l = 1:length(D)
    plot(l,sum(D(1:l))/Somme_valeur_singuliere);
end



