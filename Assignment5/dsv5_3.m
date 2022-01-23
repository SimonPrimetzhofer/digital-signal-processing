clear all;
close all

nullstellen = [-1, 1j, -1j];
% P1 ist implizit 0, sonst geht zplane nicht
polstellen = [0.75 + 0.25j, 0.75 - 0.25j];

zplane(nullstellen, polstellen);