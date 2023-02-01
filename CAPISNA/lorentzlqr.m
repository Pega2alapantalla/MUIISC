% Puntos de equilibrio de sistema de Lorenz
syms x1 x2 x3 sigma rho beta
f1 = sigma*(x2-x1);
f2 = rho*x1 - x2 -x1*x3;
f3 = -beta*x3 + x1*x2;
f = [f1, f2, f3]; x =[x1, x2, x3];
[P1,P2,P3]= solve(f,x);
P = [P1, P2, P3];
% P =
% [ (beta*(rho - 1))^(1/2), (beta*(rho - 1))^(1/2), rho - 1]
% [ 0, 0, 0]
% [ -(beta*(rho - 1))^(1/2), -(beta*(rho - 1))^(1/2), rho – 1]
Psimbolico = subs(P,[sigma,rho,beta],[10,28,8/3]);
% Psimbolico =
% [ 72^(1/2), 72^(1/2), 27]
% [ 0, 0, 0]
% [ -72^(1/2), -72^(1/2), 27]
Pnumerico = double(Psimbolico)
% Pnumerico =
% 8.4853 8.4853 27.0000
% 0 0 0
% -8.4853 -8.4853 27.0000

J = jacobian(f,[x1,x2,x3]);
% J =
% [ -sigma, sigma, 0]
% [ rho - x3, -1, -x1]
% [ x2, x1, -beta]
Jsimbolico_a = subs(J,[sigma,rho,beta],[10,28,8/3])
% Para primer punto de equililbrio: Psimbollico(1,:)  P1
Jsimbolico1 = subs(Jsimbolico_a,[x1,x2,x3],Psimbolico(1,:))
% Jsimbolico1 =
% [ -10, 10, 0]
% [ 1, -1, -72^(1/2)]
% [ 72^(1/2), 72^(1/2), -8/3]
Jnumerico1 = double(Jsimbolico1)
% Jnumerico1 =
% -10.0000 10.0000 0
% 1.0000 -1.0000 -8.4853
% 8.4853 8.4853 -2.6667
A1 = Jnumerico1; % matriz A de la linealización
% en punto de equilibrio P1

B1=eye(3);
C1=eye(3);
D1=zeros(3);


%% Calculo de KCC usando control modal
xi=0.7;
omega_n=4/5/0.7;
s=tf('s');
EC=1/(s^2+2*xi*omega_n*s+omega_n^2);
damp(EC)

KCC=place(A1,B1,[-13.85, -0.8 + 0.816*1i, -0.8 - 0.816*1i]);

A_yr=A1-B1*KCC;
eig(A_yr)

%% Valores para iniciar el lorentzsimu_control.slx
sigma=10;
beta=8/3;
rho=28;
% 
% init1=10;
% init2=-10;
% init3=10;
sat=5;
tau_act=0.01;
U_nom=[0;0;0];
init=Pnumerico(1,:)+1;

%%%%%%%%%%%%%%%%%%%%%%
%% Calculo de KC usando LQR
q=1;
Qc=eye(3)*q;
r=0.01;
Rc=eye(3)*r;
KClqr=lqr(A1,B1,Qc,Rc);
eig(A1-B1*KClqr)
damp(A1-B1*KClqr)

%% simulacion
[time,results]=sim('lorentzsimu_control.slx',15);
% figure(1)
% plot(time,x1)
% grid minor
% figure(2)
% plot(time,x2)
% grid minor
% figure(3)
% plot(time,x3)
% grid minor

%% Observador
v_1=[0.01^2,0,0
    0,0.01^2,0
    0,0,0.01^2];
v_2=[0.16^2,0,0
    0,0.16^2,0
    0,0,0.16^2];
gamma=B1;
%v_2=v_2*0.1;
Q_o=gamma*v_1*gamma';
R_o=v_2;
KoT=lqr(A1',C1',Q_o,R_o);
Ko=KoT';


eig(A1-Ko*C1)