import ddf.minim.*;
Minim minim;
AudioPlayer song1,song2,song3,sadbgm,winSound,loseSound,allPass,bgm;
//
Minim sample;
AudioSample miss,clicked,hit;

int gameTimer = 0;
//float keyTimer;
boolean upPressed,downPressed,leftPressed,rightPressed,rainEffectControl;
PImage upEmptyDirect,leftEmptyDirect,downEmptyDirect,rightEmptyDirect,beatDisplay,track,lightPressed;
PImage opening,openingHover,
L1main,L1mainHover,L2main,L2mainEasyHover,L2mainNormalHover,L3main,L3mainEasyHover,L3mainNormalHover,L3mainHardHover,
game1sub,game1subHover,game2sub,game2subHover,game3sub,game3subHover ,  game1bg, game2bg, game3bg, gameEnd, gameEndHover,cloud,
tip, tipHover,
win,winHover, lose,loseHover;
PImage raineffectimg;
PImage [] doll;
PImage rateDisplay;

int rateDisplayTimer = 0;
int perfectCal = 0,goodCal = 0,okCal = 0,missCal = 0;
int score;

PFont font;
int gameState;
int initTime=165, decrease = 5;
int gameStateCheckPoint=0;
int modeCheckPoint=0;
int scriptTimer = 60;
int dollCal = 0;


//Class
Beat [] beat;


final int beatTotal=151;
final float LEFTWAY=0,UPWAY=1,DOWNWAY=2,RIGHTWAY=3;
final int HITRANGETOP=618,HITRANGEBOT=708,PERFECTRANGE=5, GOODRANGE=10, OKRANGE=20;
//final float KEYTIME = 60;
final int GAME_OPENING = 0,  GAME_TIPS = 3, GAME_WIN = 6, GAME_LOSE = 7;
final int  GAME1_MAIN = 11, GAME1_INSTRUCTION = 12, GAME1_RUN = 13, 
           GAME2_MAIN = 21, GAME2_INSTRUCTION = 22, GAME2EASY_RUN = 23, GAME2NORMAL_RUN = 24,
           GAME3_MAIN = 31, GAME3_INSTRUCTION = 32, GAME3EASY_RUN = 33, GAME3NORMAL_RUN = 34, GAME3HARD_RUN = 35,
           GAME_END = 41;

void setup(){
//background(255);  
size(1024,768,P2D); 
upEmptyDirect = loadImage("img/newemptyupDirect.png");
leftEmptyDirect = loadImage("img/newemptyleftDirect.png");
downEmptyDirect = loadImage("img/newemptydownDirect.png");
rightEmptyDirect = loadImage("img/newemptyrightDirect.png");
lightPressed = loadImage("img/pressedDirect1.png");
cloud = loadImage("img/cloud.png");
opening = loadImage("img/opening.png");
openingHover = loadImage("img/opening-hover.png");
L1main = loadImage("img/level1_main.png");
L1mainHover = loadImage("img/level1_mainHover.png");
L2main = loadImage("img/level2_main.png");
L2mainEasyHover = loadImage("img/level2_mainEasyHover.png");
L2mainNormalHover = loadImage("img/level2_mainNormalHover.png");
L3main = loadImage("img/level3_main.png");
L3mainEasyHover = loadImage("img/level3_mainEasyHover.png");
L3mainNormalHover = loadImage("img/level3_mainNormalHover.png");
L3mainHardHover = loadImage("img/level3_mainHardHover.png");
game1sub = loadImage("img/game1sub.png");
game1subHover = loadImage("img/game1subHover.png");
game2sub = loadImage("img/game2sub.png");
game2subHover = loadImage("img/game2subHover.png");
game3sub = loadImage("img/game3sub.png");
game3subHover = loadImage("img/game3subHover.png");
game1bg = loadImage("img/game1run.png");
game2bg = loadImage("img/game2run.png");
game3bg = loadImage("img/game3run.png");
gameEnd = loadImage("img/end.png");
gameEndHover = loadImage("img/endHover.png");
//
tip = loadImage("img/tips.png");
tipHover = loadImage("img/tipsHover.png");
//
win = loadImage("img/win.png");
lose = loadImage("img/lose.png");
winHover = loadImage("img/winHover.png");
loseHover = loadImage("img/loseHover.png");
track = loadImage("img/track.png");

//raineffect
raineffectimg = loadImage("img/game1run.png");
rainEffectControl = false;

//doll
doll = new PImage [10];
for(int i = 0; i<10; i++){
 doll[i] = loadImage("img/doll" + i + ".png"); 
}

//font
font = createFont("font/HanziPen_TC.otf",56);
textFont(font);

frameRate(60);

beat = new Beat[beatTotal];
for(int i = 0; i < beat.length; i++){
  beat[i] = new Beat();
  } //<>//
  
  minim = new Minim(this);
song1 = minim.loadFile("easy.wav");
song2 = minim.loadFile("tsukitoookami.wav");
song3 = minim.loadFile("Shining star.wav");
sadbgm = minim.loadFile("BGM.mp3");
winSound = minim.loadFile("winSound.mp3");
loseSound = minim.loadFile("loseSound.mp3");
allPass = minim.loadFile("allpass.mp3");
bgm = sadbgm;
//
  sample = new Minim(this);
  miss = sample.loadSample("miss.mp3",512);
  clicked = sample.loadSample("clicked.mp3",512);
  hit = sample.loadSample("clap.wav");

  
}

