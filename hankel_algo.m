clear; clc; close all;

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

L = S(1,1:150); % Construction du vecteur L
M = S(1,150:208); % Construction du vecteur M (L > M)

Hy = hankel(L,M);

[U,Somme,V] = svd(Hy);
D = diag(Somme);

Somme_vs = sum(D);

Dl = 1:length(D);

for l = 1:length(D)
    Dl(l) = sum(D(1:l))/Somme_vs;
end

% figure, plot(1:l, Dl, '.');
seuil = 0.9;
min_value = find(Dl > seuil, 1);

H_rec = U(:,1:min_value)*Somme(1:min_value,1:min_value)*V(:,1:min_value)';
[h, w] = size(H_rec);

% Moyennage des anti-diagonnages
H_hankel = zeros(size(H_rec));
H_hankel(1:w,1:w) = hankel_transform(H_rec(1:w,1:w));


[h_h, w_h] = size(H_hankel);
S_rec = [H_hankel(:,1)' H_hankel(w_h,:)];


