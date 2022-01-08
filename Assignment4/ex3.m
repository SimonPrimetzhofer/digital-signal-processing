clear
close all
clc 

x = [0 4 0 -3]
h = [0 1/3 1/9 1/27]

y = conv(x, h);

n = 0:3

subplot(3,1,1);
stem(n,x);
title("x[n]");

subplot(3,1,2);
stem(n, h);
title("h[n]");

subplot(3,1,3);
stem(y);
title("y[n]");