void draw(){
score = 300*perfectCal+200*goodCal+100*okCal+0*missCal;
String  scoreString = str(score);
String  perfectCalString = str(perfectCal);
String  goodCalString = str(goodCal);
String  okCalString = str(okCal);
String  missCalString = str(missCal);
if(rateDisplayTimer > 50){rateDisplayTimer = 50;}
if(rateDisplayTimer < 0){rateDisplayTimer = 0;}


//
int pointillize = missCal*3;
  int x = int(random(raineffectimg.width));
  int y = int(random(raineffectimg.height));
  int loc = x + y*raineffectimg.width;
  
  loadPixels();
  float r = red(raineffectimg.pixels[loc]);
  float g = green(raineffectimg.pixels[loc]);
  float b = blue(raineffectimg.pixels[loc]);
  noStroke();
 
  fill(r,g,b);
//


switch(gameState){
  case GAME_OPENING:  
  bgm.play();
  image(opening,0,0);
  if(mouseX >= 435 && mouseX <= 565 && mouseY >= 535 && mouseY <= 585){
    image(openingHover,0,0);
    if(mousePressed){
      clicked.trigger();
   gameState = 12; 
  }
  }  
  break;
  
  
  case GAME1_INSTRUCTION:
  image(game1sub,0,0);
  if(mouseX >= 425 && mouseX <= 555 && mouseY >= 665 && mouseY <= 715){
    image(game1subHover,0,0);
    if(mousePressed){
      clicked.trigger();
    gameState = 11;    
    }
  }
  break;
  
  
  
  case GAME1_MAIN:
  song1.pause();
  song2.pause();
  song3.pause();
  scriptTimer--;
  gameStateCheckPoint = GAME1_MAIN;
  image(L1main,0,0);
  if(scriptTimer <= 0){scriptTimer = 0;}
  //doll
  displayDoll();
  
  if(mouseX >= 850 && mouseX <= 980 && mouseY >= 415 && mouseY <= 465){
    image(L1mainHover,0,0);
    
      //doll
  displayDoll();
    
    if(mousePressed && scriptTimer <=0){
      clicked.trigger();
    modeCheckPoint = 2;
    scriptTimer = 60;
    gameState =3;   
   
    }
  }
    
  break;
  

    
  case GAME1_RUN:  
  gameTimer++;  
  song1.play();
  image(track,0,0);
  image(cloud,0,0);  
  rateDisplayTimer--;
  if(rateDisplayTimer >0){image(rateDisplay,100,500);}
    
  
    
//map    
  beat[0].gameTimer(initTime); beat[0].move();  beat[0].display(2); beat[0].checkend();  beat[0].isHit(2); 
  beat[1].gameTimer(initTime+85); beat[1].move();  beat[1].display(1); beat[1].checkend();  beat[1].isHit(1); 
  beat[2].gameTimer(initTime+85); beat[2].move();  beat[2].display(4); beat[2].checkend();  beat[2].isHit(4);  
  beat[3].gameTimer(initTime+215); beat[3].move();  beat[3].display(1); beat[3].checkend();  beat[3].isHit(1); 
  beat[4].gameTimer(initTime+255); beat[4].move();  beat[4].display(2);  beat[4].checkend();  beat[4].isHit(2);
  
  beat[5].gameTimer(initTime+325); beat[5].move();  beat[5].display(4); beat[5].checkend();  beat[5].isHit(4);
  beat[6].gameTimer(initTime+375); beat[6].move();  beat[6].display(2); beat[6].checkend();  beat[6].isHit(2);
  beat[7].gameTimer(initTime+415); beat[7].move();  beat[7].display(3); beat[7].checkend();  beat[7].isHit(3);
  beat[8].gameTimer(initTime+450); beat[8].move();  beat[8].display(1); beat[8].checkend();  beat[8].isHit(1);
  beat[9].gameTimer(initTime+495); beat[9].move();  beat[9].display(2); beat[9].checkend();beat[9].isHit(2);
  beat[10].gameTimer(initTime+540); beat[10].move();  beat[10].display(3); beat[10].checkend();  beat[10].isHit(3);
  beat[11].gameTimer(initTime+575); beat[11].move();  beat[11].display(4); beat[11].checkend();  beat[11].isHit(4);
  
  beat[12].gameTimer(initTime+665); beat[12].move();  beat[12].display(1); beat[12].checkend();  beat[12].isHit(1);
  beat[13].gameTimer(initTime+665); beat[13].move();  beat[13].display(2); beat[13].checkend();beat[13].isHit(2);
  beat[14].gameTimer(initTime+695); beat[14].move();  beat[14].display(3); beat[14].checkend();  beat[14].isHit(3);
  beat[15].gameTimer(initTime+750); beat[15].move();  beat[15].display(2); beat[15].checkend();beat[15].isHit(2);
  beat[16].gameTimer(initTime+785); beat[16].move();  beat[16].display(4); beat[16].checkend();  beat[16].isHit(4);
  beat[17].gameTimer(initTime+820); beat[17].move();  beat[17].display(1); beat[17].checkend();beat[17].isHit(1);
  beat[18].gameTimer(initTime+860); beat[18].move();  beat[18].display(2); beat[18].checkend();  beat[18].isHit(2);
  beat[19].gameTimer(initTime+900); beat[19].move();  beat[19].display(1); beat[19].checkend();  beat[19].isHit(1);
  beat[20].gameTimer(initTime+900); beat[20].move();  beat[20].display(4); beat[20].checkend();  beat[20].isHit(4);
 
  beat[21].gameTimer(initTime+990); beat[21].move(); beat[21].display(3); beat[21].checkend();beat[21].isHit(3);
  beat[22].gameTimer(initTime+1075); beat[22].move(); beat[22].display(3); beat[22].checkend();  beat[22].isHit(3);
  beat[23].gameTimer(initTime+1145); beat[23].move(); beat[23].display(1); beat[23].checkend();  beat[23].isHit(1);
  beat[24].gameTimer(initTime+1185); beat[24].move(); beat[24].display(4); beat[24].checkend();  beat[24].isHit(4);
  beat[25].gameTimer(initTime+1235); beat[25].move(); beat[25].display(3); beat[25].checkend();  beat[25].isHit(3);
  
  beat[26].gameTimer(initTime+1315); beat[26].move(); beat[26].display(4); beat[26].checkend();  beat[26].isHit(4);
  beat[27].gameTimer(initTime+1405); beat[27].move(); beat[27].display(2); beat[27].checkend();  beat[27].isHit(2);
  beat[28].gameTimer(initTime+1480); beat[28].move(); beat[28].display(1); beat[28].checkend();  beat[28].isHit(1);
  beat[29].gameTimer(initTime+1500); beat[29].move(); beat[29].display(2); beat[29].checkend();  beat[29].isHit(2);
  beat[30].gameTimer(initTime+1520); beat[30].move(); beat[30].display(3); beat[30].checkend();  beat[30].isHit(3);
  
  beat[31].gameTimer(initTime+1640); beat[31].move(); beat[31].display(1); beat[31].checkend();  beat[31].isHit(1);
  beat[32].gameTimer(initTime+1640); beat[32].move(); beat[32].display(4); beat[32].checkend();  beat[32].isHit(4);
  beat[33].gameTimer(initTime+1690); beat[33].move(); beat[33].display(2); beat[33].checkend();  beat[33].isHit(2);
  beat[34].gameTimer(initTime+1730); beat[34].move(); beat[34].display(3); beat[34].checkend();  beat[34].isHit(3);
  beat[35].gameTimer(initTime+1765); beat[35].move(); beat[35].display(1); beat[35].checkend();  beat[35].isHit(1);
  beat[36].gameTimer(initTime+1810); beat[36].move(); beat[36].display(2); beat[36].checkend();  beat[36].isHit(2);
  beat[37].gameTimer(initTime+1850); beat[37].move(); beat[37].display(3); beat[37].checkend();  beat[37].isHit(3);
  beat[38].gameTimer(initTime+1885); beat[38].move(); beat[38].display(4); beat[38].checkend();  beat[38].isHit(4);
  
  beat[39].gameTimer(initTime+1930); beat[39].move(); beat[39].display(1); beat[39].checkend();  beat[39].isHit(1);
  beat[40].gameTimer(initTime+1930); beat[40].move(); beat[40].display(3); beat[40].checkend();  beat[40].isHit(3);
  beat[41].gameTimer(initTime+1975); beat[41].move(); beat[41].display(2); beat[41].checkend();  beat[41].isHit(2);
  beat[42].gameTimer(initTime+1975); beat[42].move(); beat[42].display(4); beat[42].checkend();  beat[42].isHit(4);
  beat[43].gameTimer(initTime+2015); beat[43].move(); beat[43].display(1); beat[43].checkend();  beat[43].isHit(1);
  beat[44].gameTimer(initTime+2055); beat[44].move(); beat[44].display(3); beat[44].checkend();  beat[44].isHit(3);
  beat[45].gameTimer(initTime+2095); beat[45].move(); beat[45].display(4); beat[45].checkend();  beat[45].isHit(4);
  beat[46].gameTimer(initTime+2135); beat[46].move(); beat[46].display(1); beat[46].checkend();  beat[46].isHit(1);
  beat[47].gameTimer(initTime+2185); beat[47].move(); beat[47].display(3); beat[47].checkend();  beat[47].isHit(3);
  beat[48].gameTimer(initTime+2195); beat[48].move(); beat[48].display(4); beat[48].checkend();  beat[48].isHit(4);
 
  beat[49].gameTimer(initTime+2300); beat[49].move(); beat[49].display(1); beat[49].checkend();  beat[49].isHit(1);
  beat[50].gameTimer(initTime+2385); beat[50].move(); beat[50].display(3); beat[50].checkend();  beat[50].isHit(3);
  beat[51].gameTimer(initTime+2470); beat[51].move(); beat[51].display(2); beat[51].checkend();  beat[51].isHit(2);
  beat[52].gameTimer(initTime+2505); beat[52].move(); beat[52].display(3); beat[52].checkend();  beat[52].isHit(3);
  beat[53].gameTimer(initTime+2550); beat[53].move(); beat[53].display(4); beat[53].checkend();  beat[53].isHit(4);
  
  beat[54].gameTimer(initTime+2640); beat[54].move(); beat[54].display(1); beat[54].checkend();  beat[54].isHit(1);   
  beat[55].gameTimer(initTime+2640); beat[55].move(); beat[55].display(3); beat[55].checkend();  beat[55].isHit(3);
  beat[56].gameTimer(initTime+2710); beat[56].move(); beat[56].display(2); beat[56].checkend();  beat[56].isHit(2);
  beat[57].gameTimer(initTime+2800); beat[57].move(); beat[57].display(3); beat[57].checkend();  beat[57].isHit(3);
  beat[58].gameTimer(initTime+2800); beat[58].move(); beat[58].display(4); beat[58].checkend();  beat[58].isHit(4);
  beat[59].gameTimer(initTime+2880); beat[59].move(); beat[59].display(1); beat[59].checkend();  beat[59].isHit(1);
  beat[60].gameTimer(initTime+2920); beat[60].move(); beat[60].display(3); beat[60].checkend();  beat[60].isHit(3);
  beat[61].gameTimer(initTime+2940); beat[61].move(); beat[61].display(4); beat[61].checkend();  beat[61].isHit(4);
  
  beat[62].gameTimer(initTime+3040); beat[62].move(); beat[62].display(3); beat[62].checkend();  beat[62].isHit(3);
  beat[63].gameTimer(initTime+3060); beat[63].move(); beat[63].display(1); beat[63].checkend();  beat[63].isHit(1);
  beat[64].gameTimer(initTime+3060); beat[64].move(); beat[64].display(4); beat[64].checkend();  beat[64].isHit(4);
  
  beat[65].gameTimer(initTime+3140); beat[65].move(); beat[65].display(2); beat[65].checkend();  beat[65].isHit(2);
  beat[66].gameTimer(initTime+3160); beat[66].move(); beat[66].display(4); beat[66].checkend();  beat[66].isHit(4);
  beat[67].gameTimer(initTime+3185); beat[67].move(); beat[67].display(2); beat[67].checkend();  beat[67].isHit(2);
  beat[68].gameTimer(initTime+3205); beat[68].move(); beat[68].display(1); beat[68].checkend();  beat[68].isHit(1);
  beat[69].gameTimer(initTime+3225); beat[69].move(); beat[69].display(3); beat[69].checkend();  beat[69].isHit(3);
  beat[70].gameTimer(initTime+3245); beat[70].move(); beat[70].display(1); beat[70].checkend();  beat[70].isHit(1);
  beat[71].gameTimer(initTime+3265); beat[71].move(); beat[71].display(3); beat[71].checkend();  beat[71].isHit(3);
  beat[72].gameTimer(initTime+3285); beat[72].move(); beat[72].display(4); beat[72].checkend();  beat[72].isHit(4);
 
  beat[73].gameTimer(initTime+3370); beat[73].move(); beat[73].display(3); beat[73].checkend();  beat[73].isHit(3);
  beat[74].gameTimer(initTime+3405); beat[74].move(); beat[74].display(1); beat[74].checkend();  beat[74].isHit(1);
  beat[75].gameTimer(initTime+3450); beat[75].move(); beat[75].display(3); beat[75].checkend();  beat[75].isHit(3);
  beat[76].gameTimer(initTime+3490); beat[76].move(); beat[76].display(4); beat[76].checkend();  beat[76].isHit(4);
  beat[77].gameTimer(initTime+3530); beat[77].move(); beat[77].display(2); beat[77].checkend();  beat[77].isHit(2);
  beat[78].gameTimer(initTime+3575); beat[78].move(); beat[78].display(1); beat[78].checkend();  beat[78].isHit(1);
  beat[79].gameTimer(initTime+3595); beat[79].move(); beat[79].display(3); beat[79].checkend();  beat[79].isHit(3);
  beat[80].gameTimer(initTime+3620); beat[80].move(); beat[80].display(2); beat[80].checkend();  beat[80].isHit(2);
  
  beat[81].gameTimer(initTime+3690); beat[81].move(); beat[81].display(3); beat[81].checkend();  beat[81].isHit(3);
  beat[82].gameTimer(initTime+3710); beat[82].move(); beat[82].display(4); beat[82].checkend();  beat[82].isHit(4);
  beat[83].gameTimer(initTime+3780); beat[83].move(); beat[83].display(1); beat[83].checkend();  beat[83].isHit(1);
  beat[84].gameTimer(initTime+3865); beat[84].move(); beat[84].display(3); beat[84].checkend();  beat[84].isHit(3);
  beat[85].gameTimer(initTime+3945); beat[85].move(); beat[85].display(2); beat[85].checkend();  beat[85].isHit(2);
  beat[86].gameTimer(initTime+3985); beat[86].move(); beat[86].display(1); beat[86].checkend();  beat[86].isHit(1);
  
  beat[87].gameTimer(initTime+4030); beat[87].move(); beat[87].display(2); beat[87].checkend();  beat[87].isHit(2);
  beat[88].gameTimer(initTime+4055); beat[88].move(); beat[88].display(1); beat[88].checkend();  beat[88].isHit(1);
  beat[89].gameTimer(initTime+4080); beat[89].move(); beat[89].display(3); beat[89].checkend();  beat[89].isHit(3);
  beat[90].gameTimer(initTime+4115); beat[90].move(); beat[90].display(1); beat[90].checkend();  beat[90].isHit(1);
  beat[91].gameTimer(initTime+4135); beat[91].move(); beat[91].display(4); beat[91].checkend();  beat[91].isHit(4);
  beat[92].gameTimer(initTime+4165); beat[92].move(); beat[92].display(3); beat[92].checkend();  beat[92].isHit(3);
  beat[93].gameTimer(initTime+4195); beat[93].move(); beat[93].display(1); beat[93].checkend();  beat[93].isHit(1);
  beat[94].gameTimer(initTime+4235); beat[94].move(); beat[94].display(2); beat[94].checkend();  beat[94].isHit(2);
  beat[95].gameTimer(initTime+4270); beat[95].move(); beat[95].display(4); beat[95].checkend();  beat[95].isHit(4);
  beat[96].gameTimer(initTime+4290); beat[96].move(); beat[96].display(2); beat[96].checkend();  beat[96].isHit(2);
  beat[97].gameTimer(initTime+4310); beat[97].move(); beat[97].display(3); beat[97].checkend();  beat[97].isHit(3);
 
  beat[98].gameTimer(initTime+4350); beat[98].move(); beat[98].display(1); beat[98].checkend();  beat[98].isHit(1);
  beat[99].gameTimer(initTime+4370); beat[99].move(); beat[99].display(2); beat[99].checkend();  beat[99].isHit(2);
  beat[100].gameTimer(initTime+4370); beat[100].move(); beat[100].display(4); beat[100].checkend();  beat[100].isHit(4);
  
  beat[101].gameTimer(initTime+4450); beat[101].move(); beat[101].display(3); beat[101].checkend();  beat[101].isHit(3);
  beat[102].gameTimer(initTime+4470); beat[102].move(); beat[102].display(4); beat[102].checkend();  beat[102].isHit(4);
  beat[103].gameTimer(initTime+4495); beat[103].move(); beat[103].display(3); beat[103].checkend();  beat[103].isHit(3);
  beat[104].gameTimer(initTime+4515); beat[104].move(); beat[104].display(1); beat[104].checkend();  beat[104].isHit(1);
  beat[105].gameTimer(initTime+4535); beat[105].move(); beat[105].display(2); beat[105].checkend();  beat[105].isHit(2);
  beat[106].gameTimer(initTime+4555); beat[106].move(); beat[106].display(1); beat[106].checkend();  beat[106].isHit(1);
  beat[107].gameTimer(initTime+4575); beat[107].move(); beat[107].display(3); beat[107].checkend();  beat[107].isHit(3);
  beat[108].gameTimer(initTime+4595); beat[108].move(); beat[108].display(4); beat[108].checkend();  beat[108].isHit(4);
 
  beat[109].gameTimer(initTime+4680); beat[109].move(); beat[109].display(3); beat[109].checkend();  beat[109].isHit(3);
  beat[110].gameTimer(initTime+4715); beat[110].move(); beat[110].display(1); beat[110].checkend();  beat[110].isHit(1);
  beat[111].gameTimer(initTime+4760); beat[111].move(); beat[111].display(4); beat[111].checkend();  beat[111].isHit(4);
  beat[112].gameTimer(initTime+4800); beat[112].move(); beat[112].display(2); beat[112].checkend();  beat[112].isHit(2);
  beat[113].gameTimer(initTime+4840); beat[113].move(); beat[113].display(4); beat[113].checkend();  beat[113].isHit(4);
  beat[114].gameTimer(initTime+4885); beat[114].move(); beat[114].display(3); beat[114].checkend();  beat[114].isHit(3);
  beat[115].gameTimer(initTime+4910); beat[115].move(); beat[115].display(1); beat[115].checkend();  beat[115].isHit(1);
  beat[116].gameTimer(initTime+4930); beat[116].move(); beat[116].display(2); beat[116].checkend();  beat[116].isHit(2);
 
  beat[117].gameTimer(initTime+5000); beat[117].move(); beat[117].display(1); beat[117].checkend();  beat[117].isHit(1);
  beat[118].gameTimer(initTime+5020); beat[118].move(); beat[118].display(2); beat[118].checkend();  beat[118].isHit(2);
  beat[119].gameTimer(initTime+5090); beat[119].move(); beat[119].display(3); beat[119].checkend();  beat[119].isHit(3);
  beat[120].gameTimer(initTime+5175); beat[120].move(); beat[120].display(1); beat[120].checkend();  beat[120].isHit(1);
  beat[121].gameTimer(initTime+5255); beat[121].move(); beat[121].display(2); beat[121].checkend();  beat[121].isHit(2);
  beat[122].gameTimer(initTime+5295); beat[122].move(); beat[122].display(4); beat[122].checkend();  beat[122].isHit(4);
  
  beat[123].gameTimer(initTime+5355); beat[123].move(); beat[123].display(3); beat[123].checkend();  beat[123].isHit(3);
  beat[124].gameTimer(initTime+5375); beat[124].move(); beat[124].display(2); beat[124].checkend();  beat[124].isHit(2);
  beat[125].gameTimer(initTime+5410); beat[125].move(); beat[125].display(4); beat[125].checkend();  beat[125].isHit(4);
  beat[126].gameTimer(initTime+5445); beat[126].move(); beat[126].display(1); beat[126].checkend();  beat[126].isHit(1);
  beat[127].gameTimer(initTime+5480); beat[127].move(); beat[127].display(3); beat[127].checkend();  beat[127].isHit(3);
  beat[128].gameTimer(initTime+5500); beat[128].move(); beat[128].display(4); beat[128].checkend();  beat[128].isHit(4);
  
  beat[129].gameTimer(initTime+5585); beat[129].move(); beat[129].display(1); beat[129].checkend();  beat[129].isHit(1);
  beat[130].gameTimer(initTime+5610); beat[130].move(); beat[130].display(4); beat[130].checkend();  beat[130].isHit(4);
  beat[131].gameTimer(initTime+5640); beat[131].move(); beat[131].display(2); beat[131].checkend();  beat[131].isHit(2);
  beat[132].gameTimer(initTime+5665); beat[132].move(); beat[132].display(1); beat[132].checkend();  beat[132].isHit(1);
  
  beat[133].gameTimer(initTime+5745); beat[133].move(); beat[133].display(3); beat[133].checkend();  beat[133].isHit(3);
  beat[134].gameTimer(initTime+5785); beat[134].move(); beat[134].display(4); beat[134].checkend();  beat[134].isHit(4);
  beat[135].gameTimer(initTime+5830); beat[135].move(); beat[135].display(2); beat[135].checkend();  beat[135].isHit(2);
  
  beat[136].gameTimer(initTime+5905); beat[136].move(); beat[136].display(1); beat[136].checkend();  beat[136].isHit(1);
  beat[137].gameTimer(initTime+5940); beat[137].move(); beat[137].display(2); beat[137].checkend();  beat[137].isHit(2);
  beat[138].gameTimer(initTime+5970); beat[138].move(); beat[138].display(3); beat[138].checkend();  beat[138].isHit(3);
  beat[139].gameTimer(initTime+5995); beat[139].move(); beat[139].display(1); beat[139].checkend();  beat[139].isHit(1);
  beat[140].gameTimer(initTime+5995); beat[140].move(); beat[140].display(4); beat[140].checkend();  beat[140].isHit(4);

  beat[141].gameTimer(initTime+6155); beat[141].move(); beat[141].display(3); beat[141].checkend();  beat[141].isHit(3);
  beat[142].gameTimer(initTime+6235); beat[142].move(); beat[142].display(2); beat[142].checkend();  beat[142].isHit(2);
  beat[143].gameTimer(initTime+6235); beat[143].move(); beat[143].display(4); beat[143].checkend();  beat[143].isHit(4);
  beat[144].gameTimer(initTime+6320); beat[144].move(); beat[144].display(3); beat[144].checkend();  beat[144].isHit(3);
  beat[145].gameTimer(initTime+6400); beat[145].move(); beat[145].display(1); beat[145].checkend();  beat[145].isHit(1);
  beat[146].gameTimer(initTime+6400); beat[146].move(); beat[146].display(4); beat[146].checkend();  beat[146].isHit(4);
  beat[147].gameTimer(initTime+6485); beat[147].move(); beat[147].display(4); beat[147].checkend();  beat[147].isHit(4);
  beat[148].gameTimer(initTime+6565); beat[148].move(); beat[148].display(1); beat[148].checkend();  beat[148].isHit(1);
  beat[149].gameTimer(initTime+6565); beat[149].move(); beat[149].display(2); beat[149].checkend();  beat[149].isHit(2);
  beat[150].gameTimer(initTime+6665); beat[150].move(); beat[150].display(3); beat[150].checkend();  beat[150].isHit(3);
//switch to win or lose
  if(gameTimer == initTime+7240){
     gameTimer += 0;
     if(score >= 35000){
       gameState = 6; 
     }else{
       gameState = 7;
    }
  }
    //<>//
//raineffect 
if(rainEffectControl){  ellipse(x,y,pointillize,pointillize);}
   
//pressedDisplay
pressedDisplay();

//score
fill(0);
text(scoreString,635,110);
text(missCalString,910,110);

break;

//game2
  case GAME2_MAIN:
  song1.pause();
  song2.pause();
  song3.pause();
  bgm.play();
  scriptTimer--;
  gameStateCheckPoint = GAME2_MAIN;
  image(L2main,0,0);
  if(scriptTimer <= 0){scriptTimer = 0;}
  //doll
displayDoll();
  
  if(mouseX >= 850 && mouseX <= 980 && mouseY >= 292 && mouseY <= 342 && scriptTimer <= 0){
    image(L2mainEasyHover,0,0);
    
      //doll
displayDoll();
    
    if(mousePressed){
      clicked.trigger();
    modeCheckPoint = 2;
    scriptTimer = 60;
    gameState = 22;}    
  }else if(mouseX >= 850 && mouseX <= 980 && mouseY >= 415 && mouseY <= 465 && scriptTimer <= 0){
    image(L2mainNormalHover,0,0);
    
      //doll
  displayDoll();
    
    if(mousePressed){
      clicked.trigger();
      modeCheckPoint = 3;
      scriptTimer = 60;
    gameState = 22;}   
  }
  
  break;
  
  case GAME2_INSTRUCTION:
  image(game2sub,0,0);
  if(mouseX >= 425 && mouseX <= 555 && mouseY >= 665 && mouseY <= 715){
    image(game2subHover,0,0);
    if(mousePressed){
      clicked.trigger();
      
    raineffectimg = loadImage("img/game2run.png");
    gameState = 3;
    }
  }
  break;
  
  case GAME2EASY_RUN:  
   gameTimer++;
   song2.play(); 
  image(track,0,0);
  image(cloud,0,0);
  
    rateDisplayTimer--;
  if(rateDisplayTimer >0){image(rateDisplay,100,500);}
  
  
   
//map    
beat[0].gameTimer(340); beat[0].move();  beat[0].display(2);  beat[0].checkend();  beat[0].isHit(2); 
  beat[1].gameTimer(455); beat[1].move();  beat[1].display(3);  beat[1].checkend();  beat[1].isHit(3); 
  beat[2].gameTimer(570); beat[2].move();  beat[2].display(4);  beat[2].checkend();  beat[2].isHit(4);  
  beat[3].gameTimer(685); beat[3].move();  beat[3].display(1);  beat[3].checkend();  beat[3].isHit(1); 
  beat[4].gameTimer(800); beat[4].move();  beat[4].display(2);  beat[4].checkend();  beat[4].isHit(2);
  beat[5].gameTimer(915); beat[5].move();  beat[5].display(3);  beat[5].checkend();  beat[5].isHit(3);
  beat[6].gameTimer(1045); beat[6].move();  beat[6].display(1); beat[6].checkend();  beat[6].isHit(1);
  beat[7].gameTimer(1190); beat[7].move();  beat[7].display(2); beat[7].checkend();  beat[7].isHit(2);
  beat[117].gameTimer(1190); beat[117].move(); beat[117].display(4);  beat[117].checkend();  beat[117].isHit(4); 
  beat[118].gameTimer(1190); beat[118].move(); beat[118].display(1);  beat[118].checkend();  beat[118].isHit(1);
  //second
  beat[8].gameTimer(1461); beat[8].move(); beat[8].display(2);  beat[8].checkend();  beat[8].isHit(2);
  beat[9].gameTimer(1521); beat[9].move(); beat[9].display(4);  beat[9].checkend();beat[9].isHit(4);
  beat[10].gameTimer(1580); beat[10].move(); beat[10].display(3);  beat[10].checkend();  beat[10].isHit(3);
  beat[11].gameTimer(1637); beat[11].move(); beat[11].display(3);  beat[11].checkend();  beat[11].isHit(3);
  beat[12].gameTimer(1694); beat[12].move(); beat[12].display(4);  beat[12].checkend();  beat[12].isHit(4);
  beat[13].gameTimer(1750); beat[13].move(); beat[13].display(2);  beat[13].checkend();beat[13].isHit(2);
  beat[14].gameTimer(1808); beat[14].move(); beat[14].display(1);  beat[14].checkend();  beat[14].isHit(1);
  beat[15].gameTimer(1837); beat[15].move(); beat[15].display(4);  beat[15].checkend();beat[15].isHit(4);
  beat[16].gameTimer(1865); beat[16].move(); beat[16].display(2);  beat[16].checkend();  beat[16].isHit(2);
  //third
  beat[17].gameTimer(1926); beat[17].move(); beat[17].display(3);  beat[17].checkend();beat[17].isHit(3);
  beat[18].gameTimer(1981); beat[18].move(); beat[18].display(4);  beat[18].checkend();  beat[18].isHit(4);
  beat[19].gameTimer(2038); beat[19].move(); beat[19].display(1);  beat[19].checkend();  beat[19].isHit(1);
  beat[20].gameTimer(2067); beat[20].move(); beat[20].display(2);  beat[20].checkend();  beat[20].isHit(2);
  beat[21].gameTimer(2096); beat[21].move(); beat[21].display(3);  beat[21].checkend();beat[21].isHit(3);
  beat[22].gameTimer(2155); beat[22].move(); beat[22].display(4);  beat[22].checkend();  beat[22].isHit(4);
  beat[23].gameTimer(2209); beat[23].move(); beat[23].display(1);  beat[23].checkend();  beat[23].isHit(1);
  beat[24].gameTimer(2266); beat[24].move(); beat[24].display(2);  beat[24].checkend();  beat[24].isHit(2);
  beat[25].gameTimer(2295); beat[25].move(); beat[25].display(3);  beat[25].checkend();beat[25].isHit(3);
  beat[26].gameTimer(2323); beat[26].move(); beat[26].display(4);  beat[26].checkend();  beat[26].isHit(4);
  beat[119].gameTimer(2323); beat[119].move(); beat[119].display(2);  beat[119].checkend();  beat[119].isHit(2); 
  //fourth
  beat[27].gameTimer(2375); beat[27].move(); beat[27].display(3);  beat[27].checkend();  beat[27].isHit(3);
  beat[28].gameTimer(2433); beat[28].move(); beat[28].display(1);  beat[28].checkend();  beat[28].isHit(1);
  beat[29].gameTimer(2488); beat[29].move(); beat[29].display(3);  beat[29].checkend();beat[29].isHit(3);
  beat[30].gameTimer(2517); beat[30].move(); beat[30].display(1);  beat[30].checkend();  beat[30].isHit(1);
  beat[31].gameTimer(2546); beat[31].move(); beat[31].display(2);  beat[31].checkend();  beat[31].isHit(2);
  beat[32].gameTimer(2604); beat[32].move(); beat[32].display(4);  beat[32].checkend();  beat[32].isHit(4);
  beat[33].gameTimer(2700); beat[33].move(); beat[33].display(1);  beat[33].checkend();beat[33].isHit(1);
  beat[34].gameTimer(2710); beat[34].move(); beat[34].display(3);  beat[34].checkend();  beat[34].isHit(3);
  beat[35].gameTimer(2747); beat[35].move(); beat[35].display(2);  beat[35].checkend();  beat[35].isHit(2);
  beat[36].gameTimer(2775); beat[36].move(); beat[36].display(4);  beat[36].checkend();  beat[36].isHit(4);
  beat[37].gameTimer(2831); beat[37].move(); beat[37].display(4);  beat[37].checkend();beat[37].isHit(4);
  beat[38].gameTimer(2859); beat[38].move(); beat[38].display(2);  beat[38].checkend();  beat[38].isHit(2);
  beat[39].gameTimer(2889); beat[39].move(); beat[39].display(1);  beat[39].checkend();  beat[39].isHit(1);
  beat[40].gameTimer(2945); beat[40].move(); beat[40].display(1);  beat[40].checkend();  beat[40].isHit(1);
  beat[41].gameTimer(2974); beat[41].move(); beat[41].display(2);  beat[41].checkend();beat[41].isHit(2);
  beat[43].gameTimer(3060); beat[43].move(); beat[43].display(4);  beat[43].checkend();  beat[43].isHit(4);
  beat[44].gameTimer(3102); beat[44].move(); beat[44].display(3);  beat[44].checkend();  beat[44].isHit(3);
  beat[120].gameTimer(3116); beat[120].move(); beat[120].display(2);  beat[120].checkend();  beat[120].isHit(2); 
  beat[45].gameTimer(3173); beat[45].move(); beat[45].display(4);  beat[45].checkend();beat[45].isHit(4);
  beat[46].gameTimer(3201); beat[46].move(); beat[46].display(1);  beat[46].checkend();  beat[46].isHit(1);
  beat[47].gameTimer(3230); beat[47].move(); beat[47].display(2);  beat[47].checkend();  beat[47].isHit(2); 
  //fifth
  beat[48].gameTimer(3294); beat[48].move(); beat[48].display(2);  beat[48].checkend();  beat[48].isHit(2);
  beat[121].gameTimer(3294); beat[121].move(); beat[121].display(3);  beat[121].checkend();  beat[121].isHit(3); 
  beat[49].gameTimer(3408); beat[49].move(); beat[49].display(1);  beat[49].checkend();  beat[49].isHit(1);
  beat[122].gameTimer(3408); beat[122].move(); beat[122].display(4);  beat[122].checkend();  beat[122].isHit(4); 
  beat[50].gameTimer(3522); beat[50].move(); beat[50].display(2);  beat[50].checkend();beat[50].isHit(2);
  beat[123].gameTimer(3562); beat[123].move(); beat[123].display(4);  beat[123].checkend();  beat[123].isHit(4); 
  beat[51].gameTimer(3578); beat[51].move(); beat[51].display(3);  beat[51].checkend();  beat[51].isHit(3);
  beat[52].gameTimer(3637); beat[52].move(); beat[52].display(2);  beat[52].checkend();  beat[52].isHit(2);
  //beat[53].gameTimer(3663); beat[53].move(); beat[53].display(2);  beat[53].checkend();  beat[53].isHit(2);
  beat[54].gameTimer(3693); beat[54].move(); beat[54].display(1);  beat[54].checkend();beat[54].isHit(1);
  beat[124].gameTimer(3693); beat[124].move(); beat[124].display(4);  beat[124].checkend();  beat[124].isHit(4); 
  beat[55].gameTimer(3752); beat[55].move(); beat[55].display(4);  beat[55].checkend();  beat[55].isHit(4);
  beat[56].gameTimer(3855); beat[56].move(); beat[56].display(1);  beat[56].checkend();  beat[56].isHit(1); 
  beat[125].gameTimer(3855); beat[125].move(); beat[125].display(3);  beat[125].checkend();  beat[125].isHit(3); 
  beat[57].gameTimer(3975); beat[57].move(); beat[57].display(2);  beat[57].checkend();  beat[57].isHit(2);
  beat[58].gameTimer(4032); beat[58].move(); beat[58].display(1);  beat[58].checkend();  beat[58].isHit(1);
  beat[59].gameTimer(4088); beat[59].move(); beat[59].display(1);  beat[59].checkend();beat[59].isHit(1);
  beat[61].gameTimer(4117); beat[61].move(); beat[61].display(4);  beat[61].checkend();  beat[61].isHit(4);
  beat[63].gameTimer(4144); beat[63].move(); beat[63].display(2);  beat[63].checkend();beat[63].isHit(2);
  //sixth
  beat[64].gameTimer(4197); beat[64].move(); beat[64].display(2);  beat[64].checkend();  beat[64].isHit(2);
  beat[126].gameTimer(4253); beat[126].move(); beat[126].display(1);  beat[126].checkend();  beat[126].isHit(1); 
  beat[65].gameTimer(4253); beat[65].move(); beat[65].display(3);  beat[65].checkend();  beat[65].isHit(3);  
  beat[66].gameTimer(4311); beat[66].move(); beat[66].display(1);  beat[66].checkend();  beat[66].isHit(1);
  beat[67].gameTimer(4331); beat[67].move(); beat[67].display(4);  beat[67].checkend();beat[67].isHit(4);
  beat[68].gameTimer(4353); beat[68].move(); beat[68].display(1);  beat[68].checkend();  beat[68].isHit(1);
  beat[69].gameTimer(4369); beat[69].move(); beat[69].display(4);  beat[69].checkend();  beat[69].isHit(4); 
  beat[70].gameTimer(4398); beat[70].move(); beat[70].display(2);  beat[70].checkend();  beat[70].isHit(2);
  beat[71].gameTimer(4427); beat[71].move(); beat[71].display(3);  beat[71].checkend();  beat[71].isHit(3);
  beat[127].gameTimer(4480); beat[127].move(); beat[127].display(4);  beat[127].checkend();  beat[127].isHit(4); 
  beat[72].gameTimer(4541); beat[72].move(); beat[72].display(1);  beat[72].checkend();beat[72].isHit(1);
  beat[73].gameTimer(4599); beat[73].move(); beat[73].display(1);  beat[73].checkend();  beat[73].isHit(1);
  beat[74].gameTimer(4628); beat[74].move(); beat[74].display(3);  beat[74].checkend();  beat[74].isHit(3);
  beat[128].gameTimer(4628); beat[128].move(); beat[128].display(4);  beat[128].checkend();  beat[128].isHit(4); 
  //beat[75].gameTimer(4655); beat[75].move(); beat[75].display(4);  beat[75].checkend();  beat[75].isHit(4);
  beat[76].gameTimer(4713); beat[76].move(); beat[76].display(1);  beat[76].checkend();beat[76].isHit(1);
  beat[77].gameTimer(4771); beat[77].move(); beat[77].display(1);  beat[77].checkend();  beat[77].isHit(1);
  beat[78].gameTimer(4799); beat[78].move(); beat[78].display(3);  beat[78].checkend();  beat[78].isHit(3); 
  beat[79].gameTimer(4828); beat[79].move(); beat[79].display(2);  beat[79].checkend();  beat[79].isHit(2);
  beat[80].gameTimer(4885); beat[80].move(); beat[80].display(2);  beat[80].checkend();  beat[80].isHit(2);
  beat[81].gameTimer(4939); beat[81].move(); beat[81].display(4);  beat[81].checkend();beat[81].isHit(4);
  beat[82].gameTimer(4998); beat[82].move(); beat[82].display(4);  beat[82].checkend();  beat[82].isHit(4);
  beat[83].gameTimer(5026); beat[83].move(); beat[83].display(1);  beat[83].checkend();  beat[83].isHit(1); 
  beat[84].gameTimer(5050); beat[84].move(); beat[84].display(3);  beat[84].checkend();  beat[84].isHit(3); 
  beat[129].gameTimer(5080); beat[129].move(); beat[129].display(2);  beat[129].checkend();  beat[129].isHit(2); 
  //Seventh 
  beat[86].gameTimer(5111); beat[86].move(); beat[86].display(1);  beat[86].checkend();  beat[86].isHit(1);
  beat[87].gameTimer(5141); beat[87].move(); beat[87].display(4);  beat[87].checkend();  beat[87].isHit(4); 
  beat[88].gameTimer(5168); beat[88].move(); beat[88].display(2);  beat[88].checkend();  beat[88].isHit(2);
  beat[89].gameTimer(5197); beat[89].move(); beat[89].display(1);  beat[89].checkend();  beat[89].isHit(1);
  beat[90].gameTimer(5226); beat[90].move(); beat[90].display(2);  beat[90].checkend();  beat[90].isHit(2);
  beat[91].gameTimer(5254); beat[91].move(); beat[91].display(3);  beat[91].checkend();  beat[91].isHit(3);
  beat[92].gameTimer(5283); beat[92].move(); beat[92].display(4);  beat[92].checkend();  beat[92].isHit(4); 
  //Eighth
  beat[93].gameTimer(5341); beat[93].move(); beat[93].display(1);  beat[93].checkend();  beat[93].isHit(1); 
  beat[94].gameTimer(5368); beat[94].move(); beat[94].display(2);  beat[94].checkend();  beat[94].isHit(2);
  beat[95].gameTimer(5398); beat[95].move(); beat[95].display(3);  beat[95].checkend();  beat[95].isHit(3);
  beat[96].gameTimer(5426); beat[96].move(); beat[96].display(4);  beat[96].checkend();  beat[96].isHit(4); 
  beat[97].gameTimer(5455); beat[97].move(); beat[97].display(2);  beat[97].checkend();  beat[97].isHit(2);
  beat[98].gameTimer(5483); beat[98].move(); beat[98].display(1);  beat[98].checkend();  beat[98].isHit(1);
  beat[99].gameTimer(5512); beat[99].move(); beat[99].display(2);  beat[99].checkend();  beat[99].isHit(2);
  beat[100].gameTimer(5541); beat[100].move(); beat[100].display(1);  beat[100].checkend();  beat[100].isHit(1);
  beat[101].gameTimer(5568); beat[101].move(); beat[101].display(2);  beat[101].checkend();  beat[101].isHit(2); 
  beat[102].gameTimer(5597); beat[102].move(); beat[102].display(4);  beat[102].checkend();  beat[102].isHit(4); 
  beat[104].gameTimer(5654); beat[104].move(); beat[104].display(3);  beat[104].checkend();  beat[104].isHit(3);
  beat[106].gameTimer(5710); beat[106].move(); beat[106].display(4);  beat[106].checkend();  beat[106].isHit(4);
  beat[107].gameTimer(5740); beat[107].move(); beat[107].display(1);  beat[107].checkend();  beat[107].isHit(1);
  //ninth
  beat[108].gameTimer(5798); beat[108].move(); beat[108].display(2);  beat[108].checkend();  beat[108].isHit(2);
  beat[109].gameTimer(5824); beat[109].move(); beat[109].display(3);  beat[109].checkend();  beat[109].isHit(3);
  beat[110].gameTimer(5847); beat[110].move(); beat[110].display(1);  beat[110].checkend();  beat[110].isHit(1); 
  beat[111].gameTimer(5860); beat[111].move(); beat[111].display(4);  beat[111].checkend();  beat[111].isHit(4); 
  beat[112].gameTimer(5874); beat[112].move(); beat[112].display(2);  beat[112].checkend();  beat[112].isHit(2);
  beat[113].gameTimer(5903); beat[113].move(); beat[113].display(3);  beat[113].checkend();  beat[113].isHit(3);
  beat[130].gameTimer(5932); beat[130].move(); beat[130].display(1);  beat[130].checkend();  beat[130].isHit(1); 
  beat[132].gameTimer(5956); beat[132].move(); beat[132].display(4);  beat[132].checkend();  beat[132].isHit(4); 
  beat[115].gameTimer(5985); beat[115].move(); beat[115].display(1);  beat[115].checkend();  beat[115].isHit(1);
  beat[116].gameTimer(5985); beat[116].move(); beat[116].display(3);  beat[116].checkend();  beat[116].isHit(3);

//switch to win or lose
  if(gameTimer == 6425){
     gameTimer += 0;
     if(missCal + okCal <= 5){
       gameState = 6; 
     }else{
       gameState = 7;
    }
  }
   
//raineffect 
  if(rainEffectControl){ellipse(x,y,pointillize,pointillize);}
   

//pressedDisplay
pressedDisplay();

//score

fill(0);
text(scoreString,635,110);
text(missCalString,910,110);

  break;

    case GAME2NORMAL_RUN:
    gameTimer++;
    song2.play();
  image(track,0,0);
  image(cloud,0,0);
  
    rateDisplayTimer--;
  if(rateDisplayTimer >0){image(rateDisplay,100,500);}
  
  
    
//map    
  beat[0].gameTimer(340); beat[0].move();  beat[0].display(6);  beat[0].checkend();  beat[0].isHit(3); 
  beat[1].gameTimer(455); beat[1].move();  beat[1].display(7);  beat[1].checkend();  beat[1].isHit(2); 
  beat[2].gameTimer(570); beat[2].move();  beat[2].display(8);  beat[2].checkend();  beat[2].isHit(1);  
  beat[3].gameTimer(685); beat[3].move();  beat[3].display(5);  beat[3].checkend();  beat[3].isHit(4); 
  beat[4].gameTimer(800); beat[4].move();  beat[4].display(6);  beat[4].checkend();  beat[4].isHit(3);
  beat[5].gameTimer(915); beat[5].move();  beat[5].display(7);  beat[5].checkend();  beat[5].isHit(2);
  beat[6].gameTimer(1045); beat[6].move();  beat[6].display(5); beat[6].checkend();  beat[6].isHit(4);
  beat[7].gameTimer(1190); beat[7].move();  beat[7].display(6); beat[7].checkend();  beat[7].isHit(3);
  beat[117].gameTimer(1190); beat[117].move(); beat[117].display(8);  beat[117].checkend();  beat[117].isHit(1); 
  beat[118].gameTimer(1190); beat[118].move(); beat[118].display(5);  beat[118].checkend();  beat[118].isHit(4);
  //second
  beat[8].gameTimer(1461); beat[8].move(); beat[8].display(6);  beat[8].checkend();  beat[8].isHit(3);
  beat[9].gameTimer(1521); beat[9].move(); beat[9].display(8);  beat[9].checkend();beat[9].isHit(1);
  beat[10].gameTimer(1580); beat[10].move(); beat[10].display(7);  beat[10].checkend();  beat[10].isHit(2);
  beat[11].gameTimer(1637); beat[11].move(); beat[11].display(7);  beat[11].checkend();  beat[11].isHit(2);
  beat[12].gameTimer(1694); beat[12].move(); beat[12].display(8);  beat[12].checkend();  beat[12].isHit(1);
  beat[13].gameTimer(1750); beat[13].move(); beat[13].display(6);  beat[13].checkend();beat[13].isHit(3);
  beat[14].gameTimer(1808); beat[14].move(); beat[14].display(5);  beat[14].checkend();  beat[14].isHit(4);
  beat[15].gameTimer(1837); beat[15].move(); beat[15].display(8);  beat[15].checkend();beat[15].isHit(1);
  beat[16].gameTimer(1865); beat[16].move(); beat[16].display(6);  beat[16].checkend();  beat[16].isHit(3);
  //third
  beat[17].gameTimer(1926); beat[17].move(); beat[17].display(7);  beat[17].checkend();beat[17].isHit(2);
  beat[18].gameTimer(1981); beat[18].move(); beat[18].display(8);  beat[18].checkend();  beat[18].isHit(1);
  beat[19].gameTimer(2038); beat[19].move(); beat[19].display(5);  beat[19].checkend();  beat[19].isHit(4);
  beat[20].gameTimer(2067); beat[20].move(); beat[20].display(6);  beat[20].checkend();  beat[20].isHit(3);
  beat[21].gameTimer(2096); beat[21].move(); beat[21].display(7);  beat[21].checkend();beat[21].isHit(2);
  beat[22].gameTimer(2155); beat[22].move(); beat[22].display(8);  beat[22].checkend();  beat[22].isHit(1);
  beat[23].gameTimer(2209); beat[23].move(); beat[23].display(5);  beat[23].checkend();  beat[23].isHit(4);
  beat[24].gameTimer(2266); beat[24].move(); beat[24].display(6);  beat[24].checkend();  beat[24].isHit(3);
  beat[25].gameTimer(2295); beat[25].move(); beat[25].display(7);  beat[25].checkend();beat[25].isHit(2);
  beat[26].gameTimer(2323); beat[26].move(); beat[26].display(8);  beat[26].checkend();  beat[26].isHit(1);
  beat[119].gameTimer(2323); beat[119].move(); beat[119].display(6);  beat[119].checkend();  beat[119].isHit(3); 
  //fourth
  beat[27].gameTimer(2375); beat[27].move(); beat[27].display(7);  beat[27].checkend();  beat[27].isHit(2);
  beat[28].gameTimer(2433); beat[28].move(); beat[28].display(5);  beat[28].checkend();  beat[28].isHit(4);
  beat[29].gameTimer(2488); beat[29].move(); beat[29].display(7);  beat[29].checkend();beat[29].isHit(2);
  beat[30].gameTimer(2517); beat[30].move(); beat[30].display(5);  beat[30].checkend();  beat[30].isHit(4);
  beat[31].gameTimer(2546); beat[31].move(); beat[31].display(6);  beat[31].checkend();  beat[31].isHit(3);
  beat[32].gameTimer(2604); beat[32].move(); beat[32].display(8);  beat[32].checkend();  beat[32].isHit(1);
  beat[33].gameTimer(2700); beat[33].move(); beat[33].display(5);  beat[33].checkend();beat[33].isHit(4);
  beat[34].gameTimer(2710); beat[34].move(); beat[34].display(7);  beat[34].checkend();  beat[34].isHit(2);
  beat[35].gameTimer(2747); beat[35].move(); beat[35].display(6);  beat[35].checkend();  beat[35].isHit(3);
  beat[36].gameTimer(2775); beat[36].move(); beat[36].display(8);  beat[36].checkend();  beat[36].isHit(1);
  beat[37].gameTimer(2831); beat[37].move(); beat[37].display(8);  beat[37].checkend();beat[37].isHit(1);
  beat[38].gameTimer(2858); beat[38].move(); beat[38].display(6);  beat[38].checkend();  beat[38].isHit(3);
  beat[39].gameTimer(2889); beat[39].move(); beat[39].display(5);  beat[39].checkend();  beat[39].isHit(4);
  beat[40].gameTimer(2945); beat[40].move(); beat[40].display(5);  beat[40].checkend();  beat[40].isHit(4);
  beat[41].gameTimer(2974); beat[41].move(); beat[41].display(6);  beat[41].checkend();beat[41].isHit(3);
  beat[43].gameTimer(3060); beat[43].move(); beat[43].display(8);  beat[43].checkend();  beat[43].isHit(1);
  beat[44].gameTimer(3102); beat[44].move(); beat[44].display(7);  beat[44].checkend();  beat[44].isHit(2);
  beat[120].gameTimer(3116); beat[120].move(); beat[120].display(6);  beat[120].checkend();  beat[120].isHit(3); 
  beat[45].gameTimer(3173); beat[45].move(); beat[45].display(8);  beat[45].checkend();beat[45].isHit(1);
  beat[46].gameTimer(3201); beat[46].move(); beat[46].display(5);  beat[46].checkend();  beat[46].isHit(4);
  beat[47].gameTimer(3230); beat[47].move(); beat[47].display(6);  beat[47].checkend();  beat[47].isHit(3); 
  //fifth
  beat[48].gameTimer(3294); beat[48].move(); beat[48].display(6);  beat[48].checkend();  beat[48].isHit(3);
  beat[121].gameTimer(3294); beat[121].move(); beat[121].display(7);  beat[121].checkend();  beat[121].isHit(2); 
  beat[49].gameTimer(3408); beat[49].move(); beat[49].display(5);  beat[49].checkend();  beat[49].isHit(4);
  beat[122].gameTimer(3408); beat[122].move(); beat[122].display(8);  beat[122].checkend();  beat[122].isHit(1); 
  beat[50].gameTimer(3522); beat[50].move(); beat[50].display(6);  beat[50].checkend();beat[50].isHit(3);
  beat[123].gameTimer(3562); beat[123].move(); beat[123].display(8);  beat[123].checkend();  beat[123].isHit(1); 
  beat[51].gameTimer(3578); beat[51].move(); beat[51].display(7);  beat[51].checkend();  beat[51].isHit(2);
  beat[52].gameTimer(3637); beat[52].move(); beat[52].display(6);  beat[52].checkend();  beat[52].isHit(3);
 // beat[53].gameTimer(3663); beat[53].move(); beat[53].display(6);  beat[53].checkend();  beat[53].isHit(3);
  beat[54].gameTimer(3693); beat[54].move(); beat[54].display(5);  beat[54].checkend();beat[54].isHit(4);
  beat[124].gameTimer(3693); beat[124].move(); beat[124].display(8);  beat[124].checkend();  beat[124].isHit(1); 
  beat[55].gameTimer(3752); beat[55].move(); beat[55].display(8);  beat[55].checkend();  beat[55].isHit(1);
  beat[56].gameTimer(3855); beat[56].move(); beat[56].display(5);  beat[56].checkend();  beat[56].isHit(4); 
  beat[125].gameTimer(3855); beat[125].move(); beat[125].display(7);  beat[125].checkend();  beat[125].isHit(2); 
  beat[57].gameTimer(3975); beat[57].move(); beat[57].display(6);  beat[57].checkend();  beat[57].isHit(3);
  beat[58].gameTimer(4032); beat[58].move(); beat[58].display(5);  beat[58].checkend();  beat[58].isHit(4);
  beat[59].gameTimer(4088); beat[59].move(); beat[59].display(5);  beat[59].checkend();beat[59].isHit(4);
  beat[61].gameTimer(4117); beat[61].move(); beat[61].display(8);  beat[61].checkend();  beat[61].isHit(1);
  beat[63].gameTimer(4144); beat[63].move(); beat[63].display(6);  beat[63].checkend();beat[63].isHit(3);
  //sixth
  beat[64].gameTimer(4197); beat[64].move(); beat[64].display(6);  beat[64].checkend();  beat[64].isHit(3);
  beat[126].gameTimer(4253); beat[126].move(); beat[126].display(5);  beat[126].checkend();  beat[126].isHit(4); 
  beat[65].gameTimer(4253); beat[65].move(); beat[65].display(7);  beat[65].checkend();  beat[65].isHit(2);  
  beat[66].gameTimer(4311); beat[66].move(); beat[66].display(5);  beat[66].checkend();  beat[66].isHit(4);
  beat[67].gameTimer(4331); beat[67].move(); beat[67].display(8);  beat[67].checkend();beat[67].isHit(1);
  beat[68].gameTimer(4353); beat[68].move(); beat[68].display(5);  beat[68].checkend();  beat[68].isHit(4);
  beat[69].gameTimer(4369); beat[69].move(); beat[69].display(8);  beat[69].checkend();  beat[69].isHit(1); 
  beat[70].gameTimer(4398); beat[70].move(); beat[70].display(6);  beat[70].checkend();  beat[70].isHit(3);
  beat[71].gameTimer(4427); beat[71].move(); beat[71].display(7);  beat[71].checkend();  beat[71].isHit(2);
  beat[127].gameTimer(4480); beat[127].move(); beat[127].display(8);  beat[127].checkend();  beat[127].isHit(1); 
  beat[72].gameTimer(4541); beat[72].move(); beat[72].display(5);  beat[72].checkend();beat[72].isHit(4);
  beat[73].gameTimer(4599); beat[73].move(); beat[73].display(5);  beat[73].checkend();  beat[73].isHit(4);
  beat[74].gameTimer(4628); beat[74].move(); beat[74].display(7);  beat[74].checkend();  beat[74].isHit(2);
  beat[128].gameTimer(4628); beat[128].move(); beat[128].display(8);  beat[128].checkend();  beat[128].isHit(1); 
  //beat[75].gameTimer(4655); beat[75].move(); beat[75].display(8);  beat[75].checkend();  beat[75].isHit(1);
  beat[76].gameTimer(4713); beat[76].move(); beat[76].display(5);  beat[76].checkend();beat[76].isHit(4);
  beat[77].gameTimer(4771); beat[77].move(); beat[77].display(5);  beat[77].checkend();  beat[77].isHit(4);
  beat[78].gameTimer(4799); beat[78].move(); beat[78].display(7);  beat[78].checkend();  beat[78].isHit(2); 
  beat[79].gameTimer(4828); beat[79].move(); beat[79].display(6);  beat[79].checkend();  beat[79].isHit(3);
  beat[80].gameTimer(4885); beat[80].move(); beat[80].display(6);  beat[80].checkend();  beat[80].isHit(3);
  beat[81].gameTimer(4939); beat[81].move(); beat[81].display(8);  beat[81].checkend();beat[81].isHit(1);
  beat[82].gameTimer(4998); beat[82].move(); beat[82].display(8);  beat[82].checkend();  beat[82].isHit(1);
  beat[83].gameTimer(5026); beat[83].move(); beat[83].display(5);  beat[83].checkend();  beat[83].isHit(4); 
  beat[84].gameTimer(5050); beat[84].move(); beat[84].display(7);  beat[84].checkend();  beat[84].isHit(2); 
  beat[129].gameTimer(5080); beat[129].move(); beat[129].display(6);  beat[129].checkend();  beat[129].isHit(3); 
  //Seventh 
  beat[86].gameTimer(5111); beat[86].move(); beat[86].display(5);  beat[86].checkend();  beat[86].isHit(4);
  beat[87].gameTimer(5141); beat[87].move(); beat[87].display(8);  beat[87].checkend();  beat[87].isHit(1); 
  beat[88].gameTimer(5168); beat[88].move(); beat[88].display(6);  beat[88].checkend();  beat[88].isHit(3);
  beat[89].gameTimer(5197); beat[89].move(); beat[89].display(5);  beat[89].checkend();  beat[89].isHit(4);
  beat[90].gameTimer(5226); beat[90].move(); beat[90].display(6);  beat[90].checkend();  beat[90].isHit(3);
  beat[91].gameTimer(5254); beat[91].move(); beat[91].display(7);  beat[91].checkend();  beat[91].isHit(2);
  beat[92].gameTimer(5283); beat[92].move(); beat[92].display(8);  beat[92].checkend();  beat[92].isHit(1); 
  //Eighth
  beat[93].gameTimer(5341); beat[93].move(); beat[93].display(5);  beat[93].checkend();  beat[93].isHit(4); 
  beat[94].gameTimer(5368); beat[94].move(); beat[94].display(6);  beat[94].checkend();  beat[94].isHit(3);
  beat[95].gameTimer(5398); beat[95].move(); beat[95].display(7);  beat[95].checkend();  beat[95].isHit(2);
  beat[96].gameTimer(5426); beat[96].move(); beat[96].display(8);  beat[96].checkend();  beat[96].isHit(1); 
  beat[97].gameTimer(5455); beat[97].move(); beat[97].display(6);  beat[97].checkend();  beat[97].isHit(3);
  beat[98].gameTimer(5483); beat[98].move(); beat[98].display(5);  beat[98].checkend();  beat[98].isHit(4);
  beat[99].gameTimer(5512); beat[99].move(); beat[99].display(6);  beat[99].checkend();  beat[99].isHit(3);
  beat[100].gameTimer(5541); beat[100].move(); beat[100].display(5);  beat[100].checkend();  beat[100].isHit(4);
  beat[101].gameTimer(5568); beat[101].move(); beat[101].display(6);  beat[101].checkend();  beat[101].isHit(3); 
  beat[102].gameTimer(5597); beat[102].move(); beat[102].display(8);  beat[102].checkend();  beat[102].isHit(1); 
  beat[104].gameTimer(5654); beat[104].move(); beat[104].display(7);  beat[104].checkend();  beat[104].isHit(2);
  beat[106].gameTimer(5710); beat[106].move(); beat[106].display(8);  beat[106].checkend();  beat[106].isHit(1);
  beat[107].gameTimer(5740); beat[107].move(); beat[107].display(5);  beat[107].checkend();  beat[107].isHit(4);
  //ninth
  beat[108].gameTimer(5798); beat[108].move(); beat[108].display(6);  beat[108].checkend();  beat[108].isHit(3);
  beat[109].gameTimer(5824); beat[109].move(); beat[109].display(7);  beat[109].checkend();  beat[109].isHit(2);
  beat[110].gameTimer(5847); beat[110].move(); beat[110].display(5);  beat[110].checkend();  beat[110].isHit(4); 
  beat[111].gameTimer(5860); beat[111].move(); beat[111].display(8);  beat[111].checkend();  beat[111].isHit(1); 
  beat[112].gameTimer(5874); beat[112].move(); beat[112].display(6);  beat[112].checkend();  beat[112].isHit(3);
  beat[113].gameTimer(5903); beat[113].move(); beat[113].display(7);  beat[113].checkend();  beat[113].isHit(2);
  beat[130].gameTimer(5932); beat[130].move(); beat[130].display(5);  beat[130].checkend();  beat[130].isHit(4);  
  beat[132].gameTimer(5956); beat[132].move(); beat[132].display(8);  beat[132].checkend();  beat[132].isHit(1); 
  beat[115].gameTimer(5985); beat[115].move(); beat[115].display(5);  beat[115].checkend();  beat[115].isHit(4);
  beat[116].gameTimer(5985); beat[116].move(); beat[116].display(7);  beat[116].checkend();  beat[116].isHit(2);




//switch to win or lose
  if(gameTimer == 6425){
     gameTimer += 0;
     if(missCal + okCal <= 5){
       gameState = 6; 
     }else{
       gameState = 7;
    }
  }
   
//raineffect
 if(rainEffectControl){ ellipse(x,y,pointillize,pointillize);}

//pressedDisplay
pressedDisplay();

//score
fill(0);
text(scoreString,635,110);
text(missCalString,910,110);

  break;
   
  
//game3
  case GAME3_MAIN:
  song1.pause();
  song2.pause();
  song3.pause();
  bgm.play();
  scriptTimer--;
  gameStateCheckPoint = GAME3_MAIN;
  image(L3main,0,0);
  if(scriptTimer <= 0){scriptTimer = 0;}
  //doll
  displayDoll();
  
    if(mouseX >= 850 && mouseX <= 980 && mouseY >= 292 && mouseY <= 342 && scriptTimer <= 0){
    image(L3mainEasyHover,0,0);
    
      //doll
  displayDoll();
    
    if(mousePressed){
      clicked.trigger();
      modeCheckPoint = 2;
      scriptTimer = 60;
    gameState = 32;}    
    }else if(mouseX >= 850 && mouseX <= 980 && mouseY >= 415 && mouseY <= 465 && scriptTimer <= 0){
    image(L3mainNormalHover,0,0);
    
      //doll
  displayDoll();
    
    if(mousePressed){
      clicked.trigger();
      modeCheckPoint = 3;
      scriptTimer = 60;
    gameState = 32;}
    }else if(mouseX >= 850 && mouseX <= 980 && mouseY >= 538 && mouseY <= 588 && scriptTimer <= 0){
    image(L3mainHardHover,0,0);
    
      //doll
  displayDoll();
    
    if(mousePressed){
      clicked.trigger();
      modeCheckPoint = 4;
      scriptTimer = 60;
    gameState = 32;}    
    }
  
  break;
  
  case GAME3_INSTRUCTION:
  image(game3sub,0,0);
  if(mouseX >= 425 && mouseX <= 555 && mouseY >= 665 && mouseY <= 715){
    image(game3subHover,0,0);
    if(mousePressed){
      clicked.trigger();
      raineffectimg = loadImage("img/game3run.png");
    gameState = 3;
     
    }
  }
  break;
  
  case GAME3EASY_RUN:
 gameTimer++; 
   song3.play();
  image(track,0,0);
  image(cloud,0,0);
  
    rateDisplayTimer--;
  if(rateDisplayTimer >0){image(rateDisplay,100,500);}
  

   
//map  
  beat[0].gameTimer(1);  beat[0].move();  beat[0].display(1);  beat[0].checkend();    beat[0].isHit(1);
  beat[1].gameTimer(46);  beat[1].move();  beat[1].display(1);  beat[1].checkend();  beat[1].isHit(1);
  beat[2].gameTimer(88);  beat[2].move();  beat[2].display(4);  beat[2].checkend();  beat[2].isHit(4);
  beat[3].gameTimer(109);  beat[3].move();  beat[3].display(3);  beat[3].checkend();  beat[3].isHit(3);
  beat[4].gameTimer(129);  beat[4].move();  beat[4].display(2);  beat[4].checkend();  beat[4].isHit(2);
  beat[5].gameTimer(184);  beat[5].move();  beat[5].display(1);  beat[5].checkend();  beat[5].isHit(1);
  beat[6].gameTimer(225);  beat[6].move();  beat[6].display(2);  beat[6].checkend();  beat[6].isHit(2);
  beat[7].gameTimer(263);  beat[7].move();  beat[7].display(4);  beat[7].checkend();  beat[7].isHit(4);
  beat[8].gameTimer(281);  beat[8].move();  beat[8].display(3);  beat[8].checkend();  beat[8].isHit(3);
  beat[9].gameTimer(304);  beat[9].move();  beat[9].display(4);  beat[9].checkend();  beat[9].isHit(4);
  beat[10].gameTimer(356);  beat[10].move();  beat[10].display(2);  beat[10].checkend();  beat[10].isHit(2);
  beat[11].gameTimer(407);  beat[11].move();  beat[11].display(1);  beat[11].checkend();  beat[11].isHit(1);
  beat[12].gameTimer(450);  beat[12].move();  beat[12].display(4);  beat[12].checkend();  beat[12].isHit(4);
  beat[13].gameTimer(491);  beat[13].move();  beat[13].display(3);  beat[13].checkend();  beat[13].isHit(3);
  beat[14].gameTimer(538);  beat[14].move();  beat[14].display(1);  beat[14].checkend();  beat[14].isHit(1);
  beat[15].gameTimer(571);  beat[15].move();  beat[15].display(3);  beat[15].checkend();  beat[15].isHit(3);
  beat[16].gameTimer(625);  beat[16].move();  beat[16].display(1);  beat[16].checkend();  beat[16].isHit(1);
  beat[17].gameTimer(650);  beat[17].move();  beat[17].display(4);  beat[17].checkend();  beat[17].isHit(4);
  beat[18].gameTimer(663);  beat[18].move();  beat[18].display(2);  beat[18].checkend();  beat[18].isHit(2);
  beat[19].gameTimer(723);  beat[19].move();  beat[19].display(3);  beat[19].checkend();  beat[19].isHit(3);
  beat[20].gameTimer(767);  beat[20].move();  beat[20].display(1);  beat[20].checkend();  beat[20].isHit(1);
  beat[21].gameTimer(814);  beat[21].move();  beat[21].display(2);  beat[21].checkend();  beat[21].isHit(2);
  beat[22].gameTimer(851);  beat[22].move();  beat[22].display(2);  beat[22].checkend();  beat[22].isHit(2);
  beat[23].gameTimer(897);  beat[23].move();  beat[23].display(3);  beat[23].checkend();  beat[23].isHit(3);
  beat[24].gameTimer(942);  beat[24].move();  beat[24].display(3);  beat[24].checkend();  beat[24].isHit(3);
  beat[25].gameTimer(989);  beat[25].move();  beat[25].display(4);  beat[25].checkend();  beat[25].isHit(4);
  beat[26].gameTimer(1015);  beat[26].move();  beat[26].display(3);  beat[26].checkend();  beat[26].isHit(3);
  beat[27].gameTimer(1033);  beat[27].move();  beat[27].display(1);  beat[27].checkend();  beat[27].isHit(1);
  beat[28].gameTimer(1046);  beat[28].move();  beat[28].display(2);  beat[28].checkend();  beat[28].isHit(2);
  beat[29].gameTimer(1087);  beat[29].move();  beat[29].display(3);  beat[29].checkend();  beat[29].isHit(3);
  beat[30].gameTimer(1137);  beat[30].move();  beat[30].display(2);  beat[30].checkend();  beat[30].isHit(2);
  beat[31].gameTimer(1178);  beat[31].move();  beat[31].display(1);  beat[31].checkend();  beat[31].isHit(1);
  beat[32].gameTimer(1223);  beat[32].move();  beat[32].display(1);  beat[32].checkend();  beat[32].isHit(1);
  beat[33].gameTimer(1267);  beat[33].move();  beat[33].display(4);  beat[33].checkend();  beat[33].isHit(4);
  beat[34].gameTimer(1316);  beat[34].move();  beat[34].display(3);  beat[34].checkend();  beat[34].isHit(3);
  beat[35].gameTimer(1356);  beat[35].move();  beat[35].display(3);  beat[35].checkend();  beat[35].isHit(3);
  beat[36].gameTimer(1402);  beat[36].move();  beat[36].display(1);  beat[36].checkend();  beat[36].isHit(1);
  beat[37].gameTimer(1449);  beat[37].move();  beat[37].display(3);  beat[37].checkend();  beat[37].isHit(3);
  beat[38].gameTimer(1496);  beat[38].move();  beat[38].display(2);  beat[38].checkend();  beat[38].isHit(2);
  beat[39].gameTimer(1542);  beat[39].move();  beat[39].display(3);  beat[39].checkend();  beat[39].isHit(3);
  beat[40].gameTimer(1588);  beat[40].move();  beat[40].display(2);  beat[40].checkend();  beat[40].isHit(2);
  beat[41].gameTimer(1631);  beat[41].move();  beat[41].display(4);  beat[41].checkend();  beat[41].isHit(4);
  beat[42].gameTimer(1676);  beat[42].move();  beat[42].display(3);  beat[42].checkend();  beat[42].isHit(3);
  beat[43].gameTimer(1699);  beat[43].move();  beat[43].display(4);  beat[43].checkend();  beat[43].isHit(4);
  beat[44].gameTimer(1716);  beat[44].move();  beat[44].display(2);  beat[44].checkend();  beat[44].isHit(2);
  beat[45].gameTimer(1730);  beat[45].move();  beat[45].display(1);  beat[45].checkend();  beat[45].isHit(1);
  beat[46].gameTimer(1896);  beat[46].move();  beat[46].display(3);  beat[46].checkend();  beat[46].isHit(3);
  beat[47].gameTimer(1915);  beat[47].move();  beat[47].display(2);  beat[47].checkend();  beat[47].isHit(2);
  beat[48].gameTimer(1946);  beat[48].move();  beat[48].display(4);  beat[48].checkend();  beat[48].isHit(4);
  beat[49].gameTimer(1989);  beat[49].move();  beat[49].display(4);  beat[49].checkend();  beat[49].isHit(4);
  beat[50].gameTimer(2021);  beat[50].move();  beat[50].display(3);  beat[50].checkend();  beat[50].isHit(3);
  beat[51].gameTimer(2059);  beat[51].move();  beat[51].display(4);  beat[51].checkend();  beat[51].isHit(4);
  beat[52].gameTimer(2091);  beat[52].move();  beat[52].display(4);  beat[52].checkend();  beat[52].isHit(4);
  beat[53].gameTimer(2124);  beat[53].move();  beat[53].display(3);  beat[53].checkend();  beat[53].isHit(3);
  beat[54].gameTimer(2171);  beat[54].move();  beat[54].display(1);  beat[54].checkend();  beat[54].isHit(1);
  beat[55].gameTimer(2214);  beat[55].move();  beat[55].display(4);  beat[55].checkend();  beat[55].isHit(4);
  beat[56].gameTimer(2250);  beat[56].move();  beat[56].display(3);  beat[56].checkend();  beat[56].isHit(3);
  beat[57].gameTimer(2280);  beat[57].move();  beat[57].display(1);  beat[57].checkend();  beat[57].isHit(1);
  beat[58].gameTimer(2314);  beat[58].move();  beat[58].display(4);  beat[58].checkend();  beat[58].isHit(4);
  beat[59].gameTimer(2356);  beat[59].move();  beat[59].display(1);  beat[59].checkend();  beat[59].isHit(1);
  beat[60].gameTimer(2391);  beat[60].move();  beat[60].display(2);  beat[60].checkend();  beat[60].isHit(2);
  beat[61].gameTimer(2411);  beat[61].move();  beat[61].display(4);  beat[61].checkend();  beat[61].isHit(4);
  beat[62].gameTimer(2454);  beat[62].move();  beat[62].display(3);  beat[62].checkend();  beat[62].isHit(3);
  beat[63].gameTimer(2491);  beat[63].move();  beat[63].display(1);  beat[63].checkend();  beat[63].isHit(1);
  beat[64].gameTimer(2515);  beat[64].move();  beat[64].display(2);  beat[64].checkend();  beat[64].isHit(2);
  beat[65].gameTimer(2538);  beat[65].move();  beat[65].display(4);  beat[65].checkend();  beat[65].isHit(4);
  beat[66].gameTimer(2559);  beat[66].move();  beat[66].display(2);  beat[66].checkend();  beat[66].isHit(2);
  beat[67].gameTimer(2575);  beat[67].move();  beat[67].display(3);  beat[67].checkend();  beat[67].isHit(3);
  beat[68].gameTimer(2609);  beat[68].move();  beat[68].display(1);  beat[68].checkend();  beat[68].isHit(1);
  beat[69].gameTimer(2640);  beat[69].move();  beat[69].display(4);  beat[69].checkend();  beat[69].isHit(4);
  beat[70].gameTimer(2675);  beat[70].move();  beat[70].display(2);  beat[70].checkend();  beat[70].isHit(2);
  beat[71].gameTimer(2717);  beat[71].move();  beat[71].display(3);  beat[71].checkend();  beat[71].isHit(3);
  beat[72].gameTimer(2750);  beat[72].move();  beat[72].display(2);  beat[72].checkend();  beat[72].isHit(2);
  beat[73].gameTimer(2789);  beat[73].move();  beat[73].display(4);  beat[73].checkend();  beat[73].isHit(4);
  beat[74].gameTimer(2821);  beat[74].move();  beat[74].display(1);  beat[74].checkend();  beat[74].isHit(1);
  beat[75].gameTimer(2855);  beat[75].move();  beat[75].display(3);  beat[75].checkend();  beat[75].isHit(3);
  beat[76].gameTimer(2901);  beat[76].move();  beat[76].display(2);  beat[76].checkend();  beat[76].isHit(2);
  beat[77].gameTimer(2941);  beat[77].move();  beat[77].display(4);  beat[77].checkend();  beat[77].isHit(4);
  beat[78].gameTimer(2981);  beat[78].move();  beat[78].display(1);  beat[78].checkend();  beat[78].isHit(1);
  beat[79].gameTimer(3006);  beat[79].move();  beat[79].display(3);  beat[79].checkend();  beat[79].isHit(3);
  beat[80].gameTimer(3044);  beat[80].move();  beat[80].display(4);  beat[80].checkend();  beat[80].isHit(4);
  beat[81].gameTimer(3084);  beat[81].move();  beat[81].display(2);  beat[81].checkend();  beat[81].isHit(2);
  beat[82].gameTimer(3107);  beat[82].move();  beat[82].display(1);  beat[82].checkend();  beat[82].isHit(1);
  beat[83].gameTimer(3138);  beat[83].move();  beat[83].display(4);  beat[83].checkend();  beat[83].isHit(4);
  beat[84].gameTimer(3177);  beat[84].move();  beat[84].display(3);  beat[84].checkend();  beat[84].isHit(3);
  beat[85].gameTimer(3219);  beat[85].move();  beat[85].display(1);  beat[85].checkend();  beat[85].isHit(1);
  beat[86].gameTimer(3242);  beat[86].move();  beat[86].display(4);  beat[86].checkend();  beat[86].isHit(4);
  beat[87].gameTimer(3266);  beat[87].move();  beat[87].display(3);  beat[87].checkend();  beat[87].isHit(3);
  beat[88].gameTimer(3289);  beat[88].move();  beat[88].display(4);  beat[88].checkend();  beat[88].isHit(4);
  beat[89].gameTimer(3318);  beat[89].move();  beat[89].display(2);  beat[89].checkend();  beat[89].isHit(2);
  beat[90].gameTimer(3362);  beat[90].move();  beat[90].display(3);  beat[90].checkend();  beat[90].isHit(3);
  beat[91].gameTimer(3410);  beat[91].move();  beat[91].display(1);  beat[91].checkend();  beat[91].isHit(1);
  beat[92].gameTimer(3456);  beat[92].move();  beat[92].display(4);  beat[92].checkend();  beat[92].isHit(4);
  beat[93].gameTimer(3503);  beat[93].move();  beat[93].display(1);  beat[93].checkend();  beat[93].isHit(1);
  beat[94].gameTimer(3529);  beat[94].move();  beat[94].display(3);  beat[94].checkend();  beat[94].isHit(3);
  beat[95].gameTimer(3541);  beat[95].move();  beat[95].display(4);  beat[95].checkend();  beat[95].isHit(4);
  beat[96].gameTimer(3735);  beat[96].move();  beat[96].display(2);  beat[96].checkend();  beat[96].isHit(2);
  beat[97].gameTimer(3735);  beat[97].move();  beat[97].display(1);  beat[97].checkend();  beat[97].isHit(1);
  beat[98].gameTimer(3778);  beat[98].move();  beat[98].display(4);  beat[98].checkend();  beat[98].isHit(4);
  beat[99].gameTimer(3778);  beat[99].move();  beat[99].display(3);  beat[99].checkend();  beat[99].isHit(3);
  beat[100].gameTimer(3823);  beat[100].move();  beat[100].display(2);  beat[100].checkend();  beat[100].isHit(2);
  beat[101].gameTimer(3823);  beat[101].move();  beat[101].display(4);  beat[101].checkend();  beat[101].isHit(4);
  beat[102].gameTimer(3868);  beat[102].move();  beat[102].display(2);  beat[102].checkend();  beat[102].isHit(2);
  beat[103].gameTimer(3868);  beat[103].move();  beat[103].display(1);  beat[103].checkend();  beat[103].isHit(1);
  beat[104].gameTimer(3913);  beat[104].move();  beat[104].display(4);  beat[104].checkend();  beat[104].isHit(4);
  beat[105].gameTimer(3913);  beat[105].move();  beat[105].display(1);  beat[105].checkend();  beat[105].isHit(1);
  beat[106].gameTimer(3958);  beat[106].move();  beat[106].display(3);  beat[106].checkend();  beat[106].isHit(3);
  beat[107].gameTimer(3958);  beat[107].move();  beat[107].display(2);  beat[107].checkend();  beat[107].isHit(2);
  beat[108].gameTimer(4003);  beat[108].move();  beat[108].display(4);  beat[108].checkend();  beat[108].isHit(4);
  beat[109].gameTimer(4003);  beat[109].move();  beat[109].display(3);  beat[109].checkend();  beat[109].isHit(3);
  beat[110].gameTimer(4048);  beat[110].move();  beat[110].display(1);  beat[110].checkend();  beat[110].isHit(1);
  beat[111].gameTimer(4048);  beat[111].move();  beat[111].display(2);  beat[111].checkend();  beat[111].isHit(2);
  beat[112].gameTimer(4093);  beat[112].move();  beat[112].display(4);  beat[112].checkend();  beat[112].isHit(4);
  beat[113].gameTimer(4093);  beat[113].move();  beat[113].display(3);  beat[113].checkend();  beat[113].isHit(3);
  beat[114].gameTimer(4138);  beat[114].move();  beat[114].display(2);  beat[114].checkend();  beat[114].isHit(2);
  beat[115].gameTimer(4138);  beat[115].move();  beat[115].display(3);  beat[115].checkend();  beat[115].isHit(3);
  beat[116].gameTimer(4183);  beat[116].move();  beat[116].display(1);  beat[116].checkend();  beat[116].isHit(1);
  beat[117].gameTimer(4183);  beat[117].move();  beat[117].display(3);  beat[117].checkend();  beat[117].isHit(3);
  beat[118].gameTimer(4228);  beat[118].move();  beat[118].display(2);  beat[118].checkend();  beat[118].isHit(2);
  beat[119].gameTimer(4228);  beat[119].move();  beat[119].display(4);  beat[119].checkend();  beat[119].isHit(4);
  beat[120].gameTimer(4276);  beat[120].move();  beat[120].display(3);  beat[120].checkend();  beat[120].isHit(3);
  beat[121].gameTimer(4312);  beat[121].move();  beat[121].display(4);  beat[121].checkend();  beat[121].isHit(4);
  beat[122].gameTimer(4354);  beat[122].move();  beat[122].display(2);  beat[122].checkend();  beat[122].isHit(2);
  beat[123].gameTimer(4415);  beat[123].move();  beat[123].display(1);  beat[123].checkend();  beat[123].isHit(1);
  beat[124].gameTimer(4474);  beat[124].move();  beat[124].display(2);  beat[124].checkend();  beat[124].isHit(2);
  beat[125].gameTimer(4474);  beat[125].move();  beat[125].display(3);  beat[125].checkend();  beat[125].isHit(3);

//switch to win or lose
  if(gameTimer == 5200){
     gameTimer += 0;
     if(perfectCal >= 50){
       gameState = 6; 
     }else{
       gameState = 7;
    }
  }
   
//raineffect
 if(rainEffectControl){ ellipse(x,y,pointillize,pointillize);}

//pressedDisplay
pressedDisplay();

//score
fill(0);
text(scoreString,635,110);
text(missCalString,910,110);

  break;

  case GAME3NORMAL_RUN:
  gameTimer++;
  song3.play();
  image(track,0,0);
  image(cloud,0,0);  
  
    rateDisplayTimer--;
  if(rateDisplayTimer >0){image(rateDisplay,100,500);}
  
    
//map  
  beat[0].gameTimer(1);  beat[0].move();  beat[0].display(8);  beat[0].checkend();    beat[0].isHit(1);
  beat[1].gameTimer(46);  beat[1].move();  beat[1].display(8);  beat[1].checkend();  beat[1].isHit(1);
  beat[2].gameTimer(88);  beat[2].move();  beat[2].display(5);  beat[2].checkend();  beat[2].isHit(4);
  beat[3].gameTimer(109);  beat[3].move();  beat[3].display(6);  beat[3].checkend();  beat[3].isHit(3);
  beat[4].gameTimer(129);  beat[4].move();  beat[4].display(7);  beat[4].checkend();  beat[4].isHit(2);
  beat[5].gameTimer(184);  beat[5].move();  beat[5].display(8);  beat[5].checkend();  beat[5].isHit(1);
  beat[6].gameTimer(225);  beat[6].move();  beat[6].display(7);  beat[6].checkend();  beat[6].isHit(2);
  beat[7].gameTimer(263);  beat[7].move();  beat[7].display(5);  beat[7].checkend();  beat[7].isHit(4);
  beat[8].gameTimer(281);  beat[8].move();  beat[8].display(6);  beat[8].checkend();  beat[8].isHit(3);
  beat[9].gameTimer(304);  beat[9].move();  beat[9].display(5);  beat[9].checkend();  beat[9].isHit(4);
  beat[10].gameTimer(356);  beat[10].move();  beat[10].display(7);  beat[10].checkend();  beat[10].isHit(2);
  beat[11].gameTimer(407);  beat[11].move();  beat[11].display(8);  beat[11].checkend();  beat[11].isHit(1);
  beat[12].gameTimer(450);  beat[12].move();  beat[12].display(5);  beat[12].checkend();  beat[12].isHit(4);
  beat[13].gameTimer(491);  beat[13].move();  beat[13].display(6);  beat[13].checkend();  beat[13].isHit(3);
  beat[14].gameTimer(538);  beat[14].move();  beat[14].display(8);  beat[14].checkend();  beat[14].isHit(1);
  beat[15].gameTimer(571);  beat[15].move();  beat[15].display(6);  beat[15].checkend();  beat[15].isHit(3);
  beat[16].gameTimer(625);  beat[16].move();  beat[16].display(8);  beat[16].checkend();  beat[16].isHit(1);
  beat[17].gameTimer(650);  beat[17].move();  beat[17].display(5);  beat[17].checkend();  beat[17].isHit(4);
  beat[18].gameTimer(663);  beat[18].move();  beat[18].display(7);  beat[18].checkend();  beat[18].isHit(2);
  beat[19].gameTimer(723);  beat[19].move();  beat[19].display(6);  beat[19].checkend();  beat[19].isHit(3);
  beat[20].gameTimer(767);  beat[20].move();  beat[20].display(8);  beat[20].checkend();  beat[20].isHit(1);
  beat[21].gameTimer(814);  beat[21].move();  beat[21].display(7);  beat[21].checkend();  beat[21].isHit(2);
  beat[22].gameTimer(851);  beat[22].move();  beat[22].display(7);  beat[22].checkend();  beat[22].isHit(2);
  beat[23].gameTimer(897);  beat[23].move();  beat[23].display(6);  beat[23].checkend();  beat[23].isHit(3);
  beat[24].gameTimer(942);  beat[24].move();  beat[24].display(6);  beat[24].checkend();  beat[24].isHit(3);
  beat[25].gameTimer(989);  beat[25].move();  beat[25].display(5);  beat[25].checkend();  beat[25].isHit(4);
  beat[26].gameTimer(1015);  beat[26].move();  beat[26].display(6);  beat[26].checkend();  beat[26].isHit(3);
  beat[27].gameTimer(1033);  beat[27].move();  beat[27].display(8);  beat[27].checkend();  beat[27].isHit(1);
  beat[28].gameTimer(1046);  beat[28].move();  beat[28].display(7);  beat[28].checkend();  beat[28].isHit(2);
  beat[29].gameTimer(1087);  beat[29].move();  beat[29].display(6);  beat[29].checkend();  beat[29].isHit(3);
  beat[30].gameTimer(1137);  beat[30].move();  beat[30].display(7);  beat[30].checkend();  beat[30].isHit(2);
  beat[31].gameTimer(1178);  beat[31].move();  beat[31].display(8);  beat[31].checkend();  beat[31].isHit(1);
  beat[32].gameTimer(1223);  beat[32].move();  beat[32].display(8);  beat[32].checkend();  beat[32].isHit(1);
  beat[33].gameTimer(1267);  beat[33].move();  beat[33].display(5);  beat[33].checkend();  beat[33].isHit(4);
  beat[34].gameTimer(1316);  beat[34].move();  beat[34].display(6);  beat[34].checkend();  beat[34].isHit(3);
  beat[35].gameTimer(1356);  beat[35].move();  beat[35].display(6);  beat[35].checkend();  beat[35].isHit(3);
  beat[36].gameTimer(1402);  beat[36].move();  beat[36].display(8);  beat[36].checkend();  beat[36].isHit(1);
  beat[37].gameTimer(1449);  beat[37].move();  beat[37].display(6);  beat[37].checkend();  beat[37].isHit(3);
  beat[38].gameTimer(1496);  beat[38].move();  beat[38].display(7);  beat[38].checkend();  beat[38].isHit(2);
  beat[39].gameTimer(1542);  beat[39].move();  beat[39].display(6);  beat[39].checkend();  beat[39].isHit(3);
  beat[40].gameTimer(1588);  beat[40].move();  beat[40].display(7);  beat[40].checkend();  beat[40].isHit(2);
  beat[41].gameTimer(1631);  beat[41].move();  beat[41].display(5);  beat[41].checkend();  beat[41].isHit(4);
  beat[42].gameTimer(1676);  beat[42].move();  beat[42].display(6);  beat[42].checkend();  beat[42].isHit(3);
  beat[43].gameTimer(1699);  beat[43].move();  beat[43].display(5);  beat[43].checkend();  beat[43].isHit(4);
  beat[44].gameTimer(1716);  beat[44].move();  beat[44].display(7);  beat[44].checkend();  beat[44].isHit(2);
  beat[45].gameTimer(1730);  beat[45].move();  beat[45].display(8);  beat[45].checkend();  beat[45].isHit(1);
  beat[46].gameTimer(1896);  beat[46].move();  beat[46].display(6);  beat[46].checkend();  beat[46].isHit(3);
  beat[47].gameTimer(1915);  beat[47].move();  beat[47].display(7);  beat[47].checkend();  beat[47].isHit(2);
  beat[48].gameTimer(1946);  beat[48].move();  beat[48].display(5);  beat[48].checkend();  beat[48].isHit(4);
  beat[49].gameTimer(1989);  beat[49].move();  beat[49].display(5);  beat[49].checkend();  beat[49].isHit(4);
  beat[50].gameTimer(2021);  beat[50].move();  beat[50].display(6);  beat[50].checkend();  beat[50].isHit(3);
  beat[51].gameTimer(2059);  beat[51].move();  beat[51].display(5);  beat[51].checkend();  beat[51].isHit(4);
  beat[52].gameTimer(2091);  beat[52].move();  beat[52].display(5);  beat[52].checkend();  beat[52].isHit(4);
  beat[53].gameTimer(2124);  beat[53].move();  beat[53].display(6);  beat[53].checkend();  beat[53].isHit(3);
  beat[54].gameTimer(2171);  beat[54].move();  beat[54].display(8);  beat[54].checkend();  beat[54].isHit(1);
  beat[55].gameTimer(2214);  beat[55].move();  beat[55].display(5);  beat[55].checkend();  beat[55].isHit(4);
  beat[56].gameTimer(2250);  beat[56].move();  beat[56].display(6);  beat[56].checkend();  beat[56].isHit(3);
  beat[57].gameTimer(2280);  beat[57].move();  beat[57].display(8);  beat[57].checkend();  beat[57].isHit(1);
  beat[58].gameTimer(2314);  beat[58].move();  beat[58].display(5);  beat[58].checkend();  beat[58].isHit(4);
  beat[59].gameTimer(2356);  beat[59].move();  beat[59].display(8);  beat[59].checkend();  beat[59].isHit(1);
  beat[60].gameTimer(2391);  beat[60].move();  beat[60].display(7);  beat[60].checkend();  beat[60].isHit(2);
  beat[61].gameTimer(2411);  beat[61].move();  beat[61].display(5);  beat[61].checkend();  beat[61].isHit(4);
  beat[62].gameTimer(2454);  beat[62].move();  beat[62].display(6);  beat[62].checkend();  beat[62].isHit(3);
  beat[63].gameTimer(2491);  beat[63].move();  beat[63].display(8);  beat[63].checkend();  beat[63].isHit(1);
  beat[64].gameTimer(2515);  beat[64].move();  beat[64].display(7);  beat[64].checkend();  beat[64].isHit(2);
  beat[65].gameTimer(2538);  beat[65].move();  beat[65].display(5);  beat[65].checkend();  beat[65].isHit(4);
  beat[66].gameTimer(2559);  beat[66].move();  beat[66].display(7);  beat[66].checkend();  beat[66].isHit(2);
  beat[67].gameTimer(2575);  beat[67].move();  beat[67].display(6);  beat[67].checkend();  beat[67].isHit(3);
  beat[68].gameTimer(2609);  beat[68].move();  beat[68].display(8);  beat[68].checkend();  beat[68].isHit(1);
  beat[69].gameTimer(2640);  beat[69].move();  beat[69].display(5);  beat[69].checkend();  beat[69].isHit(4);
  beat[70].gameTimer(2675);  beat[70].move();  beat[70].display(7);  beat[70].checkend();  beat[70].isHit(2);
  beat[71].gameTimer(2717);  beat[71].move();  beat[71].display(6);  beat[71].checkend();  beat[71].isHit(3);
  beat[72].gameTimer(2750);  beat[72].move();  beat[72].display(7);  beat[72].checkend();  beat[72].isHit(2);
  beat[73].gameTimer(2789);  beat[73].move();  beat[73].display(5);  beat[73].checkend();  beat[73].isHit(4);
  beat[74].gameTimer(2821);  beat[74].move();  beat[74].display(8);  beat[74].checkend();  beat[74].isHit(1);
  beat[75].gameTimer(2855);  beat[75].move();  beat[75].display(6);  beat[75].checkend();  beat[75].isHit(3);
  beat[76].gameTimer(2901);  beat[76].move();  beat[76].display(7);  beat[76].checkend();  beat[76].isHit(2);
  beat[77].gameTimer(2941);  beat[77].move();  beat[77].display(5);  beat[77].checkend();  beat[77].isHit(4);
  beat[78].gameTimer(2981);  beat[78].move();  beat[78].display(8);  beat[78].checkend();  beat[78].isHit(1);
  beat[79].gameTimer(3006);  beat[79].move();  beat[79].display(6);  beat[79].checkend();  beat[79].isHit(3);
  beat[80].gameTimer(3044);  beat[80].move();  beat[80].display(5);  beat[80].checkend();  beat[80].isHit(4);
  beat[81].gameTimer(3084);  beat[81].move();  beat[81].display(7);  beat[81].checkend();  beat[81].isHit(2);
  beat[82].gameTimer(3107);  beat[82].move();  beat[82].display(8);  beat[82].checkend();  beat[82].isHit(1);
  beat[83].gameTimer(3138);  beat[83].move();  beat[83].display(5);  beat[83].checkend();  beat[83].isHit(4);
  beat[84].gameTimer(3177);  beat[84].move();  beat[84].display(6);  beat[84].checkend();  beat[84].isHit(3);
  beat[85].gameTimer(3219);  beat[85].move();  beat[85].display(8);  beat[85].checkend();  beat[85].isHit(1);
  beat[86].gameTimer(3242);  beat[86].move();  beat[86].display(5);  beat[86].checkend();  beat[86].isHit(4);
  beat[87].gameTimer(3266);  beat[87].move();  beat[87].display(6);  beat[87].checkend();  beat[87].isHit(3);
  beat[88].gameTimer(3289);  beat[88].move();  beat[88].display(5);  beat[88].checkend();  beat[88].isHit(4);
  beat[89].gameTimer(3318);  beat[89].move();  beat[89].display(7);  beat[89].checkend();  beat[89].isHit(2);
  beat[90].gameTimer(3362);  beat[90].move();  beat[90].display(6);  beat[90].checkend();  beat[90].isHit(3);
  beat[91].gameTimer(3410);  beat[91].move();  beat[91].display(8);  beat[91].checkend();  beat[91].isHit(1);
  beat[92].gameTimer(3456);  beat[92].move();  beat[92].display(5);  beat[92].checkend();  beat[92].isHit(4);
  beat[93].gameTimer(3503);  beat[93].move();  beat[93].display(8);  beat[93].checkend();  beat[93].isHit(1);
  beat[94].gameTimer(3529);  beat[94].move();  beat[94].display(6);  beat[94].checkend();  beat[94].isHit(3);
  beat[95].gameTimer(3541);  beat[95].move();  beat[95].display(5);  beat[95].checkend();  beat[95].isHit(4);
  beat[96].gameTimer(3735);  beat[96].move();  beat[96].display(7);  beat[96].checkend();  beat[96].isHit(2);
  beat[97].gameTimer(3735);  beat[97].move();  beat[97].display(8);  beat[97].checkend();  beat[97].isHit(1);
  beat[98].gameTimer(3778);  beat[98].move();  beat[98].display(5);  beat[98].checkend();  beat[98].isHit(4);
  beat[99].gameTimer(3778);  beat[99].move();  beat[99].display(6);  beat[99].checkend();  beat[99].isHit(3);
  beat[100].gameTimer(3823);  beat[100].move();  beat[100].display(7);  beat[100].checkend();  beat[100].isHit(2);
  beat[101].gameTimer(3823);  beat[101].move();  beat[101].display(5);  beat[101].checkend();  beat[101].isHit(4);
  beat[102].gameTimer(3868);  beat[102].move();  beat[102].display(7);  beat[102].checkend();  beat[102].isHit(2);
  beat[103].gameTimer(3868);  beat[103].move();  beat[103].display(8);  beat[103].checkend();  beat[103].isHit(1);
  beat[104].gameTimer(3913);  beat[104].move();  beat[104].display(5);  beat[104].checkend();  beat[104].isHit(4);
  beat[105].gameTimer(3913);  beat[105].move();  beat[105].display(8);  beat[105].checkend();  beat[105].isHit(1);
  beat[106].gameTimer(3958);  beat[106].move();  beat[106].display(6);  beat[106].checkend();  beat[106].isHit(3);
  beat[107].gameTimer(3958);  beat[107].move();  beat[107].display(7);  beat[107].checkend();  beat[107].isHit(2);
  beat[108].gameTimer(4003);  beat[108].move();  beat[108].display(5);  beat[108].checkend();  beat[108].isHit(4);
  beat[109].gameTimer(4003);  beat[109].move();  beat[109].display(6);  beat[109].checkend();  beat[109].isHit(3);
  beat[110].gameTimer(4048);  beat[110].move();  beat[110].display(8);  beat[110].checkend();  beat[110].isHit(1);
  beat[111].gameTimer(4048);  beat[111].move();  beat[111].display(7);  beat[111].checkend();  beat[111].isHit(2);
  beat[112].gameTimer(4093);  beat[112].move();  beat[112].display(5);  beat[112].checkend();  beat[112].isHit(4);
  beat[113].gameTimer(4093);  beat[113].move();  beat[113].display(6);  beat[113].checkend();  beat[113].isHit(3);
  beat[114].gameTimer(4138);  beat[114].move();  beat[114].display(7);  beat[114].checkend();  beat[114].isHit(2);
  beat[115].gameTimer(4138);  beat[115].move();  beat[115].display(6);  beat[115].checkend();  beat[115].isHit(3);
  beat[116].gameTimer(4183);  beat[116].move();  beat[116].display(8);  beat[116].checkend();  beat[116].isHit(1);
  beat[117].gameTimer(4183);  beat[117].move();  beat[117].display(6);  beat[117].checkend();  beat[117].isHit(3);
  beat[118].gameTimer(4228);  beat[118].move();  beat[118].display(7);  beat[118].checkend();  beat[118].isHit(2);
  beat[119].gameTimer(4228);  beat[119].move();  beat[119].display(5);  beat[119].checkend();  beat[119].isHit(4);
  beat[120].gameTimer(4276);  beat[120].move();  beat[120].display(6);  beat[120].checkend();  beat[120].isHit(3);
  beat[121].gameTimer(4312);  beat[121].move();  beat[121].display(5);  beat[121].checkend();  beat[121].isHit(4);
  beat[122].gameTimer(4354);  beat[122].move();  beat[122].display(7);  beat[122].checkend();  beat[122].isHit(2);
  beat[123].gameTimer(4415);  beat[123].move();  beat[123].display(8);  beat[123].checkend();  beat[123].isHit(1);
  beat[124].gameTimer(4474);  beat[124].move();  beat[124].display(7);  beat[124].checkend();  beat[124].isHit(2);
  beat[125].gameTimer(4474);  beat[125].move();  beat[125].display(6);  beat[125].checkend();  beat[125].isHit(3);

//switch to win or lose
  if(gameTimer == 5200){
     gameTimer += 0;
     if(perfectCal >= 50){
       gameState = 6; 
     }else{
       gameState = 7;
    }
  }
   
//raineffect
 if(rainEffectControl){ ellipse(x,y,pointillize,pointillize);}

//pressedDisplay
pressedDisplay();

//score
fill(0);
text(scoreString,635,110);
text(missCalString,910,110);

  break;

  case GAME3HARD_RUN:
  gameTimer++; 
  song3.play();
  image(track,0,0);
  image(cloud,0,0);   
  
    rateDisplayTimer--;
  if(rateDisplayTimer >0){image(rateDisplay,100,500);}
  
  
   
//map  
  beat[0].gameTimer(1);  beat[0].move();  beat[0].display(8);  beat[0].checkend();    beat[0].isHit(1);
  beat[1].gameTimer(46);  beat[1].move();  beat[1].display(3);  beat[1].checkend();  beat[1].isHit(3);
  beat[2].gameTimer(88);  beat[2].move();  beat[2].display(6);  beat[2].checkend();  beat[2].isHit(3);
  beat[3].gameTimer(109);  beat[3].move();  beat[3].display(5);  beat[3].checkend();  beat[3].isHit(4);
  beat[4].gameTimer(129);  beat[4].move();  beat[4].display(2);  beat[4].checkend();  beat[4].isHit(2);
  beat[5].gameTimer(184);  beat[5].move();  beat[5].display(2);  beat[5].checkend();  beat[5].isHit(2);
  beat[6].gameTimer(225);  beat[6].move();  beat[6].display(3);  beat[6].checkend();  beat[6].isHit(3);
  beat[7].gameTimer(263);  beat[7].move();  beat[7].display(2);  beat[7].checkend();  beat[7].isHit(2);
  beat[8].gameTimer(281);  beat[8].move();  beat[8].display(5);  beat[8].checkend();  beat[8].isHit(4);
  beat[9].gameTimer(304);  beat[9].move();  beat[9].display(6);  beat[9].checkend();  beat[9].isHit(3);
  beat[10].gameTimer(356);  beat[10].move();  beat[10].display(4);  beat[10].checkend();  beat[10].isHit(4);
  beat[11].gameTimer(407);  beat[11].move();  beat[11].display(8);  beat[11].checkend();  beat[11].isHit(1);
  beat[12].gameTimer(450);  beat[12].move();  beat[12].display(5);  beat[12].checkend();  beat[12].isHit(4);
  beat[13].gameTimer(491);  beat[13].move();  beat[13].display(8);  beat[13].checkend();  beat[13].isHit(1);
  beat[14].gameTimer(538);  beat[14].move();  beat[14].display(2);  beat[14].checkend();  beat[14].isHit(2);
  beat[15].gameTimer(571);  beat[15].move();  beat[15].display(1);  beat[15].checkend();  beat[15].isHit(1);
  beat[16].gameTimer(625);  beat[16].move();  beat[16].display(5);  beat[16].checkend();  beat[16].isHit(4);
  beat[17].gameTimer(650);  beat[17].move();  beat[17].display(6);  beat[17].checkend();  beat[17].isHit(3);
  beat[18].gameTimer(663);  beat[18].move();  beat[18].display(2);  beat[18].checkend();  beat[18].isHit(2);
  beat[19].gameTimer(723);  beat[19].move();  beat[19].display(7);  beat[19].checkend();  beat[19].isHit(2);
  beat[20].gameTimer(767);  beat[20].move();  beat[20].display(7);  beat[20].checkend();  beat[20].isHit(2);
  beat[21].gameTimer(814);  beat[21].move();  beat[21].display(3);  beat[21].checkend();  beat[21].isHit(3);
  beat[22].gameTimer(851);  beat[22].move();  beat[22].display(6);  beat[22].checkend();  beat[22].isHit(3);
  beat[23].gameTimer(897);  beat[23].move();  beat[23].display(5);  beat[23].checkend();  beat[23].isHit(4);
  beat[24].gameTimer(942);  beat[24].move();  beat[24].display(3);  beat[24].checkend();  beat[24].isHit(3);
  beat[25].gameTimer(989);  beat[25].move();  beat[25].display(6);  beat[25].checkend();  beat[25].isHit(3);
  beat[26].gameTimer(1015);  beat[26].move();  beat[26].display(2);  beat[26].checkend();  beat[26].isHit(2);
  beat[27].gameTimer(1033);  beat[27].move();  beat[27].display(8);  beat[27].checkend();  beat[27].isHit(1);
  beat[28].gameTimer(1046);  beat[28].move();  beat[28].display(4);  beat[28].checkend();  beat[28].isHit(4);
  beat[29].gameTimer(1087);  beat[29].move();  beat[29].display(4);  beat[29].checkend();  beat[29].isHit(4);
  beat[30].gameTimer(1137);  beat[30].move();  beat[30].display(4);  beat[30].checkend();  beat[30].isHit(4);
  beat[31].gameTimer(1178);  beat[31].move();  beat[31].display(6);  beat[31].checkend();  beat[31].isHit(3);
  beat[32].gameTimer(1223);  beat[32].move();  beat[32].display(3);  beat[32].checkend();  beat[32].isHit(3);
  beat[33].gameTimer(1267);  beat[33].move();  beat[33].display(7);  beat[33].checkend();  beat[33].isHit(2);
  beat[34].gameTimer(1316);  beat[34].move();  beat[34].display(3);  beat[34].checkend();  beat[34].isHit(3);
  beat[35].gameTimer(1356);  beat[35].move();  beat[35].display(5);  beat[35].checkend();  beat[35].isHit(4);
  beat[36].gameTimer(1402);  beat[36].move();  beat[36].display(1);  beat[36].checkend();  beat[36].isHit(1);
  beat[37].gameTimer(1449);  beat[37].move();  beat[37].display(7);  beat[37].checkend();  beat[37].isHit(2);
  beat[38].gameTimer(1496);  beat[38].move();  beat[38].display(4);  beat[38].checkend();  beat[38].isHit(4);
  beat[39].gameTimer(1542);  beat[39].move();  beat[39].display(4);  beat[39].checkend();  beat[39].isHit(4);
  beat[40].gameTimer(1588);  beat[40].move();  beat[40].display(4);  beat[40].checkend();  beat[40].isHit(4);
  beat[41].gameTimer(1631);  beat[41].move();  beat[41].display(5);  beat[41].checkend();  beat[41].isHit(4);
  beat[42].gameTimer(1676);  beat[42].move();  beat[42].display(4);  beat[42].checkend();  beat[42].isHit(4);
  beat[43].gameTimer(1699);  beat[43].move();  beat[43].display(7);  beat[43].checkend();  beat[43].isHit(2);
  beat[44].gameTimer(1716);  beat[44].move();  beat[44].display(4);  beat[44].checkend();  beat[44].isHit(4);
  beat[45].gameTimer(1730);  beat[45].move();  beat[45].display(1);  beat[45].checkend();  beat[45].isHit(1);
  beat[46].gameTimer(1896);  beat[46].move();  beat[46].display(8);  beat[46].checkend();  beat[46].isHit(1);
  beat[47].gameTimer(1915);  beat[47].move();  beat[47].display(6);  beat[47].checkend();  beat[47].isHit(3);
  beat[48].gameTimer(1946);  beat[48].move();  beat[48].display(4);  beat[48].checkend();  beat[48].isHit(4);
  beat[49].gameTimer(1989);  beat[49].move();  beat[49].display(2);  beat[49].checkend();  beat[49].isHit(2);
  beat[50].gameTimer(2021);  beat[50].move();  beat[50].display(2);  beat[50].checkend();  beat[50].isHit(2);
  beat[51].gameTimer(2059);  beat[51].move();  beat[51].display(3);  beat[51].checkend();  beat[51].isHit(3);
  beat[52].gameTimer(2091);  beat[52].move();  beat[52].display(3);  beat[52].checkend();  beat[52].isHit(3);
  beat[53].gameTimer(2124);  beat[53].move();  beat[53].display(3);  beat[53].checkend();  beat[53].isHit(3);
  beat[54].gameTimer(2171);  beat[54].move();  beat[54].display(1);  beat[54].checkend();  beat[54].isHit(1);
  beat[55].gameTimer(2214);  beat[55].move();  beat[55].display(1);  beat[55].checkend();  beat[55].isHit(1);
  beat[56].gameTimer(2250);  beat[56].move();  beat[56].display(2);  beat[56].checkend();  beat[56].isHit(2);
  beat[57].gameTimer(2280);  beat[57].move();  beat[57].display(8);  beat[57].checkend();  beat[57].isHit(1);
  beat[58].gameTimer(2314);  beat[58].move();  beat[58].display(2);  beat[58].checkend();  beat[58].isHit(2);
  beat[59].gameTimer(2356);  beat[59].move();  beat[59].display(4);  beat[59].checkend();  beat[59].isHit(4);
  beat[60].gameTimer(2391);  beat[60].move();  beat[60].display(5);  beat[60].checkend();  beat[60].isHit(4);
  beat[61].gameTimer(2411);  beat[61].move();  beat[61].display(7);  beat[61].checkend();  beat[61].isHit(2);
  beat[62].gameTimer(2454);  beat[62].move();  beat[62].display(4);  beat[62].checkend();  beat[62].isHit(4);
  beat[63].gameTimer(2491);  beat[63].move();  beat[63].display(4);  beat[63].checkend();  beat[63].isHit(4);
  beat[64].gameTimer(2515);  beat[64].move();  beat[64].display(8);  beat[64].checkend();  beat[64].isHit(1);
  beat[65].gameTimer(2538);  beat[65].move();  beat[65].display(3);  beat[65].checkend();  beat[65].isHit(3);
  beat[66].gameTimer(2559);  beat[66].move();  beat[66].display(5);  beat[66].checkend();  beat[66].isHit(4);
  beat[67].gameTimer(2575);  beat[67].move();  beat[67].display(2);  beat[67].checkend();  beat[67].isHit(2);
  beat[68].gameTimer(2609);  beat[68].move();  beat[68].display(5);  beat[68].checkend();  beat[68].isHit(4);
  beat[69].gameTimer(2640);  beat[69].move();  beat[69].display(6);  beat[69].checkend();  beat[69].isHit(3);
  beat[70].gameTimer(2675);  beat[70].move();  beat[70].display(7);  beat[70].checkend();  beat[70].isHit(2);
  beat[71].gameTimer(2717);  beat[71].move();  beat[71].display(7);  beat[71].checkend();  beat[71].isHit(2);
  beat[72].gameTimer(2750);  beat[72].move();  beat[72].display(1);  beat[72].checkend();  beat[72].isHit(1);
  beat[73].gameTimer(2789);  beat[73].move();  beat[73].display(8);  beat[73].checkend();  beat[73].isHit(1);
  beat[74].gameTimer(2821);  beat[74].move();  beat[74].display(2);  beat[74].checkend();  beat[74].isHit(2);
  beat[75].gameTimer(2855);  beat[75].move();  beat[75].display(3);  beat[75].checkend();  beat[75].isHit(3);
  beat[76].gameTimer(2901);  beat[76].move();  beat[76].display(2);  beat[76].checkend();  beat[76].isHit(2);
  beat[77].gameTimer(2941);  beat[77].move();  beat[77].display(8);  beat[77].checkend();  beat[77].isHit(1);
  beat[78].gameTimer(2981);  beat[78].move();  beat[78].display(6);  beat[78].checkend();  beat[78].isHit(3);
  beat[79].gameTimer(3006);  beat[79].move();  beat[79].display(4);  beat[79].checkend();  beat[79].isHit(4);
  beat[80].gameTimer(3044);  beat[80].move();  beat[80].display(7);  beat[80].checkend();  beat[80].isHit(2);
  beat[81].gameTimer(3084);  beat[81].move();  beat[81].display(1);  beat[81].checkend();  beat[81].isHit(1);
  beat[82].gameTimer(3107);  beat[82].move();  beat[82].display(5);  beat[82].checkend();  beat[82].isHit(4);
  beat[83].gameTimer(3138);  beat[83].move();  beat[83].display(6);  beat[83].checkend();  beat[83].isHit(3);
  beat[84].gameTimer(3177);  beat[84].move();  beat[84].display(8);  beat[84].checkend();  beat[84].isHit(1);
  beat[85].gameTimer(3219);  beat[85].move();  beat[85].display(7);  beat[85].checkend();  beat[85].isHit(2);
  beat[86].gameTimer(3242);  beat[86].move();  beat[86].display(4);  beat[86].checkend();  beat[86].isHit(4);
  beat[87].gameTimer(3266);  beat[87].move();  beat[87].display(1);  beat[87].checkend();  beat[87].isHit(1);
  beat[88].gameTimer(3289);  beat[88].move();  beat[88].display(3);  beat[88].checkend();  beat[88].isHit(3);
  beat[89].gameTimer(3318);  beat[89].move();  beat[89].display(8);  beat[89].checkend();  beat[89].isHit(1);
  beat[90].gameTimer(3362);  beat[90].move();  beat[90].display(8);  beat[90].checkend();  beat[90].isHit(1);
  beat[91].gameTimer(3410);  beat[91].move();  beat[91].display(7);  beat[91].checkend();  beat[91].isHit(2);
  beat[92].gameTimer(3456);  beat[92].move();  beat[92].display(5);  beat[92].checkend();  beat[92].isHit(4);
  beat[93].gameTimer(3503);  beat[93].move();  beat[93].display(6);  beat[93].checkend();  beat[93].isHit(3);
  beat[94].gameTimer(3529);  beat[94].move();  beat[94].display(2);  beat[94].checkend();  beat[94].isHit(2);
  beat[95].gameTimer(3541);  beat[95].move();  beat[95].display(8);  beat[95].checkend();  beat[95].isHit(1);
  beat[96].gameTimer(3735);  beat[96].move();  beat[96].display(4);  beat[96].checkend();  beat[96].isHit(4);
  beat[97].gameTimer(3735);  beat[97].move();  beat[97].display(3);  beat[97].checkend();  beat[97].isHit(3);
  beat[98].gameTimer(3778);  beat[98].move();  beat[98].display(5);  beat[98].checkend();  beat[98].isHit(4);
  beat[99].gameTimer(3778);  beat[99].move();  beat[99].display(7);  beat[99].checkend();  beat[99].isHit(2);
  beat[100].gameTimer(3823);  beat[100].move();  beat[100].display(8);  beat[100].checkend();  beat[100].isHit(1);
  beat[101].gameTimer(3823);  beat[101].move();  beat[101].display(7);  beat[101].checkend();  beat[101].isHit(2);
  beat[102].gameTimer(3868);  beat[102].move();  beat[102].display(7);  beat[102].checkend();  beat[102].isHit(2);
  beat[103].gameTimer(3868);  beat[103].move();  beat[103].display(4);  beat[103].checkend();  beat[103].isHit(4);
  beat[104].gameTimer(3913);  beat[104].move();  beat[104].display(4);  beat[104].checkend();  beat[104].isHit(4);
  beat[105].gameTimer(3913);  beat[105].move();  beat[105].display(1);  beat[105].checkend();  beat[105].isHit(1);
  beat[106].gameTimer(3958);  beat[106].move();  beat[106].display(2);  beat[106].checkend();  beat[106].isHit(2);
  beat[107].gameTimer(3958);  beat[107].move();  beat[107].display(1);  beat[107].checkend();  beat[107].isHit(1);
  beat[108].gameTimer(4003);  beat[108].move();  beat[108].display(1);  beat[108].checkend();  beat[108].isHit(1);
  beat[109].gameTimer(4003);  beat[109].move();  beat[109].display(4);  beat[109].checkend();  beat[109].isHit(4);
  beat[110].gameTimer(4048);  beat[110].move();  beat[110].display(2);  beat[110].checkend();  beat[110].isHit(2);
  beat[111].gameTimer(4048);  beat[111].move();  beat[111].display(3);  beat[111].checkend();  beat[111].isHit(3);
  beat[112].gameTimer(4093);  beat[112].move();  beat[112].display(6);  beat[112].checkend();  beat[112].isHit(3);
  beat[113].gameTimer(4093);  beat[113].move();  beat[113].display(8);  beat[113].checkend();  beat[113].isHit(1);
  beat[114].gameTimer(4138);  beat[114].move();  beat[114].display(5);  beat[114].checkend();  beat[114].isHit(4);
  beat[115].gameTimer(4138);  beat[115].move();  beat[115].display(6);  beat[115].checkend();  beat[115].isHit(3);
  beat[116].gameTimer(4183);  beat[116].move();  beat[116].display(5);  beat[116].checkend();  beat[116].isHit(4);
  beat[117].gameTimer(4183);  beat[117].move();  beat[117].display(8);  beat[117].checkend();  beat[117].isHit(1);
  beat[118].gameTimer(4228);  beat[118].move();  beat[118].display(5);  beat[118].checkend();  beat[118].isHit(4);
  beat[119].gameTimer(4228);  beat[119].move();  beat[119].display(6);  beat[119].checkend();  beat[119].isHit(3);
  beat[120].gameTimer(4276);  beat[120].move();  beat[120].display(2);  beat[120].checkend();  beat[120].isHit(2);
  beat[121].gameTimer(4312);  beat[121].move();  beat[121].display(2);  beat[121].checkend();  beat[121].isHit(2);
  beat[122].gameTimer(4354);  beat[122].move();  beat[122].display(5);  beat[122].checkend();  beat[122].isHit(4);
  beat[123].gameTimer(4415);  beat[123].move();  beat[123].display(7);  beat[123].checkend();  beat[123].isHit(2);
  beat[124].gameTimer(4474);  beat[124].move();  beat[124].display(8);  beat[124].checkend();  beat[124].isHit(1);
  beat[125].gameTimer(4474);  beat[125].move();  beat[125].display(3);  beat[125].checkend();  beat[125].isHit(3);

//switch to win or lose
  if(gameTimer == 5200){
     gameTimer += 0;
     if(perfectCal >= 50){
       gameState = 6; 
     }else{
       gameState = 7;
    }
  }
   
//raineffect
 if(rainEffectControl){ ellipse(x,y,pointillize,pointillize);}

//pressedDisplay
pressedDisplay();

//score
fill(0);
text(scoreString,635,110);
text(missCalString,910,110);

  break;

  case GAME_WIN:
    image(win,0,0);
    winSound.play();
  //doll
  displayDoll();

    fill(0);
      text(scoreString,475,378);
      text(perfectCalString,475,431);
      text(goodCalString,475,487);
      text(okCalString,475,546);
      text(missCalString,475,601);
   
    if(mouseX >= 850 && mouseX <= 980 && mouseY >= 415 && mouseY <= 465){
      image(winHover,0,0);
      
      //doll
  displayDoll();
      
      fill(0);
      text(scoreString,475,378);
      text(perfectCalString,475,431);
      text(goodCalString,475,487);
      text(okCalString,475,546);
      text(missCalString,475,601);
      if(mousePressed){
        winSound.pause();
        winSound.rewind();
        clicked.trigger();
      song1.rewind();
      song2.rewind();
      song3.rewind();
      gameTimer = 0;
      perfectCal = 0;
      goodCal = 0;
      okCal = 0;
      missCal = 0;
      dollCal++;
      gameState = gameStateCheckPoint+10; 
      }
     }
    
  break;
  
  case GAME_LOSE:
    image(lose,0,0);
    loseSound.play();
     //doll
  displayDoll();
    
    fill(0);
      text(scoreString,475,378);
      text(perfectCalString,475,431);
      text(goodCalString,475,487);
      text(okCalString,475,546);
      text(missCalString,475,601);
    
    if(mouseX >= 850 && mouseX <= 980 && mouseY >= 415 && mouseY <= 465){
      image(loseHover,0,0);
      
      //doll
  displayDoll();
      
      fill(0);
      text(scoreString,475,378);
      text(perfectCalString,475,431);
      text(goodCalString,475,487);
      text(okCalString,475,546);
      text(missCalString,475,601);
      if(mousePressed){
        loseSound.pause();
        loseSound.rewind();
        clicked.trigger();
      song1.rewind();
      song2.rewind();
      song3.rewind();            
      gameTimer = 0;
      perfectCal = 0;
      goodCal = 0;
      okCal = 0;
      missCal = 0;
     gameState = gameStateCheckPoint;
      }
    }
    
  break;
  
  case GAME_TIPS:
  scriptTimer--;
  image(tip,0,0);
  if(scriptTimer <= 0){scriptTimer = 0;}
  //doll
  displayDoll();
  
  if(mouseX >=850 && mouseX <= 980 && mouseY >= 415 && mouseY <= 465){
   image(tipHover,0,0);
   
     //doll
  displayDoll();
   
   if(gameStateCheckPoint == 11 && mousePressed && scriptTimer <=0){  
     bgm.pause();
     bgm.rewind();
     clicked.trigger();
   scriptTimer = 60;
   image(game1bg,0,0);
   gameState = gameStateCheckPoint + modeCheckPoint;
   }else if(gameStateCheckPoint == 21 && mousePressed && scriptTimer <=0){
     bgm.pause();
     bgm.rewind();
     clicked.trigger();
   scriptTimer = 60;
   image(game2bg,0,0);
   gameState = gameStateCheckPoint + modeCheckPoint; 
   }else if(gameStateCheckPoint == 31 && mousePressed && scriptTimer <=0){
     bgm.pause();
     bgm.rewind();
     clicked.trigger();
   scriptTimer = 60;
   image(game3bg,0,0);
   gameState = gameStateCheckPoint + modeCheckPoint;  
   }
  }
  break;
  
  case GAME_END:
  bgm = allPass;
  bgm.play();
  image(gameEnd,0,0);
  if(mouseX >=795 && mouseX <= 925 && mouseY >= 625 && mouseY <= 675){
  image(gameEndHover,0,0);
  if(mousePressed){
    clicked.trigger();
  gameState = 11;
  }
  }
  break;
  }
}

