clear
close all
clc 

pkg load signal;

a = [1, -1.2676, 0.9, -0.2248];
b = [0.0691, 0.1346, 0.0691, 0.1346];


% i)
zreal = [-1.5:0.05:1.5];
zimag = [-2:0.05:2];

zinv = ( repmat(zreal, size(zimag')) + 1i*repmat(zimag',size(zreal)) ).^(-1);

yi = b(1) + b(2)*zinv + b(3)*zinv.^2 + b(4)*zinv.^3;
xi = a(1) + a(2)*zinv + a(3)*zinv.^2 + a(4)*zinv.^3;

hi = yi ./ xi;



w = linspace(-pi, pi, 100);
zv = exp(-i * w);
zvinv = zv.^(-1);

yzv = b(1) + b(2)*zvinv + b(3)*zvinv.^2 + b(4)*zvinv.^3;
xzv = a(1) + a(2)*zvinv + a(3)*zvinv.^2 + a(4)*zvinv.^3;

hzv = yzv ./ xzv;
figure; hold on; grid on;
plot3(real(zv), imag(zv), 20*log10(abs(hzv)), 'r', 'LineWidth', 2);
mesh(zreal, zimag, 20*log10(abs(hi)), 'FaceColor', 'flat');
xlabel('real(Z)');
ylabel('imag(Z)')
zlabel('20*log10(abs(H))');