int sw=HIGH,last_sw=LOW;
boolean serialWrite=false;

void setup(){
  Serial.begin(19200);
  pinMode(9,OUTPUT);
  pinMode(0,INPUT);
  pinMode(2,INPUT);
}

void loop(){
  int sw=digitalRead(2);


  int swipe=analogRead(0);

  analogWrite(9,swipe/4); 

  if(sw==HIGH&&last_sw==LOW){
    Serial.write(1);
    serialWrite=!serialWrite;
  }

  if(serialWrite){
    Serial.write(swipe/4);
    
  }

  byte data=0;
  if(Serial.available()){
    data=Serial.read();
    int Idata=data+128;
    analogWrite(9,Idata);

  }

  last_sw=sw;
  delay(100);
}













