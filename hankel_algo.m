clear; clc; close all;

%% Traitement d'une trame d'un signal de parole bruité par un bruit blanc gaussien

load("fcno03fz.mat");

% Bruit blanc

Len = length(fcno03fz);
s = fcno03fz';
mu = 0; % Moyenne

% Génération du bruit
db = 10;
Pbr  = (10^(db/10));
Psig = sum(fcno03fz.^2)/Len;
sigm = Psig/Pbr;

s_bruit = fcno03fz' + randn(1,Len).*sqrt(sigm);

power_divide = 8;
N = Len/2^power_divide;

S = decoupage(s_bruit, N);
s = buffer(s, N, N/2, 'nodelay')';
s_bruit = buffer(s_bruit, N, N/2, 'nodelay')';

S_rec = zeros(size(S));

for i = 1:length(S)
    
    yl = floor(N-N/8);
    L = S(i,1:yl); % Construction du vecteur L
    M = S(i,yl:N); % Construction du vecteur M (L > M)

    Hy = hankel(L,M);

    [U,Somme,V] = svd(Hy);
    D = diag(Somme);

    Somme_vs = sum(D);

    Dl = 1:length(D);

    for l = 1:length(D)
        Dl(l) = sum(D(1:l))/Somme_vs;
    end

    % figure, plot(1:l, Dl, '.');
    seuil = 0.4;
    min_value = find(Dl > seuil, 1);
    
    H_rec = U(:,1:min_value)*Somme(1:min_value,1:min_value)*V(:,1:min_value)';
    [h, w] = size(H_rec);

    % Moyennage des anti-diagonnages
    H_hankel = hankel_transform(H_rec);

    [h_h, w_h] = size(H_hankel);
    S_rec(i,:) = [H_hankel(1:end-1,1)' H_hankel(w_h,:)];
    
    i*100/length(S)
    
end

S_final = reconstruction(S_rec, power_divide, N, Len);

% plot_axis(0, S_final, "Signal réhaussé", "Temps", "Amplitude");

snr(fcno03fz, S_final-fcno03fz)

S_final_trame = buffer(S_final, N, N/2, 'nodelay')';

figure();
hold on;
plot(s(200,:),"r");
plot(s_bruit(200,:),"b");
plot(S_final_trame(200,:),"g");
title("Comparaison de trame temporelle")
xlabel("Temps");
ylabel("Amplitude");
legend("trame originale","trame bruitée","trame réhaussée");



