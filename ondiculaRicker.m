close all;
clear all;
clc;

%Frecuencia de 30hz
fr=30;
dt=0.002
%Intervalo en milisegundos
t=[-0.04:dt:0.04];

%Se llama a la funcion de ondicula de ricker
ricker=(1-2*(pi()^2)*(fr^2).*(t.^2)).*exp(-(pi()^2)*(fr^2).*(t.^2));

%Grafica 1 "Ondicula"
figure(1)
plot(t*1000,ricker,t*1000,ricker,'o')
xlabel('Tiempo [ms]')
ylabel('Amplitud')

%secuencia reflectiva

tcoefs=1:1500;
tcoefs2ms=tcoefs*2;
coef=zeros(1,1500);
coef(350)=1.0;
coef(600)=-1.0;
coef(950)=-1.5;
coef(1150)=1.0;
coef(1350)=2.0;

%"Secuencia reflectiva"
figure(2)
plot(tcoefs2ms,coef,tcoefs2ms,coef,'o')
xlabel ('Tiempo[ms]')
ylabel('Coeficientes de reflexion')

%Traza sintetica por medio de la convolucion

Traza_Conv=conv(ricker,coef)
t1=2:2:3080;
figure(3)
plot(t1,Traza_Conv)
xlabel('Tiempo[ms]')
ylabel('Amplitud')

%Espectro Traza sismica sintetica
TF_Traza_Conv=fft(Traza_Conv,1540);
n1= 0:1539;
ftraza_conv=n1/(1540*dt);

%Grafica Espectro de Amplitud Traza sismica sintetica
figure(4)
plot(ftraza_conv,abs(TF_Traza_Conv))
xlabel('Frecuencia[Hz]')
ylabel('Amplitud')

%Grafica Espectro de Amplitud Traza sismica sintetica (dB)
figure(5)
plot(ftraza_conv,20*log10(abs(TF_Traza_Conv))) 
xlabel('Frecuencia[Hz]')
ylabel('dB')

%Espectro de Amplitud de la secuencia reflectiva
TF_coefs=fft(coef,2048);
n2=0:2047;
fcoef=n2/(2048*dt);

figure(6)
plot(fcoef,abs(TF_coefs))
xlabel('Frecuencia[Hz]')
ylabel('Amplitud')

figure(7)
plot(fcoef,20*log10(abs(TF_coefs))) 
xlabel('Frecuencia[Hz]')
ylabel('dB')

%Espectro de amplitud Ricker
k=0:63;
n=64;
f_ricker=(k/(n*dt));
TF_ricker=fft(ricker,2^6);

%Grafica Espectro de amplitud de ondicula Ricker
figure(8)
plot(f_ricker,abs(TF_ricker),f_ricker,abs(TF_ricker),'o')
xlabel('Frecuencia[Hz]')
ylabel('Amplitud')

%Espectro de amplitud de ondicula Ricker(dB)
figure(9)
plot(f_ricker,20*log10(abs(TF_ricker)))
xlabel('Frecuencia[Hz]')
ylabel('dB')