void displayDoll(){
  if(dollCal >=1){image(doll[0],6.88-55,106.61-42);}
  if(dollCal >=2){image(doll[1],126.37-75,139.8-43);}
  if(dollCal >=3){image(doll[2],184.65-55,75.7-40);}
  if(dollCal >=4){image(doll[3],285.37-55,124.71-43);}
  if(dollCal >=5){image(doll[4],391.15-55,75.7-40);}
  if(dollCal >=6){image(doll[5],497.7-55,106.61-45);}
  if(dollCal >=7){image(doll[6],598.98-55,81.12-43);}
  if(dollCal >=8){image(doll[7],715.09-55,124.38-45);}
  if(dollCal >=9){image(doll[8],818.48-55,155.17-43);}
  if(dollCal >=10){image(doll[9],951.02-77,100.37-45);}  
}

void pressedDisplay(){
  if(upPressed == true){
  image(lightPressed,125,height-150);  //upEmptyDirect
}
if(leftPressed == true){
  image(lightPressed,10,height-150);
}
if(downPressed == true){
  image(lightPressed,243,height-150);
}
if(rightPressed == true){
  image(lightPressed,355,height-150);
}
  
}


void keyPressed(){
  
 if(key==CODED){
   switch(keyCode){
         case UP:
         upPressed=true;
         
         break;
         case DOWN:
         downPressed=true;
                 
         break;
         case LEFT:
         leftPressed=true;
         
         break;
         case RIGHT:        
         rightPressed=true;
         
         break;
         }           
 }else{
   if(key=='b'){
      gameState -=10;
    }
    if(key=='n'){
      gameState +=10;
    }
    if(key=='w'){
     song1.pause(); 
     song2.pause(); 
     song3.pause();
     perfectCal = 666;
     goodCal = 0;
     okCal = 0;
     missCal = 0;
     gameState = 6;
     gameTimer = 0;
     
    }
    if(key=='l'){
     song1.pause(); 
     song2.pause(); 
     song3.pause();
     perfectCal = 0;
     goodCal = 0;
     okCal = 0;
     missCal = 666;
     gameState = 7;
     gameTimer = 0;
    }
    if(key=='r'){
     rainEffectControl = !rainEffectControl;
    }
 }
}

void keyReleased(){
  if(key==CODED){
   switch(keyCode){
         case UP:
         upPressed=false;
         
         break;
         case DOWN:
         downPressed=false;
         
         break;
         case LEFT:
         leftPressed=false;
         
         break;
         case RIGHT:        
         rightPressed=false;
         
         break;
         }           
 } 
}
//Thanks for our beloved group members and players!