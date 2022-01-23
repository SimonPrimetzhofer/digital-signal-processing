% JKU, Digitale Signalverarbeitung UE, WS 2021/22
%#########################################################################
% Assignment 5, Aufgabe 1 : FIR Tiefpassentwürfe
%#########################################################################

%=========================================================================
% FIR - filter design using the windowing method
%       rectangular window with N=20
%=========================================================================
clear all;
close all

fs = 20e3;                          % sampling frequency

%--- tolerance scheme
f_pass = 3.4e3;                     % passband cutoff frequency
f_stop = 4e3;                       % stopband cutoff frequency
Omega_pass = 20*log10(abs(2*pi*f_pass/fs));  	                % passband cutoff radian frequency
Omega_stop = 20*log10(abs(2*pi*f_stop/fs));   	            % stopband cutoff radian frequency

Delta_1 = 0.05;  			        % passband tolerance
Delta_2 = 10^(-45/20); 			            % stopband tolerance (20 log(Delta_2) = -45 dB

%--- filter parameters
N = 20;        				        % filter order
Omega_0 = (Omega_pass + Omega_stop) / 2 	                    % corner radian frequency

%--- ideal impulse response (causal, order N)
nv = -N/2:N/2;
h_ideal = (Omega_0 / pi) .* sinc((nv * Omega_0) / pi);                      % Beachten Sie, dass Matlab den normierten sinc implementiert,
                                    % in den Vorlesungsunterlagen aber der nicht-normierte sinc verwendet wird.
                                    % Siehe Foliensatz 2, Seite 8
                                    % Es gilt : sinc_vorlesung(x)=sinc_matlab(x/pi)

%--- apply window on h_ideal (e.g., rectangular or hamming,...) 
w    = ones(1,numel(h_ideal));      % rectangular window
h_rw = h_ideal.*w;                    % apply window : h_rw (h_rectangular-window)
                                    % In diesem Fall, wo h_ideal schon die richtige Länge hat kann die
                                    % Multiplikation mit dem Rechteckfenster natürlich auch entfallen.
                                    
%--- frequency response
M = 1024;                           % number of frequency samples
[H_rw,Omega] = freqz(h_rw,M,fs);

%--- Graphics
%    - tolerance scheme for display
TSu_w=[0,Omega_stop,Omega_stop,pi];              % upper tolerance border
TSu_m=[(1+Delta_1),(1+Delta_1),Delta_2,Delta_2]; 
TSl_w=[0,Omega_pass,Omega_pass,pi];              % lower tolerance border
TSl_m=[(1-Delta_1),(1-Delta_1),0      ,0      ]; 

%    - plot
fig1=figure(11); clf;
set(fig1, 'Position', [20 20+600 600 600])
subplot(3,1,1)
nv_shift = 0:N;
plot(nv_shift,h_rw); grid on; % impulse response
xlabel('n'), ylabel('h[n]')
axis([0 N -.2 .5]);
%-
subplot(3,1,2)
plot(Omega/pi,abs(H_rw)); hold on;
plot(TSu_w/pi,TSu_m,'r'  , TSl_w/pi,TSl_m,'r')
axis([0 1 0 1.2]); grid on
xlabel('\Omega / \pi')
ylabel('|H(\Omega)|')
%-
subplot(3,1,3);
plot(Omega/pi,20*log10(abs(H_rw))); hold on;
plot(TSu_w/pi,20*log10(TSu_m),'r',TSl_w/pi,20*log10(TSl_m+1e-12),'r')
axis([0 1 -60 5]); grid
xlabel('\Omega / \pi')
ylabel('20*log|H(\Omega)| (dB)')


%pause
%=========================================================================
% FIR - filter design using the windowing method
%       repeat filter design for:
%       rectangular window and order N=109
%=========================================================================
N =109;

%--- impulse response (causal, order N)
nv      = -N/2:N/2;
h_ideal = (Omega_0 / pi) .* sinc((nv * Omega_0) / pi);

w    = ones(1,numel(h_ideal));      % rectangular window
h_rw = h_ideal.*w;                    % apply window , h_rw (h_rectangular-window)
                                    % Wie zuvor kann dieser Schritt hier eigentlich entfallen

%--- frequency response
[H_rw,Omega] = freqz(h_rw,M,fs);         

%--- plot
fig2=figure(12); clf;
set(fig2, 'Position', [20 20+600 600 600])
subplot(3,1,1)
nv_shift = 0:N;
plot(nv_shift,h_rw,'b.-'), grid on % impulse response
xlabel('n'), ylabel('h_rw[n]')
axis([0 N -.2 .5]);
%-
subplot(3,1,2);
plot(Omega/pi,abs(H_rw)); hold on
plot(TSu_w/pi,TSu_m,'r'  , TSl_w/pi,TSl_m,'r')
axis([0 1 0 1.2]); grid
xlabel('\Omega / \pi')
ylabel('|H_rw(\Omega)|')
%-
subplot(3,1,3);
plot(Omega/pi,20*log10(abs(H_rw))); hold on
plot(TSu_w/pi,20*log10(TSu_m),'r',TSl_w/pi,20*log10(TSl_m+1e-12),'r')
axis([0 1 -60 5]); grid
xlabel('\Omega / \pi')
ylabel('20*log|H_rw(\Omega)| (dB)')

%pause
%=========================================================================
% FIR - filter design using the windowing method
%       repeat filter design for:
%       Hamming window and order N=109
%=========================================================================
w    = hamming(numel(h_ideal)).';       % hamming window
h_hw = h_ideal.*w;                        % apply window , h_hw (h_hamming-window)

%--- frequency response
[H_hw,Omega] = freqz(h_rw,M,fs);

%--- plot
fig3=figure(13); clf;
set(fig3, 'Position', [20 20+600 600 600])
subplot(3,1,1)
nv_shift = 0:N;
plot(nv_shift,h_hw,'b.-'), grid on % impulse response
xlabel('n'), ylabel('h_hw[n]')
axis([0 N -.2 .5]);
%-
subplot(3,1,2);
plot(Omega/pi,abs(H_hw)); hold on;
plot(TSu_w/pi,TSu_m,'r'  , TSl_w/pi,TSl_m,'r')
axis([0 1 0 1.2]); grid
xlabel('\Omega / \pi')
ylabel('|H_rw(\Omega)|')
%-
subplot(3,1,3);
plot(Omega/pi,20*log10(abs(H_hw))); hold on;
plot(TSu_w/pi,20*log10(TSu_m),'r',TSl_w/pi,20*log10(TSl_m+1e-12),'r')
axis([0 1 -60 5]); grid
xlabel('\Omega / \pi')
ylabel('20*log|H_rw(\Omega)| (dB)')

%pause

%=========================================================================
% FIR - filter design using the Equiripple Method
%=========================================================================
%--- Set parameters
F       = [f_pass , f_stop];
A       = [1 , 0];
DEV     = [Delta_1 , Delta_2];

%--- Find Approximate Order of Filter
[n,fo,ao,w] = firpmord(F,A,DEV,fs);

%--- Call Filter Design Tool
h_pm=firpm(n,fo,ao,w);   
                         
N=55                    %Falls sich herausstellt, dass das Toleranzschema mit der in 
%                          %"firpmord" berechneten Filterordnung noch nicht eingehalten wird 
%                          %erhöhen Sie hier die Filterordnung
 h_pm=firpm(N,fo,ao,w);   %...und berechnen Sie die Koeffizienten erneut.

%--- Frequency Response
[H_pm,W]=freqz(h_pm,1,M);

%--- plot
fig6=figure(14); hold off;
set(fig6, 'Position', [20 20+600 600 600])

subplot(3,1,1); hold off;
nv = 0:N;
plot(nv,h_pm,'.-'), grid % impulse response
xlabel('n'), ylabel('h_fs[n]')
axis([0 N -.2 .5]);
%-
subplot(3,1,2); hold off;
plot(W/pi,abs(H_pm)); hold on
plot(TSu_w/pi,TSu_m,'r'  , TSl_w/pi,TSl_m,'r')
axis([0 1 0 1.2]); grid on
xlabel('\Omega / \pi')
ylabel('|H(\Omega)|')
%-
subplot(3,1,3); hold off;
plot(W/pi,20*log10(abs(H_pm))); hold on;
plot(TSu_w/pi,20*log10(TSu_m),'r',TSl_w/pi,20*log10(TSl_m+1e-12),'r')
axis([0 1 -60 5]); grid on;
xlabel('\Omega / \pi')
ylabel('20*log|H(\Omega)| (dB)')

%--- Pole-Zero-Diagram in Z-Plane
figure(15); hold off;
zplane(h_pm);    %see assignment4 for hints how to plot 



