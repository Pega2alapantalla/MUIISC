// Sketch for commanding a PWM servo through bluetooth using ros
// and rosserial

// PINS
// Pin 9 controls the servo
// Pin 3 --> BT RX (at 3.3V)
// Pin 2 --> BT TX 
#include<Arduino.h>

#include<Servo.h>

Servo servo;

#include<SoftwareSerial.h>
SoftwareSerial BTserial (2, 3); //RX PIN, TX PIN
const long BTbaud = 9600;


#include<ros.h>
#include<std_msgs/UInt16.h>
#include<std_msgs/String.h>

ros::NodeHandle nh;

bool movement = false ;

void servo_serial(const std_msgs::UInt16& angulo){
  servo.write(angulo.data);
  movement = true; 
}

ros::Subscriber<std_msgs::UInt16> sus("angle_command" , servo_serial);

std_msgs::String estado;
std_msgs::UInt16 angulo;
ros::Publisher publicador("status" , &estado);


char c=" ";

void setup() {

  Serial.begin(9600);
  
  BTserial.begin(BTbaud);

  nh.getHardware()->setBaud(9600);
  nh.initNode();
  nh.subscribe(sus);
  nh.advertise(publicador);

  servo.attach(9);

}

void loop() {

  if (BTserial.available()){
    c=BTserial.read();
    Serial.write(c);
  }
  


  if (movement){
    estado.data = "Moving";
    publicador.publish(&estado);
    nh.spinOnce();
    delay(50);
  }
  estado.data = "Stand-by";
  publicador.publish(&estado);
  nh.spinOnce();
  delay(100);
}
