clear
close all
clc 

pkg load signal

fs = 200;
f = 50;
dur = 0.5;
tt = 0:1/fs:dur-1/fs;
# create sin with 200 Hz and a duration of 0.5 seconds
xSin = sin(2 * pi * f * tt);

N_w = 64;
N_dft = length(xSin);
fftLength = 2048;

rectWindow = rectwin(N_w);
bartlettWindow = bartlett(N_w);
hanningWindow = hann(N_w);
blackmanWindow = blackman(N_w);

fftRect = fft(rectWindow, fftLength);
fftBartlett = fft(bartlettWindow, fftLength);
fftHanning = fft(hanningWindow, fftLength);
fftBlackman = fft(blackmanWindow, fftLength);


% transpose sin
%xSin = xSin';

% weighted signals
xSin_rectWindow = xSin .* rectWindow;
xSin_bartlettWindow = xSin .* bartlettWindow;
xSin_hanningWindow = xSin .* hanningWindow;
xSin_blackmanWindow = xSin .* blackmanWindow;


% Visualization
figure;
subplot(341); hold on; grid on;
plot(rectWindow);
legend('Rectangular');
%xlabel('n');
%ylabel('x_1[n], x_2[n]');

subplot(342); hold on; grid on;
plot(bartlettWindow);
legend('Bartlett');

subplot(343); hold on; grid on;
plot(hanningWindow);
legend('Hann');

subplot(344); hold on; grid on;
plot(blackmanWindow);
legend('Blackman');

subplot(345); hold on; grid on;
plot(fftRect);
legend('FFT Rectangular');

subplot(346); hold on; grid on;
plot(fftBartlett);
legend('FFT Bartlett');

subplot(347); hold on; grid on;
plot(fftHanning);
legend('FFT Hann');

subplot(348); hold on; grid on;
plot(fftBlackman);
legend('FFT Blackman');

% weighted signals
subplot(349); hold on; grid on;
plot(fft(xSin_rectWindow));
axis([30,70]);

subplot(349); hold on; grid on;
plot(fft(xSin_bartlettWindow));

subplot(349); hold on; grid on;
plot(fft(xSin_hanningWindow));

subplot(349); hold on; grid on;
plot(fft(xSin_blackmanWindow));
legend('Weighted Rectangular', 'Weighted Bartlett', 'Weighted Hanning', 'Weighted Blackman');