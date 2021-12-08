clear
close all
clc 

pkg load signal

fs = 200;
f = 50;
dur = 0.5;
T = 1/fs;
fvec = T:T:dur;

N_w = 64;
N = 2048;
tt = -(-N/2:N/2-1)*pi/N;

rectWindow = rectwin(N_w);
bartlettWindow = bartlett(N_w);
hanningWindow = hann(N_w);
blackmanWindow = blackman(N_w);

fftRect = 20*log10(abs(fftshift(fft(rectWindow, N))));
fftBartlett = 20*log10(abs(fftshift(fft(bartlettWindow, N))));
fftHanning = 20*log10(abs(fftshift(fft(hanningWindow, N))));
fftBlackman = 20*log10(abs(fftshift(fft(blackmanWindow, N))));

% increase N_w for c)
N_w2 = 256
rectWindow2 = rectwin(N_w2);
bartlettWindow2 = bartlett(N_w2);
hanningWindow2 = hann(N_w2);
blackmanWindow2 = blackman(N_w2);

fftRect2 = 20*log10(abs(fftshift(fft(rectWindow2, N))));
fftBartlett2 = 20*log10(abs(fftshift(fft(bartlettWindow2, N))));
fftHanning2 = 20*log10(abs(fftshift(fft(hanningWindow2, N))));
fftBlackman2 = 20*log10(abs(fftshift(fft(blackmanWindow2, N))));

% create sin with 200 Hz and a duration of 0.5 seconds
xSin = sin(2 * pi * f * fvec);
N_sin = length(xSin);
sinRect = rectwin(N_sin);
sinBartlett = bartlett(N_sin);
sinHanning = hann(N_sin);
sinBlackman = blackman(N_sin);

% weighted signals
xSin_rectWindow = xSin .* sinRect';
xSin_bartlettWindow = xSin .* sinBartlett';
xSin_hanningWindow = xSin .* sinHanning';
xSin_blackmanWindow = xSin .* sinBlackman';

% value of weighted signals
fftRectWeighted = 20*log10(abs(fftshift(fft(xSin_rectWindow, N))));
fftBartlettWeighted = 20*log10(abs(fftshift(fft(xSin_bartlettWindow, N))));
fftHanningWeighted = 20*log10(abs(fftshift(fft(xSin_hanningWindow, N))));
fftBlackmanWeighted = 20*log10(abs(fftshift(fft(xSin_blackmanWindow, N))));

% more sinus signals
x1Sin = sin(2 * pi * 48 * fvec) + sin(2 * pi * 52 * fvec);
x2Sin = sin(2 * pi * 50 * fvec) + 0.1*sin(2 * pi * 60 * fvec); 

x1Sin_rectWindow = x1Sin .* sinRect';
x1Sin_bartlettWindow = x1Sin .* sinBartlett';
x1Sin_hanningWindow = x1Sin .* sinHanning';
x1Sin_blackmanWindow = x1Sin .* sinBlackman';

x2Sin_rectWindow = x2Sin .* sinRect';
x2Sin_bartlettWindow = x2Sin .* sinBartlett';
x2Sin_hanningWindow = x2Sin .* sinHanning';
x2Sin_blackmanWindow = x2Sin .* sinBlackman';

fftRectWeighted2 = 20*log10(abs(fftshift(fft(x1Sin_rectWindow, N))));
fftBartlettWeighted2 = 20*log10(abs(fftshift(fft(x1Sin_bartlettWindow, N))));
fftHanningWeighted2 = 20*log10(abs(fftshift(fft(x1Sin_hanningWindow, N))));
fftBlackmanWeighted2 = 20*log10(abs(fftshift(fft(x1Sin_blackmanWindow, N))));

fftRectWeighted3 = 20*log10(abs(fftshift(fft(x2Sin_rectWindow, N))));
fftBartlettWeighted3 = 20*log10(abs(fftshift(fft(x2Sin_bartlettWindow, N))));
fftHanningWeighted3 = 20*log10(abs(fftshift(fft(x2Sin_hanningWindow, N))));
fftBlackmanWeighted3 = 20*log10(abs(fftshift(fft(x2Sin_blackmanWindow, N))));

% Visualization
% a)
figure('name', 'Assignment 3 a) b)');
subplot(521); hold on; grid on;
plot(rectWindow);
title('Rectangular');
xlabel('Samples');
ylabel('Amplitude');

subplot(523); hold on; grid on;
plot(bartlettWindow);
title('Bartlett');
xlabel('Samples');
ylabel('Amplitude');

subplot(525); hold on; grid on;
plot(hanningWindow);
title('Hann');
xlabel('Samples');
ylabel('Amplitude');

subplot(527); hold on; grid on;
plot(blackmanWindow);
title('Blackman');
xlabel('Samples');
ylabel('Amplitude');

% b)

subplot(522); hold on; grid on;
plot(tt,fftRect);
title('Rectangular');
xlabel('\Omega');
ylabel('Magnitude in dB');

subplot(524); hold on; grid on;
plot(tt,fftBartlett);
title('Bartlett');
xlabel('\Omega');
ylabel('Magnitude in dB');

