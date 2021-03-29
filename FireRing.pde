public class FireRing {
  private PVector position;
  private float radius;
  private float velocityShrink;
  private float damage;
  private boolean render = true;
  private boolean debug = false;
  private PVector debugPosition = new PVector(0,0);
  
  public FireRing() {
    this.position = new PVector(0, 0);
    this.radius = 100;
    this.velocityShrink = 0;
    this.damage = 0;
  }
  
  public FireRing(PVector position, float radius, float velocityShrink, float damage) {
    this.position = position;
    this.radius = radius;
    this.velocityShrink = velocityShrink;
    this.damage = damage;
  }
  
  public void update() {
    if (this.radius > 0) {
      this.radius -= this.velocityShrink;
    }
    
    if (this.render) {
      this.draw();
    }
  }
  
  private void draw() {
    if (this.render) {
      noFill();
      stroke(255, 0, 0);
      circle(this.position.x, this.position.y, this.radius);
    }
    
    if (this.debug) {
      this.writeDebug("Ring radius: ", String.valueOf(this.radius), this.debugPosition, 0);
      this.writeDebug("Ring position: ", "( " + this.position.x + " , " + this.position.y + " )", this.debugPosition, 1);
    }
  }
  
  private void writeDebug(String label, String value, PVector position, int line) {
    fill(255);
    textAlign(RIGHT);
    text(label, position.x, position.y + (line * 20));
    textAlign(LEFT);
    text(value, position.x, position.y + (line * 20));
  }
  
  // getters and setters
  public float getDamage() { return this.damage; }
  public void setDamage(float damage) { this.damage = damage; }
  
  public void setDebug(boolean debug) { this.debug = debug; }

  public void setDebugPosition(PVector debugPosition) { this.debugPosition = debugPosition; }
  
  public PVector getPosition() { return this.position; }

  public void setRender(boolean render) { this.render = render; }

  public float getRadius() { return this.radius; }
  public void setRadius(float radius) { this.radius = radius; }
  
  public float getVelocityShrink() { return this.velocityShrink; }
  public void setVelocityShrink(float velocityShrink) { this.velocityShrink = velocityShrink; }  
 
}
