#define i1 11   // Control pin 1 for motor 1 | pin 2 
#define i2 10   // Control pin 2 for motor 1 | pin 7
#define i3 6    // Control pin 1 for motor 2 | pin 15
#define i4 5    // Control pin 2 for motor 2 | pin 10
int command_vel;
bool sentido; //true es hacia adelante

void motorCC(char motor, int vel)
{
 if (vel<0)
 {
  sentido=false;
  vel=vel*-1;
 }
 else
 {
  sentido=true;
 }

  command_vel=map(vel,0,100,0,1024);
switch (motor)
{
  case 'd':
  if(sentido)
  {
    analogWrite(i1,vel);
    digitalWrite(i2,LOW);
  } else{
    analogWrite(i2,vel);
    digitalWrite(i1,LOW);
  }
  break;
  case 'i':
  if(sentido)
  {
    analogWrite(i3,vel);
    digitalWrite(i4,LOW); 
  }
  else
  {
    analogWrite(i4,vel);
    digitalWrite(i3,LOW);
  }
  

  
}
   
}

void setup()
  {                       
      pinMode( i1, OUTPUT);
      pinMode( i2, OUTPUT);
      
      pinMode( i3, OUTPUT);
      pinMode( i4, OUTPUT);
  }

void loop(){


  motorCC('d',100);
  delay(1000);
  
  motorCC('d',-100);
  delay(1000);
  
  motorCC('d',50);
  delay(1000);
  
  motorCC('d',-50);
  delay(1000);
  
  motorCC('i',100);
  delay(1000);
  
  motorCC('i',-100);
  delay(1000);
  
  motorCC('i',50);
  delay(1000);
  
  motorCC('i',-50);
  delay(1000);
  









  
   // Activamos Motor1
//   digitalWrite(i1, HIGH);  // Arrancamos
//   digitalWrite(i2, LOW);
//   delay(3000);
//
//   // Activamos Motor1
//   digitalWrite(i1, LOW); // cambio de dirección
//   digitalWrite(i2, HIGH);
//   delay(3000);
//    //Parar
//   digitalWrite(i1,LOW);//Con dos pines a LOW, se para
//   digitalWrite(i2,LOW);
   }
