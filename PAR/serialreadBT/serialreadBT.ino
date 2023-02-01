//  Sketc: basicSerialWithNL_001
// 
//  Uses hardware serial to talk to the host computer and software serial 
//  for communication with the Bluetooth module
//  Intended for Bluetooth devices that require line end characters "\r\n"
//
//  Pins
//  Arduino 5V out TO BT VCC
//  Arduino GND to BT GND
//  Arduino D9 to BT RX through a voltage divider
//  Arduino D8 BT TX (no need voltage divider)
//
//  When a command is entered in the serial monitor on the computer 
//  the Arduino will relay it to the bluetooth module and display the result.
//


//#include <SoftwareSerial.h>
//SoftwareSerial BTserial(8, 9); // RX | TX

//const long baudRate = 38400; 
const long baudRate = 9600; 
int c;
boolean NL = true;

void setup() 
{
    Serial.begin(9600);
    Serial1.begin(9600);
  
}

void loop()
{

    // Read from the Bluetooth module and send to the Arduino Serial Monitor
    if (Serial1.available())
    {
        c = Serial1.read();
        Serial.print(int(c)-(int)'0');
        if(int(c)-(int)'0'==2)
        Serial.println("VERDAD");
    }
  

//    // Read from the Serial Monitor and send to the Bluetooth module
//    if (Serial.available())
//    {
//        c = Serial.read();
//        BTserial.write(c);   
//
//        // Echo the user input to the main window. The ">" character indicates the user entered text.
//        if (NL) { Serial.print(">");  NL = false; }
//        Serial.write(c);
//        if (c==10) { NL = true; }
//    }

}
