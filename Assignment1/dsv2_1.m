clear
close all
clc 

%Always begin your matlab scripts with the commoands above

function x = fourier_series(a,b,f0,t)
  x = zeros(length(t),1);
  
  for i=1:length(t)
    x(i,1) = a(1)/2;
    for k=1:length(b)
       x(i,1) += a(k+1)*cos(2*pi*f0*t(i)) + b(k)*sin(2*pi*k*f0*t(i));
    endfor    
  endfor
end

f0 = 10;
fs = f0*1000;0
% -0.05 - 0.05 -> 1. cycle -> 0.05 - 0.15 -> 2. cycle
t = -0.05:1/fs:0.15;

%10

N = 10;

a = zeros(1,N+1);
b = zeros(1,N);

for k = 1:N
  b(1,k) = (-1)^(k-1)/k;
endfor

y = (-(2/pi)) * fourier_series(a,b,f0,t);

% 100
N = 100;
 
a = zeros(1,N+1);
b = zeros(1,N);

for k = 1:N
  b(1,k) = (-1)^(k-1)/k;
endfor

y2 = (-(2/pi)) * fourier_series(a,b,f0,t);

% 10000
N = 10000;
 
a = zeros(1,N+1);
b = zeros(1,N);

for k = 1:N
  b(1,k) = (-1)^(k-1)/k;
endfor

y3 = (-(2/pi)) * fourier_series(a,b,f0,t);


figure
plot(t, y, 'r');
hold on
plot(t, y2, 'y');
hold on
plot(t, y3, 'b');
hold on

legend('N10', 'N100', 'N10000') 