clear
close all
clc 

function X = dtft(x,n,w)
%DTFT Computes Discrete-time Fourier transform
%   @param  x: finite duration sequence over n
%   @param  n: sample position vector
%   @param  w: freqeuncy location vector
%   @return X: DTFT values computed at w frequencies
  X = exp(-1i*w'*n)  * x.';
end

N = -11;
M = 11;
n = N:M; 

xn = (0.8).^(abs(n)) .* (stepseq(-10, N, M) - stepseq(11, N, M));

omega = linspace(-pi, pi);

X0 = dtft(xn, n, omega);

figure;
subplot(311); hold on; grid on;
plot(n, xn);
xlabel('n');
title('Sequenz');

subplot(312); hold on; grid on;
plot(omega, abs(X0));
xlabel('Omega');
title('Betrag');

subplot(313); hold on; grid on;
plot(omega, angle(X0));
xlabel('Omega');
title('Phase');