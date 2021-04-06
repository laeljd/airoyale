public class FireRing implements IPosition{
  private PVector position;
  private float radius;
  private float minRadius;
  private float maxRadius;
  private float velocityShrink;
  private float damage;
  private boolean render = true;

  // debuggers
  private DebugManager dm;
  public boolean debug = false;
  public color dye = color(255, 0, 0);
  
  // contructor defaut
  public FireRing() {
    this.position = new PVector(0, 0);
    this.radius = 100;
    this.velocityShrink = 0;
    this.damage = 0;
  }
  
  // contructor
  public FireRing(PVector position, float minRadius, float maxRadius, float velocityShrink, float damage, DebugManager dm) {
    this.position = position;
    this.minRadius = minRadius;
    this.maxRadius = maxRadius;
    this.radius = maxRadius;
    this.velocityShrink = velocityShrink;
    this.damage = damage;
    this.dm = dm;
  }
  
  public void update() {
    if (this.radius > 0) {
      if(this.radius > this.minRadius){
        this.radius -= this.velocityShrink;
      }
    }
    
    if (this.render) {
      this.draw();
    } 
    
    if (this.debug) {
      this.dm.debug("Ring radius: ", String.valueOf(this.radius), this.dm.getPosition(), this.dye);
      this.dm.debug("Ring position: ", "( " + this.position.x + " , " + this.position.y + " )", this.dm.getPosition(), this.dye);
    }
  }
  
  private void draw() {
    noFill();
    stroke(this.dye);
    circle(this.position.x, this.position.y, this.radius * 2);
  }
  
  private boolean isPointOutside(PVector point) {
    float x1 = abs(point.x - this.position.x);
    float x2 = abs(point.y - this.position.y);

    return (x1 * x1) + (x2 * x2) > (this.radius * this.radius);
  }

  private void dealDamage(List<Agent> agents) {
    for (Agent agent : agents) {
      if (isPointOutside(agent.position)) {
        agent.takeDamage(damage);
      }
    }
  }
  
  private void writeDebug(String label, String value, PVector position, int line) {
    fill(this.dye);
    textAlign(RIGHT);
    text(label, position.x, position.y + (line * 20));
    textAlign(LEFT);
    text(value, position.x, position.y + (line * 20));
  }
  
  // getters and setters
  public float getDamage() { return this.damage; }
  public void setDamage(float damage) { this.damage = damage; }
    
  public PVector getPosition() { return this.position; }

  public void setRender(boolean render) { this.render = render; }
  
  public float getRadius() { return this.radius; }
  public void setRadius(float radius) { this.radius = radius; }
  
  public float getVelocityShrink() { return this.velocityShrink; }
  public void setVelocityShrink(float velocityShrink) { this.velocityShrink = velocityShrink; }  

   public void setDebug(boolean debug) { this.debug = debug; }
}