subplot(526); hold on; grid on;
plot(tt,fftHanning);
title('Hann');
xlabel('\Omega');
ylabel('Magnitude in dB');

subplot(528); hold on; grid on;
plot(tt,fftBlackman);
title('Blackman');
xlabel('\Omega');
ylabel('Magnitude in dB');

% d) and e)
% weighted signals
figure('name', 'Assignment 3 d) and e)');
subplot(311); hold on; grid on;
plot(fvec, xSin);
xlim([0,0.5]);
xlabel('t in s');
ylabel('sin(t)');
title('Sinus f = 50Hz and fs = 200 Hz');

subplot(312); hold on; grid on;
plot(xSin_bartlettWindow, 'color', 'k');

subplot(312); hold on; grid on;
plot(xSin_hanningWindow, 'color', 'r');

subplot(312); hold on; grid on;
plot(xSin_blackmanWindow, 'color', 'g');

subplot(312); hold on; grid on;
plot(xSin_blackmanWindow, 'color', 'b');
legend('Weighted Rectangular', 'Weighted Bartlett', 'Weighted Hanning', 'Weighted Blackman');
xlabel('Samples');
ylabel('Amplitude');
title('Weighted windows with sinus');

subplot(313); hold on; grid on;
plot(tt,fftRectWeighted, 'color', 'k');

subplot(313); hold on; grid on;
plot(tt,fftBartlettWeighted, 'color', 'r');

subplot(313); hold on; grid on;
plot(tt,fftHanningWeighted, 'color', 'g');

subplot(313); hold on; grid on;
plot(tt,fftBlackmanWeighted, 'color', 'b');
legend('Weighted Rectangular', 'Weighted Bartlett', 'Weighted Hanning', 'Weighted Blackman');
xlabel('\Omega');
ylabel('Magnitude in dB');
title('Value of weighted windows');

% f)
% weighted signals
figure('name', 'Assignment 3 f) i)');
subplot(211); hold on; grid on;
plot(x1Sin_bartlettWindow, 'color', 'k');

subplot(211); hold on; grid on;
plot(x1Sin_hanningWindow, 'color', 'r');

subplot(211); hold on; grid on;
plot(x1Sin_blackmanWindow, 'color', 'g');

subplot(211); hold on; grid on;
plot(x1Sin_blackmanWindow, 'color', 'b');
legend('Weighted Rectangular', 'Weighted Bartlett', 'Weighted Hanning', 'Weighted Blackman');
xlabel('Samples');
ylabel('Amplitude');
title('Weighted windows with sinus');

subplot(212); hold on; grid on;
plot(tt,fftRectWeighted2, 'color', 'k');

subplot(212); hold on; grid on;
plot(tt,fftBartlettWeighted2, 'color', 'r');

subplot(212); hold on; grid on;
plot(tt,fftHanningWeighted2, 'color', 'g');

subplot(212); hold on; grid on;
plot(tt,fftBlackmanWeighted2, 'color', 'b');
legend('Weighted Rectangular', 'Weighted Bartlett', 'Weighted Hanning', 'Weighted Blackman');
xlabel('\Omega');
ylabel('Magnitude in dB');
title('Value of weighted windows');

figure('name', 'Assignment 3 f) ii)');
subplot(211); hold on; grid on;
plot(x2Sin_bartlettWindow, 'color', 'k');

subplot(211); hold on; grid on;
plot(x2Sin_hanningWindow, 'color', 'r');

subplot(211); hold on; grid on;
plot(x2Sin_blackmanWindow, 'color', 'g');

subplot(211); hold on; grid on;
plot(x2Sin_blackmanWindow, 'color', 'b');
legend('Weighted Rectangular', 'Weighted Bartlett', 'Weighted Hanning', 'Weighted Blackman');
xlabel('Samples');
ylabel('Amplitude');
title('Weighted windows with sinus');

subplot(212); hold on; grid on;
plot(tt,fftRectWeighted3, 'color', 'k');

subplot(212); hold on; grid on;
plot(tt,fftBartlettWeighted3, 'color', 'r');

subplot(212); hold on; grid on;
plot(tt,fftHanningWeighted3, 'color', 'g');

subplot(212); hold on; grid on;
plot(tt,fftBlackmanWeighted3, 'color', 'b');
legend('Weighted Rectangular', 'Weighted Bartlett', 'Weighted Hanning', 'Weighted Blackman');
xlabel('\Omega');
ylabel('Magnitude in dB');
title('Value of weighted windows');

% c)
figure('name', 'Assignment 3 c)');
subplot(411); hold on; grid on;
plot(tt,fftRect2);
title('Rectangular');
xlabel('\Omega');
ylabel('Magnitude in dB');

subplot(412); hold on; grid on;
plot(tt,fftBartlett2);
title('Bartlett');
xlabel('\Omega');
ylabel('Magnitude in dB');

subplot(413); hold on; grid on;
plot(tt,fftHanning2);
title('Hann');
xlabel('\Omega');
ylabel('Magnitude in dB');

subplot(414); hold on; grid on;
plot(tt,fftBlackman2);
title('Blackman');
xlabel('\Omega');
ylabel('Magnitude in dB');