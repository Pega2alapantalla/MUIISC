#define i1 9   // Control pin 1 for motor 1
#define i2 8   // Control pin 2 for motor 1

void setup()
  {   
      for (int i = 8 ; i<11 ; i++)                     
         pinMode( i, OUTPUT);
  }

void loop(){
   // Activamos Motor1
   digitalWrite(i1, HIGH);  // Arrancamos
   digitalWrite(i2, LOW);
   delay(3000);

   // Activamos Motor1
   digitalWrite(i1, LOW); // cambio de dirección
   digitalWrite(i2, HIGH);
   delay(3000);
    //Parar
   digitalWrite(i1,LOW);//Con dos pines a LOW, se para
   digitalWrite(i2,LOW);
   }
