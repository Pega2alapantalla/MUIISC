/*Amadini Matteo
 * Código que envía la posición angular, definida por un potenciómetro, 
 * para que la tomen todos los servomotores que están escuchando el paquete 'servoPos'.
 */

//Condiction por definir que libreria utilizar
#if defined(ARDUINO) && ARDUINO >= 100
  #include "Arduino.h"
#else
  #include <WProgram.h>
#endif


#include <ros.h> //Libreria para la comunicationa entre arduino y ros
#include <std_msgs/UInt16.h> //Biblioteca para utilizar los paquetes estándar de Ros, en particular los que deben contener números int.

/*Definicion del nombre del nodo, el nombre es el mismo de aquello escritto 
 * en el file DosArduino.launch, para poder utilizar dos arduino ambos conectados a ordinador.
 */
ros::NodeHandle  ArduinoTwo;

/*
 * Definicion de el mesaje que el nodo va a enviar en red. El nombre de la variable es ServoPos_msg
 * en vez el nombre del paquete es "servoPos", donde alguien que esta escuchando este paquete puede
 * leer los datos, en particular la position angular
 */
std_msgs::UInt16  ServoPos_msg;
ros::Publisher pos("servoPos", &ServoPos_msg);


/*
 * Definicion de los variables que son necesaries para convertir 
 * el signal de potenciometro en angular posicion
 */
const int potIn = A0;
int valPot = 0;

//Module to interface with the ultrasonic sensor
//#define TRIGGER_PIN  2  //Arduino pin connected to TRIG
//#define ECHO_PIN     3  //Arduino pin connected to ECHO

void setup(){

  ArduinoTwo.initNode(); //Inicializacion del node
  
  /*
   * Comando que pone el nodo en modalidad por enviar el paquete pos en la red
   */
  ArduinoTwo.advertise(pos);
    // Define each pin as an input or output.
  //pinMode(ECHO_PIN, INPUT);
  //pinMode(TRIGGER_PIN, OUTPUT);

}

int distance = 0;

void loop(){

//  digitalWrite(TRIGGER_PIN, LOW);
//  delayMicroseconds(2); 
//  digitalWrite(TRIGGER_PIN, HIGH);
//  delayMicroseconds(10);
//  digitalWrite(TRIGGER_PIN, LOW);
//  distance = pulseIn(ECHO_PIN, HIGH);
//  distance = distance / 74 / 2;
//  delay(10);
  valPot = map(analogRead(potIn), 0, 1023, 0, 100);
  ServoPos_msg.data = valPot;//Transferencia de la posición angular al paquete 'servoPos'
  pos.publish( &ServoPos_msg );//Envio del paquete en la red
  ArduinoTwo.spinOnce();//Comdando para ver si hay un paquete que estamos escuchando
  delay(1);
  Serial.println(distance);
}
