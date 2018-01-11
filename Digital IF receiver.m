fs=1.84e6;%Sampling frequency
dt=1/fs;
StopTime=0.01;
t = (0:dt:StopTime-dt)';
x0=((1+(sin(2000*pi*t)+sin(6000*pi*t))*0.3).*cos(2*910026*pi*t));% ‰»Î–≈∫≈
figure(1);
plot(x0);
title('the signal waveform after AD sampling ');
xlabel('n');

N = size(t,1);
x= fftshift(fft(x0));
dF = fs/N;                      % hertz
f = -fs/2:dF:fs/2-dF;           % hertz

figure(2);
plot(f,abs(x)/N);
xlabel('Frequency(Hz)');
title('the signal spectrum after AD sampling');
%axis([8e5 10e5 0.5 0])

%%after NCO 
%draw waveform
t1=(0:dt:StopTime-dt)';
n=(0:1:18400-1)';
x1=((1+(sin(2000*pi*t1)+sin(6000*pi*t1))*0.3).*cos(2*910026*pi*t1)).*cos(pi*n/2);
figure(3);
plot(x1);
title('the signal waveform after NCO');
xlabel('n');


%%draw signal spectrum
N1 = size(t,1);
x= fftshift(fft(x1));
dF = fs/N1;                      % hertz
f1 = -fs/2:dF:fs/2-dF;           % hertz

figure(4);
plot(f1,abs(x)/N);
xlabel('Frequency (Hz)');
title('signal spectrum after NCO');
%axis([8e5 10e5 0.5 0])

%%dawnsampling 
x2=downsample(x1, 20);
figure(5);
plot(x2);
title('the signal waveform after downsampling');
xlabel('n');

%%draw spectrum
N2 = size(t,1);
x= fftshift(fft(x2));
dF = 20*fs/N1;                      % hertz
f1 = -fs/2:dF:fs/2-dF;           % hertz

figure(6);
plot(f1,abs(x)/N2);
xlabel('Frequency (Hz)');
title('signal spectrum after downsampling');



%%%%% waveform and spectrum after demodulating
fs2=fs./20;
n=1:18400;
t=n/fs;
ft=sin(2000*pi*t)+sin(6000*pi*t);
figure(7)
plot(ft);
title('the ft waveform after demodulating');

N=length(ft);
window=boxcar(N)';
nfft=1024;
[P,fx]=periodogram(ft,window,nfft,fs2);
figure(8);
plot(fx,P);
title('the signal spectrum after AM demodulating');
xlabel('Hz');



