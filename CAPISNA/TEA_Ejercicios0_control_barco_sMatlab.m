% barco_master_mj1.m
% 
% Escuela Superior de Ingenier�a. Universidad de C�diz
% �rea de Ingenier�a de Sistemas y Autom�tica. Grupo GAPSIS
% Profesor: Manuel J. L�pez
% 
% Ejemplo de sistema de control de veh�culo marino de superficie, 
% empleado en clases de Ingenier�a de Control
% 
% El modelo matem�tico de cada uno de los elementos que forman parte 
% del sistema a controlar se ha dado en las sesiones de clase previas, 
% por lo que se debe consultar para contestar a las cuestiones planteadas. 
% 
% Consiste en sistema de control de veh�culo marino de superficie, 
% en el que las variables a controlar son:
%
% 1.	Velocidad angular de giro del veh�culo (r = dpsi/dt). 
% Inicialmente se trata de dise�ar un controlador base tipo PI. 
% Adem�s, es necesario incluir la acci�n derivativa (D), obtieniendo 
% as� un PID, y comparar resultados. 
%
% 2.	�ngulo de rumbo (psi). Inicialmente se trata de dise�ar 
% un controlador base tipo PD. Adem�s, para conseguir reducir 
% el efecto de perturbaciones constantes es necesario dise�ar 
% un controlador que tenga la acci�n integral.
%
% 3.	Distancia a una trayectoria o camino recto (y). Incialmente se 
% trata de dise�ar un controlador PDD2. Adem�s, para conseguir reducir 
% el efecto de perturbaciones constantes es necesario dise�ar un 
% controlador que tenga la acci�n integral. 
% 3a.	El dise�o del controlador se puede hacer utilizando como modelo 
% de la planta 
% Gp(s) = K V (pi/180) / [(tau s +1) s2]    (metros/grados)
% 3.b.	Como m�todo alternativo, el controlador de distancia a la 
% trayectoria o camino recto tambi�n se puede realizar empleando 
% el modelo matem�tico del sistema de control de rumbo (en lazo cerrado, 
% con el controlador dise�ado previamente en el punto 2) como sistema 
% a controlar, llevando a la pr�ctica de esta forma un sistema 
% de control en cascada. 
% 
clear all, close all
s = tf('s');
V = 15*1852/3600; % pasa Nudos a m/s
tau = 26;   
K = 0.12; 
tau_delta = 0.8;
Kact = 35/10;
beta = 2;
tau_fd = 0.05;
Km1 = 10/20;
Km2 = 10/180;
Km3 = 10/200;
Gact = Kact/(tau_delta*s+1);
% Especificaciones de dise�o
xi = 1;   % Mp = 0 (sin overshoot)
te = input('Tiempo de respuesta (seg) para lazo cerrado (ej.: 125 y 60 segundos para comparar resultados)  = '); 
if length(te) < 1
    te = 125;
end    
         % inicialmente se pone a 125 seg
         % pero para que sea m�s r�pida la respuesta y visualizar mejor
         % la din�mica no lineal de la planta, se baja a 60 seg
         
wn = 5.85/te;         
% Para controlador de velocidad angular: PI
Gm1 = Km1;
Gp1 = K/(tau*s+1);
K1 = K*Kact*Km1; 
Ki_r = tau*wn^2/K1;
Kp_r =(2*xi*wn*tau-1)/K1;
Kd_r = 0;
Gc1 = Kp_r+Ki_r/s;
G1 = Gp1*Gact*Gm1; 
GLC1 = Gc1*G1/(1+Gc1*G1);
figure(1)
step(GLC1),grid, title('Velocidad angular (grados/segundo)')
% Para controlador de rumbo: PD
Gp2 = K/(s*(tau*s+1));
Gm2 = Km2;
K2 = K*Kact*Km2;
Kp_psi = tau*wn^2/K2;
Ki_psi = 0;
Kd_psi = (2*xi*wn*tau-1)/K2;
Gc2 = Kp_psi+Kd_psi*s;
G2 = Gp2*Gact*Gm2; 
GLC2 = Gc2*G2/(1+Gc2*G2);
figure(2)
step(GLC2*5),grid, title('Rumbo (grados)')
% Para controlador de distancia y
Gp3 = (K*V*pi/180)/(s^2*(tau*s+1));
Gm3 = Km3;
K3 = K*(pi/180)*V*Kact*Km3;
alfa_y = 5;
Kp_y = alfa_y*wn^3*tau/K3;
Ki_y = 0;
Kd_y = (2*xi*alfa_y+1)*tau*wn^2/K3;
Kd2_y = ((alfa_y+2*xi)*wn*tau-1)/K3;
Gc3 = Kp_y+Kd_y*s+Kd2_y*s^2;
G3 = Gp3*Gact*Gm3; 
GLC3 = Gc3*G3/(1+Gc3*G3);
figure(3)
step(GLC3),grid, title('Distancia (metros)')

