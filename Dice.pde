//DiceLED
int ledPins[7] = {2,3,4,5,6,7,8};
int blank = 6;

int dicePatterns[7][7] = {
  {0,0,0,0,0,0,1}, //1
  {0,0,1,1,0,0,}, //2
  {0,0,1,1,0,0,1}, //3
  {1,0,1,1,0,1,0}, //4
  {1,0,1,1,0,1,1}, //5
  {1,1,1,1,1,1,0}, //6
  {0,0,0,0,0,0,0}, //Blank  
};

//Control
int buttonPin = 12;

//Sound
int speakerPin = 9;
int length = 15;
char names[] = {'c','d','e','f','g','a','b','c'};
char notes[] = "ffbfedc ffbfecedc ";
int beats[] = {3,1,1,1,1,3,2,1,3,1,1,1,1,1,1,2,2};
int tempo = 300;

void playTone(int ton, int duration) {
  for(long i = 0; i < duration * 1000L; i += ton*2) {
    digitalWrite(speakerPin,HIGH);
    delayMicroseconds(ton);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(ton);
  }
}
void playNote(char note, int duration) {
  int tones[] = {1915,1700,1432,1275,1136,1014,956};
  for(int i = 0; i < 8;i++) {
    if (names[i] == note)  {
      playTone(tones[i],duration);
      return;
    }
  }
}

void setup()
{
   for(int i = 0;i < 7;i++)
   {
      pinMode(ledPins[i], OUTPUT); 
      digitalWrite(ledPins[i], LOW);
   }
   pinMode(speakerPin,OUTPUT);
  //pinMode(buttonPin,INPUT);
  
  pinMode(ledPin, OUTPUT);
  randomSeed(analogRead(0));
}

void playRandom() {
  int rand = random(0,8);
  playNote(names[rand], 10);
}

void playResult() {
  for(int i = 0; i < 5; i++) {
      playNote(names[6], 50);
      playNote(names[5], 50);    
      playNote(names[6], 50);    
      delay(100);
  }
}
  
void loop()
{
  if(digitalRead(buttonPin))
  {
    digitalWrite(ledPin, HIGH);
    diceRoll(); 
    digitalWrite(ledPin, LOW);
  }
}

void diceRoll()
{
   int result = 0;
   int lengthOfRoll = random(15,25);
   for(int i = 0; i < lengthOfRoll; i++)
   {
     result = random(0,6);
     show(result);
     playRandom();
     delay(50 + i * 10); 
   }
   playResult();
   show(result);
}

void show(int result)
{
  for(int i = 0; i < 7; i++)
  {
     digitalWrite(ledPins[i],dicePatterns[result][i]);
  }   
}