import processing.serial.*;
PFont font;
Scrollbar scaleBar;

Serial port;     

int Sensor;
int IBI;   
int BPM;   
int[] RawY;
int[] ScaledY;
int[] rate;   
float zoom;   
float offset; 
color eggshell = color(255, 253, 248);
int heart = 0;  

int PulseWindowWidth = 490;
int PulseWindowHeight = 512; 
int BPMWindowWidth = 180;
int BPMWindowHeight = 340;
boolean beat = false;   


void setup() {
  size(700, 600);  
    frameRate(100);  
  font = loadFont("Arial-BoldMT-24.vlw");
  textFont(font);
  textAlign(CENTER);
  rectMode(CENTER);
  ellipseMode(CENTER);  
  scaleBar = new Scrollbar (400, 575, 180, 12, 0.5, 1.0);  
  RawY = new int[PulseWindowWidth];          
  ScaledY = new int[PulseWindowWidth];       
  rate = new int [BPMWindowWidth];           
  zoom = 0.75;                               
  
 for (int i=0; i<rate.length; i++){
    rate[i] = 555;      
   }
 for (int i=0; i<RawY.length; i++){
    RawY[i] = height/2; 
 }
   

  println(Serial.list());   
  port = new Serial(this, Serial.list()[0], 115200);  
  port.clear();            
  port.bufferUntil('\n');  }
  
void draw() {
  background(0);
  noStroke();
  fill(eggshell);  
  rect(255,height/2,PulseWindowWidth,PulseWindowHeight);
  rect(600,385,BPMWindowWidth,BPMWindowHeight);
  
  // prepare pulse data points    
  RawY[RawY.length-1] = (1023 - Sensor) - 212;   
  zoom = scaleBar.getPos();                        offset = map(zoom,0.5,1,150,0);                
  for (int i = 0; i < RawY.length-1; i++) {      
    RawY[i] = RawY[i+1];                         
    float dummy = RawY[i] * zoom + offset;       
    ScaledY[i] = constrain(int(dummy),44,556);   
  }
  stroke(250,0,0);                               
  noFill();
  beginShape();                                  
  for (int x = 1; x < ScaledY.length-1; x++) {    
    vertex(x+10, ScaledY[x]);                    
  }
  endShape();
 if (beat == true){    
   beat = false;      
   for (int i=0; i<rate.length-1; i++){
     rate[i] = rate[i+1];                  
   }
   BPM = min(BPM,200);                     
   float dummy = map(BPM,0,200,555,215);   
   rate[rate.length-1] = int(dummy);       
 } 

 stroke(250,0,0);                          
 strokeWeight(2);                          
 noFill();
 beginShape();
 for (int i=0; i < rate.length-1; i++){       
   vertex(i+510, rate[i]);                 
 }
 endShape();
 
  fill(250,0,0);
  stroke(250,0,0);

  heart--;                    
  heart = max(heart,0);       
  if (heart > 0){              
    strokeWeight(8);          
  }
  smooth();   
  bezier(width-100,50, width-20,-20, width,140, width-100,150);
  bezier(width-100,50, width-190,-20, width-200,140, width-100,150);
  strokeWeight(1);          



  fill(eggshell);                                       
  text("Pulse Sensor Amped Visualizer 1.1",245,30);     
  text("IBI " + IBI + "mS",600,585);                    
  text(BPM + " BPM",600,200);                           
  text("Pulse Window Scale " + nf(zoom,1,2), 150, 585); 

  scaleBar.update (mouseX, mouseY);
  scaleBar.display();
  
   
} 


