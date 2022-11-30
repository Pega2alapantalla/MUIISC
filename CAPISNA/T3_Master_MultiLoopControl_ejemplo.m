% mimo3x3_master_mj1.m
% 
% Ejemplo de sitemas MIMO 3x3 a los que se aplica:
% - Control mediante el método "Multiloop Control"
% - Control denominado multivariable mediante realimentación del vector
%   de estado: 
%       A. Control Modal (o Asignación de Polos). 
%       B. Control Lineal Óptimo Cuadrático (LQR).
clear all, close all
s = tf('s');
tau1 = 2; tau2 = 2.3; tau3 = 1.8;   % segundos
sistema = menu('Elija sistema a emplear: ',...
    '1. Sistema con menor interacción entre variables entrada salida',...
    '2. Sistema con mayor interacción entre variables entrada-salida');
if sistema == 1
    K11 = 0.97;  K12 = -0.6;  K13 = 0.7;     % V/V
    K21 = 0.5;  K22 = -0.8;  K23 = 0.61;     % V/V
    K31 = 0.25; K32 = -0.3; K33 = 0.55;      % V/V 
else
    K11 = 0.97;  K12 = -0.3;  K13 = 1.1;     % V/V
    K21 = 1;  K22 = -0.8;  K23 = 0.91;       % V/V
    K31 = 0.5; K32 = -0.3; K33 = 0.55;       % V/V    
end 
% Funciones de transferencia que relacionan variables manipuladas
% (entradas) con variables controladas o variables del proceso (salidas)
G11 = K11/(tau1*s+1);  G12 = K12/(tau1*s+1);  G13 = K13/(tau1*s+1);
G21 = K21/(tau2*s+1);  G22 = K22/(tau2*s+1);  G23 = K23/(tau2*s+1);
G31 = K31/(tau3*s+1);  G32 = K32/(tau3*s+1);  G33 = K33/(tau3*s+1);
% Matriz de funciones de transferencia
G = [G11  G12  G13
     G21  G22  G23
     G31  G32  G33]
figure(1) 
step(G), grid   % respuesta a entradas escalón
title('Lazo abierto')
te = 5; 
wn_mod = 5.85/te;
xi_mod = 1;
% Para funciones de transferencia de la forma: G(s) = b/(s+a)
% en relación a las de la forma: G(s) = K/(tau*s+1),
% se tiene que: a = 1/tau,   b = K/tau
% Si se especifica sistema resultante de segundo orden con xi = 1,
% resulta:  te = 5.85/wn,  wn = 5.85/te
% De donde: Ki = wn^2/b,   Kp = (2*xi*wn-a)/b
b11 = K11/tau1; a11 = 1/tau1;
Ki_1 = wn_mod^2/b11;
Kp_1 = (2*xi_mod*wn_mod-a11)/b11;
Gc1 = Kp_1 + Ki_1/s;              % Controlador para   u1 --> y1

b22 = K22/tau2; a22 = 1/tau2;
Ki_2 = wn_mod^2/b22;
Kp_2 = (2*xi_mod*wn_mod-a22)/b22;
Gc2 = Kp_2 + Ki_2/s;             % Controlador para   u2 --> y2

b33 = K33/tau3; a33 = 1/tau3;
Ki_3 = wn_mod^2/b33;
Kp_3 = (2*xi_mod*wn_mod-a33)/b33;
Gc3 = Kp_3 + Ki_3/s;             % Controlador para   u3 --> y3

Gc = [Gc1   0     0              
       0   Gc2    0
       0    0    Gc3]
   
GLA = G*Gc;
G_uno = eye(3);
Gyr = feedback(GLA,G_uno);      % Sistema resultante en lazo cerrado
figure(2)
% Respuesta a cambio en SP tipo escalón del sistema en lazo cerrado 
step(Gyr), grid    
title('Multiloop Control con 3 PI')

% Representación en el espacio de estados
[A,B,C,D] = ssdata(G); 
Mc = ctrb(A,B); rango_Mc = rank(Mc) 
if length(A) == rango_Mc
    disp('Sistema completamente controlable')
    disp('Puede aplicar control por realimentación del vector de estado:')
    disp('            1. Control Modal')
    disp('            2. Control LQR')
    Kc_place = place(A,B,[-2, -2.1, -1.9])    % Control Modal
    eig(A-B*Kc_place)
    Qc = C'*C; Rc = diag([1,1,1])*0.01;
    Kc_lqr = lqr(A,B,Qc,Rc)                   % Control LQR
    eig(A-B*Kc_lqr)
    
    % Cálculos de los sistemas resultantes en lazo cerrado
    % Caso de Control Modal
    Ayr_place = A-B*Kc_place; 
    Cyr_place = C-D*Kc_place;
    PreC_place = inv(Cyr_place*inv(-Ayr_place)*B+D);
    Byr_place = B*PreC_place;
    Dyr_place = D*PreC_place;
    Gyr_place_ss = ss(Ayr_place,Byr_place,Cyr_place,Dyr_place);
    % Caso de LQR
    Ayr_lqr = A-B*Kc_lqr;
    Cyr_lqr = C-D*Kc_lqr;
    PreC_lqr = inv(Cyr_lqr*inv(-Ayr_lqr)*B+D);
    Byr_lqr = B*PreC_lqr;
    Dyr_lqr = D*PreC_lqr;
    Gyr_lqr_ss = ss(Ayr_lqr,Byr_lqr,Cyr_lqr,Dyr_lqr);
    
    % Respuesta temporal a cambio en SP tipo escalón
    figure(3)
    step(Gyr_place_ss),grid
    title('Control Modal')
    figure(4)
    step(Gyr_lqr_ss), grid
    title('Control LQR')
end    
