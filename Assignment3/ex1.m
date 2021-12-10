clear
close all
clc 

fs = 10;
f1 = 4;
f2 = 6;
dur = 2*pi;
T = 1/fs;
fvec = T:T:dur;

x1 = sin(2*pi*f1*fvec);
x2 = sin(2*pi*f2*fvec);
xn = x1 + x2;

figure;
plot(fvec, xn);
