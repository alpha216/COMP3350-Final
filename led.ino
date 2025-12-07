//-------------------------
// C Code for Blinking LED
//-------------------------
extern "C"
{
  void start();
  // void led(byte);
  void button();
}

const int buttonPin = 2;  // the number of the pushbutton pin
int buttonState = 0;  // variable for reading the pushbutton status


//----------------------------------------------------
void setup()
{
  pinMode(buttonPin, INPUT);
  start();
  
}
//----------------------------------------------------
void loop()
{
  button();
}
