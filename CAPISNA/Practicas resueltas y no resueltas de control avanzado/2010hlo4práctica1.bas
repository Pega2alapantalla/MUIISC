' Control avanzado 2021: Práctica de sistema autónomo de 4º orden
 ' el control se ha realizado en una sola variable de forma directa
DEFDBL A-Z
 

 x12 = -20#
 x22 = 0#
 x32 = 0#
 x42 = 15#


 k2 = 0 'Ganancias de controlanalógico



 a2 = 0 'parámetro del controlador digital

 


 co = 11#
 SCREEN 12
 WINDOW (-30, -30)-(30, 30)
  dt = .0001#

lazo:

 'Planta controlada
 'Modelo de Hipercaos de lorenz con el control añadido: integrado con Euler directo

 
 g12 = -10# * (x12 - x22) + x42
 g22 = -x12 * x32 + 28# * x12 - x22 + u2
 g32 = x12 * x22 - 8# / 3# * x32
 g42 = -x12 * x32 - x42
 x12 = x12 + g12 * dt
 x22 = x22 + g22 * dt
 x32 = x32 + g32 * dt
 x42 = x42 + g42 * dt

 'Sistema de control
 
 signo1 = SGN((x42))  'la secci¢n variedad de eventos es el hiperplano x42=0
 IF signo1 = 1 AND signo2 = -1 THEN


 e22 = x22 + a2 * SIN(e22pre - x22)' Controlador digital, busqueda de upo
 e22pre = e22


 e2 = e22 - x22'c.i del integrador analógico


 END IF
 signo2 = SGN(x42)

 

 ge2 = -k2 * e2 ' Controlador analógico
 e2 = e2 + ge2 * dt 

 u2=k2*e2

 ' fin del sistema de control
  
 t = t + dt
 
 a$ = INKEY$
 IF a$ = "-" THEN CLS
 
 
 IF a$ = "c" THEN k2 = 176#: a2 = 1.9#: co = 11 ' Pulsando c se aplica el control
 IF a$ = "d" THEN k2 = 0#: a2 = 0#: co = 14' descontrol "d"
 

 PSET (x12, x22), co
 
  
 GOTO lazo

 END

