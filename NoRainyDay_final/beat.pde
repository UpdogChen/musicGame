class Beat{

  PImage perfectImg, goodImg, okImg, missImg;
  PImage img,beatLeft,beatUp,beatDown,beatRight,redUp,redDown,redLeft,redRight;
  float beatX,beatY,comboCal;  
  boolean beatOn,comboOn;
  
  

  //constructor
  Beat(){           
    beatLeft = loadImage("img/newleftDirect.png") ;
    beatUp = loadImage("img/newupDirect.png") ;
    beatDown = loadImage("img/newdownDirect.png") ;
    beatRight = loadImage("img/newrightDirect.png") ;
    redLeft = loadImage("img/antileftDirect.png") ;
    redUp = loadImage("img/antiupDirect.png") ;
    redDown = loadImage("img/antidownDirect.png") ;
    redRight = loadImage("img/antirightDirect.png") ;
    //
    perfectImg = loadImage("img/perfect.png") ;
    goodImg = loadImage("img/good.png") ;
    okImg = loadImage("img/okay.png") ;
    missImg = loadImage("img/miss.png") ;
  }
  
  void gameTimer(int frame){    
    if(gameTimer == frame){
    beatY = -90;
    beatOn = true;
  }  
  }
  
  float checkmove(){    
    return beatY;
  }
  
  void move(){
    if(beatOn){
    beatY+=3;}    
  }
  
 
  
  void display(int orient){
    if(beatOn){
      
          switch(orient){
        case 1: beatX = 15; beatDisplay = beatLeft;  break;
        case 2: beatX = 130; beatDisplay = beatUp;  break;
        case 3: beatX = 245; beatDisplay = beatDown;  break;
        case 4: beatX = 360; beatDisplay = beatRight; break;
        case 5: beatX = 360; beatDisplay = redLeft;  break;
        case 6: beatX = 245; beatDisplay = redUp;  break;
        case 7: beatX = 130; beatDisplay = redDown;  break;
        case 8: beatX = 15; beatDisplay = redRight; break;
      }  
      image(beatDisplay,beatX,beatY) ; 
      
    }
  }  
  
    void isHit(int orient){
      switch(orient){
        case 1:
    
      if(beatOn == true && beatY >= 615 && beatY <= 650 && leftPressed == true){
        hit.trigger();
        rateDisplay = perfectImg;
        rateDisplayTimer += 50;
        perfectCal++;
        beatOn = false;
        
      }else if(beatOn == true && beatY >= 605 && beatY <= 665 && leftPressed == true){
        hit.trigger();
        rateDisplay = goodImg;
        rateDisplayTimer += 50;
        goodCal++;
        beatOn = false;
        
      }else if(beatOn == true && beatY >= 585 - OKRANGE && beatY <= 685 && leftPressed == true){
        hit.trigger();
        rateDisplay = okImg;
        rateDisplayTimer += 50;
        okCal++;
        beatOn = false;
        
      }else if(beatOn == true && leftPressed == true && beatY > 545 && beatY < 580 || beatOn == true && leftPressed == true && beatY > 738){
        rateDisplay = missImg;
        rateDisplayTimer += 50;
        miss.trigger();
        missCal++; 
        beatOn = false;       
      }
    break;
    
    case 2:
    
    if(beatOn == true && beatY >= 615 && beatY <= 650 && upPressed == true){
      hit.trigger();
      rateDisplay = perfectImg;
      rateDisplayTimer += 50;
      perfectCal++;
      beatOn = false;
      
    }else if(beatOn == true && beatY >= 605 && beatY <= 665 && upPressed == true){
      hit.trigger();
      rateDisplay = goodImg;
      rateDisplayTimer += 50;
      goodCal++;
      beatOn = false;
      
    }else if(beatOn == true && beatY >= 585 - OKRANGE && beatY <= 685 && upPressed == true){
      hit.trigger();
      rateDisplay = okImg;
      rateDisplayTimer += 50;
      okCal++;
      beatOn = false;
      
    }else if(beatOn == true && upPressed == true && beatY > 545  && beatY < 580 || beatOn == true && upPressed == true && beatY > 738 ){
      rateDisplay = missImg;
      rateDisplayTimer += 50;
      miss.trigger();
      missCal++;
      beatOn = false;
      
    }
    break;
    
    case 3:
    
    if(beatOn == true && beatY >= 615 && beatY <= 650 && downPressed == true){
      hit.trigger();
      rateDisplay = perfectImg;
      rateDisplayTimer += 50;
      perfectCal++;
      beatOn = false;
      
    }else if(beatOn == true && beatY >= 605 && beatY <= 665 && downPressed == true){  
      hit.trigger();
      rateDisplay = goodImg;
      rateDisplayTimer += 50;
      goodCal++;
      beatOn = false;
  
    }else if(beatOn == true && beatY >= 585 - OKRANGE && beatY <= 685 && downPressed == true){
      hit.trigger();
      rateDisplay = okImg;
      rateDisplayTimer += 50;
      okCal++;
      beatOn = false;
     
    }else if(beatOn == true && downPressed == true && beatY > 545  && beatY < 580 || beatOn == true && downPressed == true && beatY > 738 ){
      rateDisplay = missImg;
      rateDisplayTimer += 50;
      miss.trigger();
      missCal++;
      beatOn = false;
    
    }
    break;
    
    case 4:
    
    if(beatOn == true && beatY >= 615 && beatY <= 650 && rightPressed == true){
      hit.trigger();
      rateDisplay = perfectImg;
      rateDisplayTimer += 50;
      perfectCal++;
      beatOn = false;
      
    }else if(beatOn == true && beatY >= 605 && beatY <= 665 && rightPressed == true){
      hit.trigger();
      rateDisplay = goodImg;
      rateDisplayTimer += 50;
      goodCal++;
      beatOn = false;
      
    }else if(beatOn == true && beatY >= 585 - OKRANGE && beatY <= 685 && rightPressed == true){
      hit.trigger();
      rateDisplay = okImg;
      rateDisplayTimer += 50;
      okCal++;
      beatOn = false;
      
    }else if(beatOn == true && rightPressed == true && beatY > 545  && beatY < 580 || beatOn == true && rightPressed == true && beatY > 738 ){
      rateDisplay = missImg;
      rateDisplayTimer += 50;
      miss.trigger();
      missCal++;
      beatOn = false;
      
    }
    break;
    }
  }
  
  void checkend(){
    if(beatY > height+10){
      rateDisplay = missImg;
      rateDisplayTimer += 50;
    miss.trigger();
    missCal++;
    beatY = -100;
    beatOn = false;}
  }
}