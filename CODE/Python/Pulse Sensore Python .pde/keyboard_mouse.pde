
void mousePressed(){
  scaleBar.press(mouseX, mouseY);
}

void mouseReleased(){
  scaleBar.release();
}

void keyPressed(){

 switch(key){
   case 's':    
   case 'S':
     saveFrame("heartLight-####.jpg");      break;

   default:
     break;
 }
}
