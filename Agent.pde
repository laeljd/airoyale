public class Agent {
  private PVector position;
  private int size;
  private boolean render = true;
  
  public Agent() {
    this.position = new PVector(0, 0);
    this.size = 30;
  }
  
  public Agent(PVector position, int size) {
    this.position = position;
    this.size = size;
  }
  
  public void update() {
    
    if (this.render) {
      this.draw();
    }
  }
  
  private void draw() {
    fill(255);
    noStroke();
    ellipse(this.position.x, this.position.y, size, size);
  }
  
  public void setRender(boolean render) {
    this.render = render;
  }
  
  public PVector getPosition() {
    return this.position;
  }
}
