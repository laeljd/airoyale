public class Agent implements IPosition {

  // body members
  private Brain brain;
  private float[] genes;
  private List<ISignal> sensors = new ArrayList<ISignal>();
  private List<IAction> actions = new ArrayList<IAction>();

  // situation
  private PVector position;
  private float direction;
  private float speed;
  private float health = 100;
  private boolean alive = true;

  // esthetics
  private boolean render = true;
  private int size;
  private float pointerSize;
  private float pointerlength;

  // debuggers
  public DebugManager dm;
  public boolean debug = false;
  public color dye = color(255);
  
  // constructor defaut
  public Agent() {
    this.position = new PVector(0, 0);
    this.size = 30;

    this.pointerSize = this.size / 3;
    this.pointerlength = this.size / 1.2;
    this.dm = new DebugManager(this.position, -this.size, true);
  }

  // full constructor
  public Agent(PVector position, int size, float[] genes) {
    this.position = position;
    this.size = size;
    this.genes = genes;
    this.pointerSize = this.size / 3;
    this.pointerlength = this.size / 1.2;

    this.actions.add(new ActionAgentMove(this));
    this.dm = new DebugManager(this.position, -this.size, true);
  }
  
  public void update() {
    // if (!this.alive) {
    //   return;
    // }

    // this.direction+=10;

    this.brain.think();
    this.move(this.speed);

    if (this.render) {
      this.draw();
    }
    
    if (this.debug) {
      this.dm.debug("health: ", String.valueOf(this.health), this.position, this.dye);
      this.dm.debug("Direction: ", String.valueOf(this.direction), this.position, this.dye);
      this.dm.debug("Gene: ", String.valueOf(this.genes[0] + ";" + this.genes[1]), this.position, this.dye);
      this.dm.debug("position: ", String.valueOf("( " + (int)this.position.x + " : " + (int)this.position.y + " )"), this.position, this.dye);
      this.dm.debug("speed: ", String.valueOf(this.speed), this.position, this.dye);
    }
    this.dm.draw();
  }
  
  private void draw() {
    fill(this.dye, map(this.health, 0, 100, 50, 255));
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
    
    this.position.x += x;
    this.position.y += y;
  }

  public void setSpeed(float speed) {
    this.speed = speed;
  }

  public float getSpeed() {
    return this.speed;
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

  public void sprin (float rotation) {
    float rotationMod = rotation % 360;
    this.direction += rotationMod;
  }
  
  public void setDebug(boolean debug) {
    this.debug = debug;
  }
}

