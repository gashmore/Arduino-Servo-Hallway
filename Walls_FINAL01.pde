#include <Servo.h>

Servo servo1;
Servo servo2;
Servo servo3;
Servo servo4;
Servo servo5;
Servo servo6;

int whitecount01;
int whitecount02;
int whitecount03;

int serialData;

void setup() { 

  Serial.begin(9600);

  servo1.attach(3);

  servo3.attach(6);


}

void loop() {

  if(Serial.available() > 0)  {

    serialData = Serial.read();

    if ( serialData == 'a' ) {
      
      serialData = serialData - 'a';
      whitecount01 = map(serialData, 0, 103000, 0, 130);
      
      servo1.write(whitecount01);

    }

  }

  /*
  whitecount01 = map(whitecount01, 0, 103000, 0, 130);
   whitecount02 = map(whitecount02, 0, 103000, 0, 130);
   whitecount03 = map(whitecount03, 0, 103000, 0, 130);
   
   //Write values to servos for group one
   if ((millis() - updateFrames01) > 5000) {
   
   servo1.attach(3);
   servo2.attach(5);
   
   for (int v=0; v<rawSerial; v+=1) {
   servo1.write(v);
   servo2.write(v);
   delay(10);
   }
   
   servo1.detach();
   servo2.detach();    
   
   updateFrames01 = millis();
   }
   
   
   //Write values to servos for group two
   if ((millis() - updateFrames02) > 5100) {
   
   servo3.attach(6);
   servo4.attach(9);
   
   for (int v=0; v<whitecount02; v+=1) {
   servo3.write(v);
   servo4.write(v);
   delay(10);
   }
   
   servo3.detach();
   servo4.detach();
   
   updateFrames02 = millis();
   }
   
   //Write values to servos for group three
   if ((millis() - updateFrames02) > 5200) {
   
   servo5.attach(10);
   servo6.attach(11);
   
   for (int v=0; v<whitecount03; v+=1) {
   servo5.write(v);
   servo6.write(v);
   delay(10);
   }
   
   servo5.detach();
   servo6.detach();
   
   updateFrames02 = millis();
   }*/
}
















