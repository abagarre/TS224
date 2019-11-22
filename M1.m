clear all; clc ; close all;

%% PRÉLIMINAIRE 1

% Bruit blanc

N = 2^12;
sigma = 1;
mu = 0;

b = mu + randn(1,N)*sigma;

% Théorie : Rbb(tau) = sigma^2*delta(tau)

% Estimateur biaisé
Rbb_b = xcorr(b, 'biased');
figure, plot(-N+1:N-1, Rbb_b), title('Estimateur biaisé'), xlabel('tau'), ylabel('Rbb');
% Estimateur non biaisé
Rbb_nb = xcorr(b, 'unbiased');
figure, plot(-N+1:N-1, Rbb_nb), title('Estimateur non biaisé'), xlabel('tau'), ylabel('Rbb');

% Spectre de puissance
SP = abs(fftshift(fft(b))).^2/N;
figure, plot(-N/2:N/2-1, SP), title('SP');

% Densité spectrale de puissance
DSP = fftshift(fft(abs(Rbb_nb)));
figure, plot(-N+1:N-1, DSP), title('DSP (estimateur non biaisé)');

%% PRÉLIMINAIRE 2

Nfft = 2^6;
window = hamming(Nfft);
k = N/Nfft;
pw = zeros(Nfft, 1);
index = 1;

% Periodogramme de Welch
for i = 1:k
    xwindow = window.*b(index);
	index = index + Nfft;
    pw = pw + abs(fftshift(fft(xwindow, Nfft)));
end

pw = pw./norm(window);
figure, plot(-Nfft/2:Nfft/2-1,pw);

% Periodogramme de Daniell



