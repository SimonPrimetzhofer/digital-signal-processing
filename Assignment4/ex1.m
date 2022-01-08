clear
close all
clc 

a = [1, -1.2676, 0.9, -0.2248];
b = [0.0691, 0.1346, 0.0691, 0.1346];
x = [1:16]

% d)

stem(filter(b,a,x))
title("Impulsantwort von H1");
xlabel('Abtastpunkte');
ylabel('Abtastwert');

% e)

[h,w] = freqz(b, a, 1024, 'whole');
w = w - pi;
freqz_plot(w,h, true);

% f)
h2 = filter(b,a,x);
[h2,w2] = freqz(h2, a, 1024, 'whole');
w2 = w2-pi;

figure('name', 'Assignment 4 f)');
subplot(211); hold on; grid on;
plot(w,20*log10(abs(h)));
title('H1');
ylabel('Magnitude [dB]');
xlabel('Samples');

subplot(212); hold on; grid on;
plot(w2, 20*log10(abs(h2)));
title('H2');
ylabel('Magnitude [dB]');
xlabel('Samples');

