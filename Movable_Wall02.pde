#include <Servo.h> 

Servo servo1;       // create servo object to control a servo 

Servo servo2;       // create servo object to control a servo 

int lightPin = 0;   // Photo resistor in analog pin 0

int val;            // variable to read the value from the analog pin 

#define SETTING_TriggerLevel 10         // Value to determine if photo resistor is covered enough to do something

#define SETTING_TriggerNumber 250       // Value for time to wait before servos react

// State definitions
#define S_Init 0
#define S_Idle 1
#define S_Growing 2
#define S_Expanded 3
#define S_Shrinking 4

int state = S_Init;

int LDR_Trigger = 0; // Trigger number


void setup()

{ 
  Serial.begin(9600);    // sets the baud rate to 9600

    servo1.attach(9);   // attaches the servo on pin 9 to the servo object
    
    servo2.attach(10);   // attaches the servo on pin 10 to the servo object
} 


void loop()
{  

  switch (state) {

    // 0
  case S_Init:
  // Setup all servos and values
    Serial.println("Init");

    LDR_Trigger = 0; // Set trigger value to zero

    servo1.write(0);  // Set Servo 1 angle to 0 
    
    servo2.write(0);  // Set Servo 2 angle to 0    

    state = S_Idle; // Go to state Idle

    break;


    // 1
  case S_Idle:
    // Remain here until light level is detected as falling below a certain threshold
    Serial.println("Idle");

    val = analogRead(lightPin);         // Read the lightlevel

    val = map(val, 0, 900, -100, 150);  // scale it to use it with the servo (value between -100 and 150)

    val = constrain(val, 0, 130);       // make sure the value is betwween 0 and 130 degrees

    if (val > SETTING_TriggerLevel) {   // if light level from photo resistor is greater than TriggerLevel
      LDR_Trigger++;                    // count up
    }

    if (LDR_Trigger > SETTING_TriggerNumber) {  // Until TriggerLevel becomes greater than TriggerNumber go to
      state = S_Growing;                        // State Growing
    }

    break;


    // 2
  case S_Growing:
    // Slowly rotate servo to expanded position
    Serial.println("Growing");

    for (int v=0; v<130; v+=1) {   // Slowly rotate servo from 0 degrees to 130 degrees
      servo1.write(v);
      servo2.write(v);
      delay(20);
    }

    state = S_Expanded;  // When done, go to state Expanded

    break;


    // 3
  case S_Expanded:
    // Servo remains fully rotated until light level drops below a certain threshold
    Serial.println("Expanded");

    val = analogRead(lightPin);         // Read the lightlevel

    val = map(val, 0, 900, -100, 150);  // scale it to use it with the servo (value between -100 and 150) 

    val = constrain(val, 0, 130);       // make sure the value is betwween 0 and 130 degrees


    if (val < 10)  // if light getting to photo resistor gets below 10
    {
      state = S_Shrinking;  // go to state Shrinking
    }

    break;


    // 4
  case S_Shrinking:
    // Return servo back to idle position
    Serial.println("Shrinking");

    for (int v=130; v>0; v--) {  // Slowly rotate servo from 130 degrees to 0 degrees
      servo1.write(v);
      servo2.write(v);
      delay(20);
    }

    LDR_Trigger = 0;  // Set trigger number back to zero

    state = S_Idle;  // When done, go to state Idle

    break;
  }

}
