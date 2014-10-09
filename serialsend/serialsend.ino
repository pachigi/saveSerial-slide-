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
  int sendData=swipe/4;
  if(sendData==255){
    sendData=254;
  }
  analogWrite(9,sendData+1); 

  if(sw==HIGH&&last_sw==LOW){
    Serial.write(0);
    serialWrite=!serialWrite;
  }

  if(serialWrite){
    Serial.write(sendData+1);
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














