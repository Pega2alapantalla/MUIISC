#define USE_TEENSY_HW_SERIAL
#define USBCON
#include<ArduinoHardware.h>


#define i1 6  // Control pin 1 for motor 1 | pin 2
#define i2 8  // Control pin 2 for motor 1 | pin 7
#define i3 11   // Control pin 1 for motor 2 | pin 15
#define i4 5   // Control pin 2 for motor 2 | pin 10
#define servopwm 4 // Servo signal (orange) on arduino pin 9
#define CNY_L A4
#define CNY_R A2
#define RXBT 1
#define TXBT 0
#define USECHO 3
#define USTRIG 2



//DEFINE MOTORES
#define R 1
#define L 0

//DEFINE ESTADOS
#define STOP   0               //Implemented
#define SIGUE_LINEAS  2       //Implemented
#define CONTROL_DISTANCIA  4
#define BUSCA_OBJETO 6
#define CONTROL_A_MANDO  8    //
#define SUBE_VELOCIDAD  10     //Implemented
#define BAJA_VELOCIDAD  12     //Implemented

//#include <Arduino.h>

#include<Servo.h>
#include <HCSR04.h>
HCSR04 hc(USTRIG, USECHO); //initialisation class HCSR04 (trig pin , echo pin, number of sensor)

Servo servo;


#include<ros.h>
#include<std_msgs/Int16.h>
#include<std_msgs/Bool.h>


class NewHardware : public ArduinoHardware
{
  public:
  NewHardware():ArduinoHardware(&Serial1, 57600){};
};
ros::NodeHandle_<NewHardware>  nh;


int command_vel;
int start_vel = 50; //VELOCIDAD DE INICIO
int no_line;
int velocidadsel=0;
int k,keep_distance,last_distance,current_distance,delta_vel;
int pos, current_vel_R, current_vel_L;
//true es hacia adelante
int command_mode, current_mode, next_mode, ACK;
bool sentido;
bool FLAG_LOST, DISTANCE_INPUT;
bool motorseleccionado=true;


void selecmotor1( std_msgs::Bool& motorselecc)
{
  motorseleccionado=motorselecc.data;
}

ros::Subscriber<std_msgs::Bool> selecciona_motor_sub("selecmotor",selecmotor1);

void velocidad1( std_msgs::Int16& velsel)
{
  velocidadsel=velsel.data;
  
}

ros::Subscriber<std_msgs::Int16> vel_sub("velocidad", velocidad1);



void motorCC(bool motor, int vel) { //funcion para indicar la velocidad (-100 a 100) cualquier motor: 'i' (izquierdo), 'd' (derecho). (El PWM para un input de 0 es el 70%)
  if (vel < 0) {
    sentido = false;
    vel = vel * -1;
  } else {
    sentido = true;
  }

  if (vel > 100)
    vel = 100;
  //if (vel < 00)
  // vel = 0; //Si esta entre -70 y 70, se paran los motores

  command_vel = map(vel, 0, 100, 0, 254);
  if (motor) { //TRUE=derecho

    current_vel_R = vel;
    if (sentido) {

      analogWrite(i1, command_vel);
      digitalWrite(i2, LOW);


    } else {
      digitalWrite(i2, HIGH);
      analogWrite(i1, 254 - command_vel);
    }
  }

  else {

    current_vel_L = vel;
    if (sentido) {
      analogWrite(i3, command_vel);
      digitalWrite(i4, LOW);
    } else {
      analogWrite(i4, command_vel);
      digitalWrite(i3, LOW);
    }
  }
}


//void barrido()//Funcion para que el servo vaya de un lado a otro
//
//{
//  for (pos = 0; pos <= 180; pos += 1) { // goes from 0 degrees to 180 degrees
//    // in steps of 1 degree
//    servo.write(pos);              // tell servo to go to position in variable 'pos'
//    delay(10);                       // waits 15ms for the servo to reach the position
//  }
//  for (pos = 180; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
//    servo.write(pos);              // tell servo to go to position in variable 'pos'
//    delay(10);                       // waits 15ms for the servo to reach the position
//  }
//}


void setup() {
  pinMode(i1, OUTPUT);
  pinMode(servopwm, OUTPUT);
  pinMode(i2, OUTPUT);
  next_mode = STOP;
  pinMode(i3, OUTPUT);
  pinMode(i4, OUTPUT);
  pinMode(CNY_L, INPUT);

  pinMode(CNY_R, INPUT);

  servo.attach(servopwm);
  nh.initNode();
  nh.subscribe(selecciona_motor_sub);
  nh.subscribe(vel_sub);




}

void loop() {

delay(500);
nh.spinOnce();
}
