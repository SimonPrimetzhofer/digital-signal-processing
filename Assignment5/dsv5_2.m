% JKU, Digitale Signalverarbeitung UE, WS 2021/22
%#########################################################################
% Assignment 5, Aufgabe2 : Cauer Filter
%#########################################################################

%--- Tolerance Schema
Omega_pass = 0.1*pi;
Omega_stop = 0.15*pi;
Rp         = 0.5;
Rs         = 60;

%--- D(elta)1 und D(elta)2
% Rp = 20 log(1/1 - 2D1)
% Rp/20 = log(1/1 - 2D1)
% 10^(Rp/20) = 1/1-2D1
% 10^(Rp/20) * (1-2D1) = 1
% - 2D1 = (1 / 10^(Rp/20)) - 1
% D1 = (((1 / 10^(Rp/20)) - 1) / -2)
D1 = (((1 / 10^(Rp/20)) - 1) / -2);

% Rs = 20 log (1/D2)
% Rs / 20 = log (1/D2)
% 10^(Rs / 20) = 1/D2
% D2 = 1 / (10^(Rs /20)
D2 = 1 / (10 ^ (Rs/20));

%--- Aufgabe3.a.i : Filterordnung
[N, Wp] = ellipord(Omega_pass, Omega_stop, Rp, Rs);

%--- Aufgabe3.a.ii : Filterkoeffizienten
[bC,aC] = ellip(N, Rp, Rs, Wp);

%--- Aufgabe3.a.iv : Betragsgang mit Toleranzgrenzen
figure(21); hold off
fftl=1024;                                      % number of frequency samples
[H1,fv]=freqz(bC,aC,fftl);                       % Frequenzgang


plot(fv/pi,20*log10(abs(H1))); hold on;        %Zeichnen Sie hier den Betragsgang in d

% Toleranzgrenzen berechnen:
TGo_w = [0, Omega_stop, Omega_stop, pi];
TGo_m = [(1+D1), (1+D1), D2, D2]; 
TGu_w = [0, Omega_pass, Omega_pass, pi];
TGu_m = [(1-D1), (1-D1), 0, 0];

plot(TGo_w, 20*log10(TGo_m), 'r', TGu_w, 20*log10(TGu_m + 1e-12), 'r')

grid on;
axis([0,pi,-250,5])
xlabel('\Omega/\pi')
ylabel('20*log(|H(e^{j\Omega})|)')

%--- Aufgabe3.a.v : Gruppenlaufzeit
figure(22); hold off
fftl=1024;                                   % number of frequency samples
[gd1,fv]=grpdelay(bC,aC,fftl)

plot(fv/pi,gd1); hold on;
grid on;
xlabel('Frequency')
ylabel('Gruppenlaufzeit')

%--- Aufgabe3.a.vi : Pol-Nullstellen Diagramm
figure(23); hold off
zplane(bC, aC);                                     %Zeichnen Sie hier das Pol-Nullstellen Diagramm

%=========================================================================
%Aufgabe3.b : Festkomma Implementierung
%=========================================================================
N_fractional_bits = 12; % Nachkomma Stellen der Koeffizienten
bCq=round(bC*2^N_fractional_bits)/2^N_fractional_bits;
aCq=round(aC*2^N_fractional_bits)/2^N_fractional_bits;

%Überprüfen Sie die Stabilität des Filters mit quantisierten Koeffizienten.
figure(25); hold off
zplane(bC, aC);
% Falls alle punkte im Kreis drinenn sind -> Filter ist Stabil


%=========================================================================
%Aufgabe3.c : Kaskadierte Struktur
%=========================================================================
%--- Aufgabe3.c.i
[z,p,k] = ellip(N, Rp, Rs, Wp);;

%--- Aufgabe3.c.ii
[SOS]         = zp2sos(z,p,k);

%--- Aufgabe3.c.iii
%Zeichnen Sie hier die Betragsgänge der einzelnen Teilfilter und des Gesamtfilters
%Achten Sie auf korrekte Achsenbeschriftung und fügen Sie eine Legende zur
%Unterscheidung der einzelen Linien.
figure(24); hold off

[H, fv] = freqz(SOS(1, 1:3), SOS(1, 4:6), fftl);
plot(fv, H); hold on;

[H, fv] = freqz(SOS(2, 1:3), SOS(2, 4:6), fftl);
plot(fv, H); hold on;

[H, fv] = freqz(SOS(3, 1:3), SOS(3, 4:6), fftl);
plot(fv, H); hold on;

[b,a] = sos2tf(SOS);
[H, fv] = freqz(b,a,fftl);
plot(fv, H); hold on;  

grid on;
xlabel('Frequency')
legend("Teilfilter 1", "Teilfilter 2", "Teilfilter 3", "gesamter Filter")

%--- Aufgabe3.c.iv
N_fractional_bits = 12; % Nachkomma Stellen der Koeffizienten
SOSq = round(SOS*2^N_fractional_bits)/2^N_fractional_bits;

%Überprüfen Sie die Stabilität der Teilfilter mit quantisierten Koeffizienten.
figure(26); hold on

zplane(SOSq(1, 1:3), SOSq(1, 4:6)); 
title("Teilfilter 1")
figure(27); hold on
zplane(SOSq(2, 1:3), SOSq(2, 4:6));
title("Teilfilter 2")
figure(28); hold on
zplane(SOSq(3, 1:3), SOSq(3, 4:6));
title("Teilfilter 3")
