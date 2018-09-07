



void serialEvent(Serial port){ 
   String inData = port.readStringUntil('\n');
   inData = trim(inData);                 
   if (inData.charAt(0) == 'S'){          
     inData = inData.substring(1);        
     Sensor = int(inData);                
   }
   if (inData.charAt(0) == 'B'){          
     inData = inData.substring(1);        
     BPM = int(inData);                   
     beat = true;                         
     heart = 20;                          
   }
 if (inData.charAt(0) == 'Q'){             
     inData = inData.substring(1);        
     IBI = int(inData);                   
   }
}
