clear 
close all
clc

%% Initialisation des variables

Fe = 20e6; % Frequence d'echantillonnage (imposee par le serveur)
Rb = 1e6; % Debit binaire (=debit symbole)
Fse = floor(Fe/Rb); % Nombre d'echantillons par symboles
Nfft = 1024;
Nfft2 = 128;
Nb = 1e4; % Nombre de bits générés
dt = 1/Fe;
df = 1/Nfft2/dt;
window = hanning(Nfft2); % Génération d'une fenêtre de Hamming

%% Algorithme du périodogramme de Welch

DSP = zeros(1,Nfft);

for i = 1:100
    
    nl = randn(1,Nb*Fse);
    
    for l = 1:length(sl)
        slexp(l) = sl(l)+nl(l);
    end

    Rsl = xcorr(slexp);
    
    DSPexp = fftshift(abs(fft(Rsl,Nfft).^2/length(Rsl)));
    
    
    for j = 1:Nfft
        DSP(j)=DSP(j)+DSPexp(j);
    end
end

DSP = 1/100*DSP;

t=-Fe/2:Fe/Nfft:Fe/2-1;


DSP = DSP';
k = fix(max(size(DSP))/Nfft2);
index = 1:Nfft2;
K = k*norm(window)^2;
P = zeros(Nfft2, 1);

for i = 1:k
    xwindow = window.*DSP(index);
	index = index + Nfft2;            
	P = P + fftshift(abs(fft(xwindow,Nfft2)).^2);
end

 Pxx = dt*(P)/K;  
 F = -Fe/2:df:Fe/2-1;
 
 D = ((sin(F/2*pi)./(F/2*pi)).^4).*((pi*F).^2);
 

semilogy(F,Pxx); 
xlabel('Frequence [Hz]'); 
ylabel('DSP');
grid on;
hold on;
%semilogy(F,D);

