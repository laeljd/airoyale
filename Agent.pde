public class Agent {
  private PVector position;
  private int size;
  private boolean render = true;
  private int direction = 0;

  private float pointerSize;
  private float pointerlength;
  
  public Agent() {
    this.position = new PVector(0, 0);
    this.size = 30;

    this.pointerSize = this.size / 3;
    this.pointerlength = this.size / 1.2;
  }
  
  public Agent(PVector position, int size) {
    this.position = position;
    this.size = size;

    this.pointerSize = this.size / 3;
    this.pointerlength = this.size / 1.2;
  }
  
  public void update() {
    
    if (this.render) {
      this.draw();
    }
  }
  
  private void draw() {
    fill(255);
    noStroke();

    pushMatrix();

    translate(this.position.x, this.position.y);
    rotate(radians(this.direction));
    triangle(this.pointerSize, -this.pointerSize, this.pointerlength, 0, this.pointerSize, this.pointerSize);
    ellipse(0, 0, size, size);

    popMatrix();
  }
  
  public void setRender(boolean render) {
    this.render = render;
  }
  
  public PVector getPosition() {
    return this.position;
  }
}
