clc; 
close all;
clear all;

%coef. ajustados esperim. por Slootweg(velocidade variavel)  
%_____(Livro-WindPowerinPowerSystems/Thomas Ackermann -pag.562 563)   (TESE-Maurício Barbosa- pag. 29)
c1=0.73;
c2=151;
c3=0.58;
c4=0.002;
c5=2.14;
c6=13.2;
c7=18.4;
c8=-0.02;
c9=-0.003;

%% gráfico de Cp por lambda
ang_hel=[0 5 10 15 20]; %ângulo de passo das hélices (grau)
lamb=[1:0.0001:15]; %relação linear de velocidade 

for g=1:5
lamb_i=1./((1./(lamb+c8.*ang_hel(g)))-(c9/((ang_hel(g)^3) + 1)));
Cp(g,:)=c1*((c2./lamb_i)-c3*ang_hel(g)-c4*(ang_hel(g)^c5)-c6).*exp(-c7./lamb_i); %coef de potência
end
 figure; 
 plot(lamb,Cp(1,:),'b--',lamb,Cp(2,:),'m-',lamb,Cp(3,:),'c:',lamb,Cp(4,:),'r-.',lamb,Cp(5,:),'g-','LineWidth',2); grid on;
 xlabel('relação de velocidades (\lambda)')
 ylabel('Cp')
 legend('\beta = 0º','\beta = 5º','\beta = 10º','\beta = 15º','\beta = 20º'  )
 title('Curvas Cp')
 axis([0 15 0 0.5])

%% plotando torque por rpm 
%_____(Livro-WindPowerinPowerSystems/Thomas Ackermann -pag.527)   (TESE-Maurício Barbosa- pag. 28)
ang_hel=2; %ângulo de passo das hélices (grau)
V=[6:11]; %velocidade do vento m/s
r_rotor=28; %raio do rotor
vel_rotor_rpm=[1:0.001:50];
vel_rotor_rads=vel_rotor_rpm*2*pi/60;
A=pi*r_rotor^2;%área varida pelas helices m^2
rho=1.225;%densidade do ar kg/m^3

for g=1:length(V)
lamb=vel_rotor_rads*r_rotor/V(g); %relação linear de velocidade 
lamb_i=1./((1./(lamb+c8.*ang_hel))-(c9/((ang_hel^3) + 1)));
Cp=c1*((c2./lamb_i)-c3*ang_hel-c4*(ang_hel^c5)-c6).*exp(-c7./lamb_i); %coef de potência
Cp1(g,:)=Cp;
Pm(g,:)=0.5*A*rho*(V(g).^3).*Cp;%potência mecênica W
Tm(g,:)=0.5*A*rho*(V(g).^2).*Cp; %conjugado mecênico Nm
end
 figure; 
 plot(vel_rotor_rpm,Tm(1,:),'b--',vel_rotor_rpm,Tm(2,:),'m-.',vel_rotor_rpm,Tm(3,:),'c:',vel_rotor_rpm,Tm(4,:),'r-.',vel_rotor_rpm,Tm(5,:),'g-',vel_rotor_rpm,Tm(6,:),'k--','LineWidth',2); grid on;
 xlabel('rpm')
 ylabel('Conjunjugado mecânico (Nm)')
 legend('Velocidade do vento = 6 m/s','Velocidade do vento = 7 m/s','Velocidade do vento = 8 m/s','Velocidade do vento = 9 m/s','Velocidade do vento = 10 m/s','Velocidade do vento = 11 m/s'  )
 axis([0 50 0 130000])

 figure; 
 plot(vel_rotor_rpm,Pm(1,:),'b--',vel_rotor_rpm,Pm(2,:),'m-.',vel_rotor_rpm,Pm(3,:),'c:',vel_rotor_rpm,Pm(4,:),'r-.',vel_rotor_rpm,Pm(5,:),'g-',vel_rotor_rpm,Pm(6,:),'k--','LineWidth',2); grid on;
 xlabel('rpm')
 ylabel('Potência mecânica (W)')
 legend('Velocidade do vento = 6 m/s','Velocidade do vento = 7 m/s','Velocidade do vento = 8 m/s','Velocidade do vento = 9 m/s','Velocidade do vento = 10 m/s','Velocidade do vento = 11 m/s'  )
 axis([0 50 0 1400000])

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
