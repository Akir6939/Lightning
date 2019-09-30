void setup()
{
  ellipseMode(CENTER);
  size(700,700);
  frameRate(60);
  Target t = new Target();
  tarArr.add(t);
}

int score = 0;

public class Target{
  public color fillCol;
  public boolean got;
  private int deathTime;
  private float x,y;
  public Target(){
    fillCol = color((int)(Math.random()*255),(int)(Math.random()*255),(int)(Math.random()*255));
    got = false;
    deathTime = frameCount+150;
    x = (float)(Math.random()*670);
    y = (float)(Math.random()*670);
  }
  public void show(){//draws the target
    fill(fillCol);
    ellipse(x,y,40,40);
  }
  public void hit(){//checks if user has hit the target
    if((Math.abs(this.x-mouseX)<=20)&&(Math.abs(this.y-mouseY)<=20)){
      this.x+=1000;
      this.y=this.x;
      got = true;
      score++;
    }
  }
  public void expire(int time){
    if(this.deathTime==time&&!got){
      textSize(18);
      fill(255,255,0);
      text("You lose",200,200);
      text("Score: "+score,200,220);
      noLoop();
    }
  }
}

ArrayList<Target> tarArr = new ArrayList<Target>();

void newTarget(int frame){
  if(frame%30==0){
    Target t = new Target();
    tarArr.add(t);
  }
}

void cleanse(){
  if(tarArr.size()!=0){
    for(Target t : tarArr){
      if(t.got)
      tarArr.remove(t);
    }
  }
}

void showScore(){
  textSize(18);
  fill(255,255,0);
  text(score,675,15);
}

void draw() 
{
  background(0);
  fill(255);
  ellipse(mouseX,mouseY,20,20);
  noCursor();
  newTarget(frameCount);
  stroke(255);
  for(Target t : tarArr){
    t.hit();
    t.show();
    t.expire(frameCount);
  }
  showScore();
}
