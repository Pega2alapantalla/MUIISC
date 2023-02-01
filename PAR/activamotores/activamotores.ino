int i=0;
// the setup function runs once when you press reset or power the board
void setup() {
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(10, OUTPUT);
  Serial.begin(9600);
  pinMode(9,OUTPUT);
  pinMode(11,OUTPUT);
  pinMode(8, OUTPUT);
}

// the loop function runs over and over again forever
void loop() {
    delay(10);                       // wait for a second
    digitalWrite(10,HIGH);
    digitalWrite(8,LOW);  
    
    delay(10);                       // wait for a second
    digitalWrite(11,HIGH);
    digitalWrite(9,LOW);  
    delay(1000);  
    Serial.println("brum");
}
