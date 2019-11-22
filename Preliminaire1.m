clear all ; clc ; close all ;

%% Préliminaire 1

% Génération d'un bruit blanc de moyenne nulle et de variance sigma carré

N = 2048; % Nombre de points

sigma = 1; % Variance

mu = 0; % Moyenne

b = mu + randn(1,N)*sigma; % Génération du signal bruité

% Fonction d'autocorrélation théorique du signal bruité :
% Rbb(tau) = sigma^2 * delta(tau)

[Rbb_theorique, LAGS] = xcorr(b,'coeff'); % Fonction d'autocorrélation théorique du signal bruité

figure(1);
plot(LAGS, Rbb_theorique); % Représentation graphique de la fonction d'autocorrélation
title('Fonction dautocorrélation théorique dun bruit blanc');
xlabel('Tau');
ylabel('Rbb');


[Estimateur_biase, LAGS] = xcorr(b, 'biased'); % Estimateur biaisé de la fonction d'autocorrélation théorique du signal bruité

figure(2);
plot(LAGS, Estimateur_biase); % Représentation graphique de l'estimateur biaisé de la fonction d'autocorrélation
title('Estimateur biaisé de la fonction dautocorrélation théorique dun bruit blanc');
xlabel('Tau');
ylabel('Rbb');


[Estimateur_non_biase, LAGS] = xcorr(b, 'unbiased'); % Estimateur non biaisé de la fonction d'autocorrélation théorique du signal bruité

figure(3);
plot(LAGS, Estimateur_non_biase); % Représentation graphique de l'estimateur non biaisé de la fonction d'autocorrélation
title('Estimateur non biaisé de la fonction dautocorrélation théorique dun bruit blanc');
xlabel('Tau');
ylabel('Rbb');