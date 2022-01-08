clear
close all
clc 

x = chirp((0:511),0,511,0.02);
h = hanning(128)';
h = h/sum(h);
L = 256;

lh = length(h);
lx = length(x);

r = rem(lx,L);

% b) FFT Zero Padding von h
hb = [h zeros(1, L-1)];

H = fft(hb, L);

% c) FFT Zero Padding von x
xb = [x zeros(1, L-r)];

X = fft(xb, L);

% d) Faltung und die Ausgangssignale berechnen
nr = length(xb)/L;

for k = 1:nr
   % M1 = L samples werden aus xb genommen 
   M1(k,:) = xb(((k-1) * L+1):k * L);
   % M2 = es werden noch Länge von H - 1 Nullen angehängt
   M2(k,:) = [M1(k,:) zeros(1, lh-1)];
   % M3 = Multiplikation + Ausgangssignal mit ifft holen
   M3(k,:) = ifft(fft(M2(k,:)) .* fft(hb));
   % M4 wird für die Spaltenweise Addierung generier
   M4(k,:) = [zeros(1, (k-1)*L) M3(k,:) zeros(1, (nr-k) * L)];
end

% Zusammenrechnen der Spalten
z = sum(M4);

% f)
con = conv(x,h);


subplot(4,1,1);
stem(X);
title("Eingangssignal");

subplot(4,1,2);
stem(H);
title("Impulsantwort");

subplot(4,1,3);
stem(z);
title("Ausgangssignal");
xlim([0 1000]);

subplot(4,1,4);
stem(con);
title("conv");
xlim([0 1000]);


