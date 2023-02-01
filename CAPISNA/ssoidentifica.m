xi=0.2044;
wn=0.5038;
td=0.4;
tau=1/wn;

b=1;
TI=2*xi*tau-(2*b^2-td^2)/(2*(2*b+td));
KP=TI/(0.5*(2*b+td));
TD=TI-2*xi*tau+tau^2/TI-td^3/(6*TI*(2*b+td));

figure(1)
stem(yk)
hk=yk./0.5;
nGz=hk';
dGz=[1,zeros(1,length(yk)-1)];

Tm=1;
z=tf('z');

Gz=tf(nGz,dGz,Tm);
