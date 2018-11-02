PImage img, imgOrig;
int numRects = 10;
float getOdds = 0.8;
float addOdds = 0.01;
float multOdds = 0.15;
int alpha = 127;

void setup() {
  size(50, 50, P2D);
  frameRate(24);
  img = loadImage("test.jpg");
  imgOrig = img.get();
  surface.setSize(img.width/2, img.height/2);
  rectMode(CENTER);
  
  setupBloom();
}

void draw() { 
  tex.beginDraw();
  tex.blendMode(NORMAL);
  tex.noTint();
  tex.image(img, 0, 0, tex.width, tex.height);
  
  tex.tint(255,int(random(alpha/2, alpha)));
  for (int i=0; i<numRects; i++) {
    int sx = int(random(0, tex.width));
    int sy = int(random(0, tex.height));
    int sw = int(random(0, tex.width));
    int sh = int(random(0, tex.height));
    
    int dx = int(random(-tex.width/2, tex.width + (tex.width/2)));
    int dy = int(random(-tex.height/2, tex.height + (tex.height/2)));
    
    PImage temp = img.get(sx,sy,sw,sh);
       
    if (random(0,1)<addOdds) {
      tex.blendMode(ADD);
    } else {
      tex.blendMode(NORMAL);
    }
    
    tex.image(temp, dx, dy);
  }
  
  if (random(0,1)<multOdds) {
    tex.blendMode(MULTIPLY);
    tex.tint(255,1);
  } else {
    tex.blendMode(NORMAL);
    tex.tint(255,5);
  }
  tex.image(imgOrig, 0, 0, tex.width, tex.height);
  
  if (random(0,1) < getOdds) img = tex.get();
  tex.endDraw();
  
  drawBloom();
}
