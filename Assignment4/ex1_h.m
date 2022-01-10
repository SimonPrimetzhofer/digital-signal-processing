clear
close all
clc 

pkg load signal;

a = [1, -1.2676, 0.9, -0.2248];
b = [0.0691, 0.1346, 0.0691, 0.1346];
x = [1:16]

% h)
zplane(b,a);
