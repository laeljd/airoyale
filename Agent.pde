public class Agent {
  private PVector position;
  private int size;
  private boolean render = true;
  private int direction = 0;
  private float speed = 1;
  private float health = 100;
  private boolean alive = true;

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
    if (!this.alive) {
      return;
    }

    this.move();

    if (this.render) {
      this.draw();
    }
  }
  
  private void draw() {
    fill(255, map(this.health, 0, 100, 0, 255));
    noStroke();

    pushMatrix();

    translate(this.position.x, this.position.y);
    rotate(radians(this.direction));
    triangle(this.pointerSize, -this.pointerSize, this.pointerlength, 0, this.pointerSize, this.pointerSize);
    ellipse(0, 0, size, size);

    popMatrix();
  }
  
  private void move() {
    float angle = radians(this.direction);
    float x = cos(angle) * this.speed;
    float y = sin(angle) * this.speed;

    this.position.x += x;
    this.position.y += y;
  }
  
  public void setRender(boolean render) {
    this.render = render;
  }
  
  public PVector getPosition() {
    return this.position;
  }

  public void takeDamage(float damage) {
    if(this.alive) {
      this.health -= damage;
    }

    if (this.health <= 0) {
      this.alive = false;
    }
  }
}
