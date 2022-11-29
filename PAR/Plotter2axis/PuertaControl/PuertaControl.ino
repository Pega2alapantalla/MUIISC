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
#include <std_msgs/Bool.h>

ros::NodeHandle  nh;
//std_msgs::Bool button_pushed;
//ros::Publisher pub_button("pushed", &pushed_msg);

Servo servo;

void activapuerta( const std_msgs::Bool button_pushed){
  
  if(button_pushed.data){
  servo.write(90); //open door  
  digitalWrite(13, HIGH);//toggle led
  }
  else{
  servo.write(0); //close door  
  digitalWrite(13, LOW);//turn off led
  }  
}


ros::Subscriber<std_msgs::Bool> sub("boton", activapuerta );

void setup(){
  

  nh.initNode();
  nh.subscribe(sub);
  
  servo.attach(9); //attach it to pin 9
}

void loop(){
  nh.spinOnce();
  delay(1);
}
