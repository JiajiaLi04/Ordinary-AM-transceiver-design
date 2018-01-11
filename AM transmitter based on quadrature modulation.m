clc;
close all;
fs1=160e3;
n=1:500;
ts1=n/fs1;
f01=1e3;
f02=3e3;
fn=sin(2*pi*f01.*ts1)+sin(2*pi*f02.*ts1);
figure;
plot(fn);
title('Modulated signal f(n)');
xlabel('n','FontSize',16);
ylabel('f(n)','FontSize',16);

fs2=3.2e6;
n=1:500;
ts2=n/fs2;
fc=910026;
cn=cos(2*pi*fc.*ts2);
figure;
plot(cn);
title('Carrier wave c(n)');
xlabel('n','FontSize',16);
ylabel('c(n)','FontSize',16);


n=1:500;
benzhen=1.86e5;

t1=n/benzhen;
x1=sin(2000*pi*t1)+sin(6000*pi*t1); %The original baseband, in order to ensure the same dimension.
x2=((1+x1*0.3).*cos(2*pi*t1));%Am modulation. This is also the In signal, Qn signal is 0.
figure;
plot(x2);
title(' after AM modulation');
In=interp(x2,20); %Call the function for interpolation

figure;
plot(In);
title('after interpolation');

fs=3200000;
n1=0:32000;
t2=n1/fs;
co=cos(2*pi*fc.*t2);
x4=((1+(sin(2000*pi*t2)+sin(6000*pi*t2))*0.3).*cos(2*910026*pi*t2))+((1+(sin(2000*pi*t2)+sin(6000*pi*t2))*0.3).*cos(2*910026*2*pi*t2));%经过混频器后产生的信号产生了其他的频率分量
w3=2*800000/fs;
w4=2*1000000/fs;
wn=[w3,w4];
[b,a]=butter(18,wn); 
x5=filter(b,a,x4);%The final waveform of the signal after bandpass filter
figure;
plot(x5);
title('am waveform');

N=length(x5);
window=boxcar(N)';
nfft=8192;
[P,fx]=periodogram(x5,window,nfft,fs);
figure;
plot(fx,P);
title('spectrum of AM signal ');
xlabel('Hz');
axis([8e5 10e5 2e-4 0]);






