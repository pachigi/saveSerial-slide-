import processing.serial.*;
import ddf.minim.*;

Serial serial;
ArrayList <String> Idata;
int inputData, start, count, i;


Minim minim;
AudioInput in;
AudioRecorder recorder; 
AudioPlayer player;

void setup() {
  serial=new Serial(this, Serial.list()[0], 19200);
  Idata=new ArrayList<String>();

  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);
  recorder = minim.createRecorder(in, "myrecording.wav", true);
}

void draw() {
}

void sendLEDSequence() {
  String []readData=loadStrings("idata.txt");
  int dataLength = readData.length;
  int []writeData=new int[dataLength];
  for (int j = 0; j < dataLength; j++) {
    writeData[j]=int(readData[j])-128;
  }


  player=minim.loadFile("myrecording.wav");
  player.play();

  for (int j = 0; j < dataLength; j++) {
    serial.write(byte(writeData[j]));
    print(writeData[j]+"=>");
    delay(100);
  }
}




void serialEvent(Serial port) {
  inputData=port.read();

  print(inputData+"->");
  Idata.add(str(inputData));

  if (inputData==0) {


    if ( recorder.isRecording() ) {
      recorder.endRecord();
      println("end");
    }
    else {
      recorder.beginRecord();
      println("start");
    }
  }
}

void keyPressed() {

  if (key=='s') {
    String []saveData=new String[Idata.size()];
    for (int i=0;i<saveData.length;i++) {
      saveData[i]="";
    }
    for (int  j=0;j<saveData.length;j++) {
      saveData[j]=Idata.get(j);
    }
    saveStrings("idata.txt", saveData);
    delay(100);
    recorder.save();

    println("Done saving");
  }

  if (key=='p') {
    sendLEDSequence();
  }
}

