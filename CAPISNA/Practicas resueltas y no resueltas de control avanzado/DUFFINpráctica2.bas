 'Práctica 2021: Profesor M. Prian: Solución
 'Control del caos híbrido, sistema no autónomo o sistema forzado
 'Control del caos en upos del sistema de duffing
 'control en una sola variable
 'probar primero con las dos y despues quitar una y ajustar el parámetro k

DEFDBL A-Z
 

 ' Condiciones iniciales
 x12 = 0.5#
 x22 = 0.5#
 
 
 ' Ganancias de control

 k2 = 0
 k1 = 0
 
 'Parámetros del sistema sin controlar
 a = .2#
 b = 0.8#
 
 
 co = 11# ' color

 SCREEN 12 ' Tipo de pantalla
 WINDOW (-2, -2)-(2, 2)' Ventana de visualización
 
 dt = .0001# ' Paso de integración
 
 t = 0 ' Tiempo inicial

lazo: ' bucle repetitivo

 
 'Atractor de duffin
 'Planta controlada

  
 g12 = x22 + u1
 g22 = -.1# * x22 + b * (x12 - x12 ^ 3) + a * SIN(t)+u2 

 x12 = x12 + g12 * dt
 x22 = x22 + g22 * dt
 
 ' sistema de control
 signo1 = SGN(SIN(t))
 
 IF signo1 = 1 AND signo2 = -1 THEN 'Para dectectar cuando el seno  pasa por cero de negativo a positivo, CECA, HSC

 e11 = x12 + a1 * SIN(e11pre - x12)' Controlador en tiempo discreto, estabilizaci¢n, busqueda de upo
 e11pre = e11
 e1 = e11-x12
 
 e21 = x22 + a2 * SIN(e21pre - x22)' Controlador en tiempo discreto, estabilizaci¢n, busqueda de upo
 e21pre = e21
 e2 = e21-x22
 
 END IF

 signo2 = SGN(SIN(t))
 
 e1prima = -e1 * k1 ' Controlador en tiempo continuo
 e1 = e1 + e1prima * dt
 u1 = k1 * e1
 
 e2prima = -e2 * k2 ' Controlador en tiempo continuo
 e2 = e2 + e2prima * dt
 u2 = k2 * e2
 
  'fin sistema de control
 
 t = t + dt ' Incremento del tiempo continuo


 a$ = INKEY$ ' Manejo de teclas
 IF a$ = "-" THEN CLS ' para aclarar pantalla
 IF a$ = "c" THEN p1 = .8#:a1=0.8#: a2=0.8#: k1 = 50#:k2 = 50#: co = 11 ' parámetros de los controladores, entran cuando se pulse la tecla c
 IF a$ = "d" THEN p1 = 0:a1=0: a2= 0: k1 = 0:k2 = 0: co = 14' descontrol
 

 PSET (x12, x22), co 'punto visualizado en pantalla


 GOTO lazo ' del bucle repetitivo

 END





