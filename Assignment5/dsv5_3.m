clear all;
close all

nullstellen = [-1, 1j, -1j];
% P1 ist implizit 0, sonst geht zplane nicht
polstellen = [0.75 + 0.25j, 0.75 - 0.25j, 0];

zplane(nullstellen(:), polstellen(:));

b = [-1j^2, -1j^2, 1, 1];
a = [(-9/16)+(1j^2)/16, -3/2, 1];

freqz(b,a);

impz(b,a,50);