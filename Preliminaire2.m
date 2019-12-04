clear all ; clc ; close all ;

%% Préliminaire 2

load('fcno03fz.mat'); % Signal de parole à bruiter

% Génération d'un bruit blanc de moyenne nulle et de variance sigma carré

N = length(fcno03fz); % Nombre de points
sigma = 500; % Variance
mu = 0; % Moyenne

b = (mu + randn(1,N)*sigma)'; % Génération du bruit

Signal_bruit = fcno03fz + b; % Génération du signal bruité

figure, plot(fcno03fz);
figure, plot(Signal_bruit);

