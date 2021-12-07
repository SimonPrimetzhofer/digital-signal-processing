clear
close all
clc 

windowLength = 64;
fftLength = 2048;

rectWindow = rectwin(windowLength);
bartlettWindow = bartlett(windowLength);
hanningWindow = hanning(windowLength);
blackmanWindow = blackman(windowLength);

# create sin with 200 Hz and a duration of 0.5 seconds
duration=0:0.000001:0.5;
xSin = sin(200 * 2 * pi * duration);
plot(duration,xSin);
% transponate sin
%xSin = xSin';

% weighted signals
xSin_rectWindow = xSin.*rectWindow;
xSin_bartlettWindow = xSin.*bartlettWindow;
xSin_hanningWindow = xSin.*hanningWindow;
xSin_blackmanWindow = xSin.*blackmanWindow;


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
plot(fft(rectWindow, fftLength));
legend('FFT Rectangular');

subplot(346); hold on; grid on;
plot(fft(bartlettWindow, fftLength));
legend('FFT Bartlett');

subplot(347); hold on; grid on;
plot(fft(hanningWindow, fftLength));
legend('FFT Hann');

subplot(348); hold on; grid on;
plot(fft(blackmanWindow, fftLength));
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