clear
close all
clc 

% signaldarstellung

n12 = -5:10;            % Discrete time vector
x1 = -3*impseq(-2,-5,10)+2*impseq(+1,-5,10)-impseq(+4,-5,10)+4*impseq(+7,-5,10);
x2 = exp(-0.3*n12);

n34 = 0:256;
x3 = 2*sin(2*pi*n34/64);
x4 = cos(9*n34/64);

n5 = -5:20;
x5 = 5*stepseq(0,-5,20)-6*stepseq(5,-5,20)-3*stepseq(10,-5,20)+5*stepseq(15,-5,20)

function rectImpuls = rect (n, x)
  rectImpuls = (abs(n) <= x);
end
n6 = -15:15;
x6 = rect(n6 - 12*-1, 3) + rect(n6 - 12*0, 3) + rect(n6 - 12*1, 3);

function period = per(signal, b)
   period = 2*pi/b;
end

periodX3 = per(x3,2*pi/64);
periodX4 = per(x4,9/64);

% leistung

function retLeistung = leistung(period)
  retLeistung = 0;
  for n = 1:length(period)-1
    retLeistung += abs(period(n))^2;
  endfor
  retLeistung /= length(period);
end

p1 = leistung(x1);
p2 = leistung(x2);
p3 = leistung(x3);
p4 = leistung(x4);
p5 = leistung(x5);
p6 = leistung(x6);

pMittelwert = (p1+p2+p3+p4+p5+p6)/6

% energie

function retEnergie = energie(signal)
  retEnergie = 0;
  for n = 1:length(signal)
    retEnergie += abs(signal(n))^2;
  endfor
end

e1 = energie(x1);
e2 = energie(x2);
e3 = energie(x3);
e4 = energie(x4);
e5 = energie(x5);
e6 = energie(x6);
e7 = energie(randn(10,1));

% Visualization
figure;
subplot(221); hold on; grid on;
stem(n12,x1);
xlabel('n');
ylabel('x_1[n], x_2[n]');

subplot(221); hold on; grid on;
stem(n12, x2);
legend('x_1[n]','x_2[n]');

subplot(222); hold on; grid on;
plot(n34,x3);
xlabel('n');
ylabel('x_3[n] x_4[n]');

subplot(222); hold on; grid on;
plot(n34,x4);
legend('x_3[n]','x_4[n]');

subplot(223)
stem(n5,x5);
xlabel('n');
ylabel('x_5[n]');

subplot(224);
stem(n6,x6);
xlabel('n');
ylabel('x_6[n]');