public class Agent {
  private PVector position;
  private int size;
  private boolean render = true;
  private float speed = 1;
  private float health = 100;
  private float direction = 50;
  private boolean alive = true;
  private Brain brain;
  private float[] genes;
  private List<ISignal> sensors;
  private List<IAction> actions;

  private float pointerSize;
  private float pointerlength;

  // debuggers
  public boolean debug = false;
  public color dye = color(255);
  
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

    this.sensors = new ArrayList<ISignal>();

    this.actions = new ArrayList<IAction>();
    this.actions.add(new ActionAgentMove(this));
  }

  public Agent(PVector position, int size, float[] genes) {
    this.position = position;
    this.size = size;
    this.genes = genes;

    this.sensors = new ArrayList<ISignal>();

    this.actions = new ArrayList<IAction>();
    this.actions.add(new ActionAgentMove(this));

    this.pointerSize = this.size / 3;
    this.pointerlength = this.size / 1.2;
  }
  
  public void update() {
    // if (!this.alive) {
    //   return;
    // }

    // this.move();
    this.direction++;
    this.brain.think();

    if (this.render) {
      this.draw();
    }
    
    if (this.debug) {
      this.writeDebug("", String.valueOf(this.health), new PVector(this.position.x -this.size, (this.position.y -this.size)), 0);
      this.writeDebug("Direction: ", String.valueOf(this.direction), new PVector(this.position.x -this.size, (this.position.y -this.size)), -1);
      this.writeDebug("Gene: ", String.valueOf(this.genes[0] + ";" + this.genes[1]), new PVector(this.position.x -this.size, (this.position.y -this.size)), -3);
      this.writeDebug("Position: ", String.valueOf(this.position.x + " : " + this.position.y), new PVector(this.position.x -this.size, (this.position.y -this.size)), -10);
    }
  }
  
  private void draw() {
    fill(this.dye, map(this.health, 0, 100, 0, 255));
    noStroke();

    pushMatrix();
    translate(this.position.x, this.position.y);
    rotate(radians(this.direction));
    triangle(this.pointerSize, -this.pointerSize, this.pointerlength, 0, this.pointerSize, this.pointerSize);
    ellipse(0, 0, size, size);

    popMatrix();
  }
  
  private void move(float speed) {
    float angle = radians(this.direction);
    float x = cos(angle) * speed;
    float y = sin(angle) * speed;

    this.writeDebug("Speed: ", String.valueOf(speed), new PVector(this.position.x -this.size, (this.position.y -this.size)), -2);

    this.position.x += x;
    this.position.y += y;

    this.direction = this.direction;
  }

  public void setSpeed(float speed) {
    this.speed = speed;
  }
  
  public void setRender(boolean render) {
    this.render = render;
  }
  
  public PVector getPosition() {
    return this.position;
  }

  public float getDirection () {
    return this.direction;
  }

  public int getSize() {
    return this.size;
  }

  public void takeDamage(float damage) {
    if(this.alive) {
      this.health -= damage;
    }

    if (this.health <= 0) {
      this.alive = false;
    }
  }

  public void addSensor(ISignal sensor){
    if(sensor == null) return;
    this.sensors.add(sensor);
  }
  
  private void writeDebug(String label, String value, PVector position, int line) {
    fill(this.dye);
    textAlign(RIGHT);
    text(label, position.x, position.y + (line * 20));
    textAlign(LEFT);
    text(value, position.x, position.y + (line * 20));
  }

  public ArrayList<IAction> getActions(){
    ArrayList<IAction> actions = new ArrayList<IAction>();
    actions.add(new ActionAgentMove(this));
    return actions;
  }

  public void wakeUp () {
    this.brain = new Brain(this.sensors, this.genes, 1, this.actions);
  }

  public void rotateTo (float rotation) {
    this.direction = rotation;
  }

}
