clear
close all
clc 

a = [1, -1.2676, 0.9, -0.2248];
b = [0.0691, 0.1346, 0.0691, 0.1346];
x = [1:16]

% d)
figure(1)
subplot(211); hold on; grid on;
stem(filter(b,a,x))
title("Impulsantwort von H1");
xlabel('Abtastpunkte');
ylabel('Abtastwert');

% g)
subplot(212); hold on; grid on;
stem(filter(residuez(b,a), [1,0,0], x));
title("Impulsantwort von H1 mit Partialbruchzerlegung");
xlabel('Abtastpunkte');
ylabel('Abtastwert');




