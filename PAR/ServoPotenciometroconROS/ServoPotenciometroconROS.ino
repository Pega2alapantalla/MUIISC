/*
 * rosserial Servo Control Example
 *
 * This sketch demonstrates the control of hobby R/C servos
 * using ROS and the arduiono
 * 
 * For the full tutorial write up, visit
 * www.ros.org/wiki/rosserial_arduino_demos
 *
 * For more information on the Arduino Servo Library
 * Checkout :
 * http://www.arduino.cc/en/Reference/Servo
 */

#if (ARDUINO >= 100)
 #include <Arduino.h>
#else
 #include <WProgram.h>
#endif

#include <Servo.h> 
#include <ros.h>
#include <std_msgs/UInt16.h>
#include <std_msgs/Float32.h>
#include <rosserial_arduino/Adc.h>

float valorADCcuentas;

float ValorADC,valorADCvolts,variableangulo;


rosserial_arduino::Adc adc_msg;
ros::NodeHandle  nh;

Servo servo;

void servo_cb( const std_msgs::Float32& cmd_msg){
  servo.write(cmd_msg.data); //set servo angle, should be from 0-180  
  digitalWrite(13, HIGH-digitalRead(13));  //toggle led  
}



ros::Subscriber<std_msgs::Float32> sub("angulotopic", servo_cb);

std_msgs::Float32 valorangulo;
//rosserial_arduino::Adc valorangulo;

ros::Publisher angulofunc("angulotopic", &valorangulo );

void setup(){
  pinMode(13, OUTPUT);
  

  nh.initNode();
  nh.subscribe(sub);
  nh.advertise(angulofunc);
  
  servo.attach(9); //attach it to pin 9
}

void loop(){
  valorADCcuentas=analogRead(A0);
  valorADCvolts=valorADCcuentas/1023*5;

  //valorangulo.adc0=valorADCvolts/5*180;
  valorangulo.data=valorADCcuentas/1023*180;
  angulofunc.publish(&valorangulo);
  
  nh.spinOnce();
  delay(100);
}
