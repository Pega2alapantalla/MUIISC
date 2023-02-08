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
 
 co = 15# ' Color
 
 SCREEN 12 ' Tipo de Pantalla
 WINDOW (-43, -6)-(43, 6)' Ventana de visualización

 dt = .0001# ' Incremento del tiempo

lazo:

 'Modelo de Hipercaos PLV: Realizado con un integrador numérico de Euler Directo

 g12 = a1*x12-a2*x22+a3*x32+a4*x42-a11*x52 'Se quita la u1
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
 
   signo1 = SGN((x22))
 
 IF signo1 = 1 AND signo2 = -1 THEN 'Para dectectar cuando el seno  pasa por cero de negativo a positivo, CECA, HSC

 e11 = x12 + ac1 * SIN(e11pre - x12)' Controlador en tiempo discreto, estabilizaci¢n, busqueda de upo
 e11pre = e11
 e1 = e11-x12
 
 e21 = x22 + ac2 * SIN(e21pre - x22)' Controlador en tiempo discreto, estabilizaci¢n, busqueda de upo
 e21pre = e21
 e2 = e21-x22
 
 e31 = x32 + ac3 * SIN(e31pre - x32)' Controlador en tiempo discreto, estabilizaci¢n, busqueda de upo
 e31pre = e31
 e3 = e31-x32
 
 e41 = x42 + ac4 * SIN(e41pre - x42)' Controlador en tiempo discreto, estabilizaci¢n, busqueda de upo
 e41pre = e41
 e4 = e41-x42
 
 e51 = x52 + ac5 * SIN(e51pre - x52)' Controlador en tiempo discreto, estabilizaci¢n, busqueda de upo
 e51pre = e51
 e5 = e51-x52
 END IF

 signo2 = SGN((x22))
 
 e1prima = -e1 * k1 ' Controlador en tiempo continuo
 e1 = e1 + e1prima * dt
 u1 = k1 * e1
 
 e2prima = -e2 * k2 ' Controlador en tiempo continuo
 e2 = e2 + e2prima * dt
 u2 = k2 * e2
  
 e3prima = -e3 * k3 ' Controlador en tiempo continuo
 e3 = e3 + e3prima * dt
 u3 = k3 * e3 
 
 e4prima = -e4 * k4 ' Controlador en tiempo continuo
 e4 = e4 + e4prima * dt
 u4 = k4 * e4
 
 e5prima = -e5 * k5 ' Controlador en tiempo continuo
 e5 = e5 + e5prima * dt
 u5 = k5 * e5 
 
 'fin del conttrolador

t = t + dt ' tiempo continuo
                        

 a$ = INKEY$ ' manejo de teclas
 
 IF a$ = "-" THEN CLS ' aclarado de pantalla
 IF a$ = "a" THEN p1 = .8#:ac1=0.8#: ac2=0.8#: ac3=0.8#: ac4=0.8#: ac5=0.8#: k1 = 50#:k2 = 50#:k3 = 50#:k4 = 50#:k5 = 50#: co = 11 ' parámetros de los controladores, entran cuando se pulse la tecla c
 IF a$ = "d" THEN p1 = 0:ac1=0: ac2= 0:ac3=0: ac4=0: ac5=0: k1 = 0:k2 = 0:k3 = 0:k4 = 0:k5 = 0: co = 14' descontrol
 
  
 PSET (x12, x22), co' Proyección de la trayectoria en un plano

 
 
 GOTO lazo

 END





