clear
close all
clc 

function x = fourier_series(a,b,f0,t)
  x = zeros(length(t));
  x(1) = a(1)/2;
  
  for i=1:length(t)
    for k=2:length(a)
       x(i) += a(k+1)*cos(2*pi*f0*t(i)) + b(k)*sin(2*pi*k*f0*t(i));
%       x(i) = x(i) + a(k) * cos(2*pi*k*f0*t(i)) + b(k-1) * sin(2*pi*k*f0*t(i));
    endfor    
  endfor
end

N = 10
 
a = zeros(N+1);
b = zeros(N);

for k = 1:N
  b(k) = (-1)^(k-1)/k;
endfor

f0 = 10;
fs = f0*1000;
t = -0.05:1/fs:0.05;
y = zeros(length(t));

y = (-(2/pi)) * fourier_series(a,b,f0,t);

plot(y);