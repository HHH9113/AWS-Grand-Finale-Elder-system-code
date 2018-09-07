

class Scrollbar{
 int x,y;               
 float sw, sh;          
 float pos;             
 float posMin, posMax;  
 boolean rollover;      
 boolean locked;        
 float minVal, maxVal;  
 
 Scrollbar (int xp, int yp, int w, int h, float miv, float mav){ 
  x = xp;
  y = yp;
  sw = w;
  sh = h;
  minVal = miv;
  maxVal = mav;
  pos = x - sh/2;
  posMin = x-sw/2;
  posMax = x + sw/2; 
 }
 

 void update(int mx, int my) {
   if (over(mx, my) == true){
     rollover = true; 
   } else {
     rollover = false;
   }
   if (locked == true){
    pos = constrain (mx, posMin, posMax);
   }
 }


 void press(int mx, int my){
   if (rollover == true){
    locked = true;            
   }else{
    locked = false;
   }
 }

 void release(){
  locked = false; 
 }
 
 boolean over(int mx, int my){
  if ((mx > x-sw/2) && (mx < x+sw/2) && (my > y-sh/2) && (my < y+sh/2)){
   return true;
  }else{
   return false;
  }
 }
 
 void display (){

  noStroke();
  fill(255);
  rect(x, y, sw, sh);      
  fill (250,0,0);
  if ((rollover == true) || (locked == true)){             
   stroke(250,0,0);
   strokeWeight(8);          
  }
  ellipse(pos, y, sh, sh);   
  strokeWeight(1);           
 }
 
 float getPos() {
  float scalar = sw / sw;  // (sw - sh/2);
  float ratio = (pos-(x-sw/2)) * scalar;
  float p = minVal + (ratio/sw * (maxVal - minVal));
  return p;
 } 
 }
 
