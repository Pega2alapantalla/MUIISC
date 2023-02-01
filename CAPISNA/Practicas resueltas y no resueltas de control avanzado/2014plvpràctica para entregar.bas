 ' Profesor:. M. Prian. 2021
 'Practica para entregar de control del caos.
 'Control caos hibrido.
 'Sistema hipercaótico autónomo con 3 exponentes de Lyapunov positivo:PLV
  'Realizar el control en todas la variables 
 
DEFDBL A-Z ' Doble precisión
 

 ' Condiciones iniciales
 x12 = -2#
 x22 = 0#
 x32 = 0#
 x42 = 1#
 x52 = 0# 
 
 pi = 4# * ATN(1) 'Numero Pi
 
 'Parámetros del sistema
 a1=0.6#: a2=10#: a3=1.5#: a4=1.5#: a5=0.5#: 
 a6=3.8#: a7=28#: a8=.2#: a9=.19#: a10=.9#: a11=.6#
 
 co = 11# ' Color
 
 SCREEN 12 ' Tipo de Pantalla
 WINDOW (-43, -6)-(43, 6)' Ventana de visualización

 dt = .0001# ' Incremento del tiempo

lazo:

 'Modelo de Hipercaos PLV: Realizado con un integrador numérico de Euler Directo

 g12 = a1*x12-a2*x22+a3*x32+a4*x42-a11*x52+u1 
 g22 = a5*x12-a6*atn(a7*x22)+u2 
 g32 = -a8*x12-a4*x42+u3
 g42 = a9*x32-a11*x52+u4 
 g52 = a10*x42+u5 
 
 x12 = x12 + g12 * dt
 x22 = x22 + g22 * dt
 x32 = x32 + g32 * dt
 x42 = x42 + g42 * dt
 x52 = x52 + g52 * dt

 'Controlador 
 
  'poner aquí el controlador
 
 'fin del conttrolador

t = t + dt ' tiempo continuo
                        

 a$ = INKEY$ ' manejo de teclas
 
 IF a$ = "-" THEN CLS ' aclarado de pantalla
 
  
 PSET (x12, x22), co' Proyección de la trayectoria en un plano

 
 
 GOTO lazo

 END





