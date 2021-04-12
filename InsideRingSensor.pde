public class InsideRingSensor implements ISignal {

  private Agent agent;
  private FireRing fireRing;
  private float value;

  // debuggers
  private DebugManager dm;
  public boolean debug = false;
  public color dye = color(255);

  // constructor default
  public InsideRingSensor (Agent agent, FireRing fireRing, DebugManager dm, color dye) {
    this.agent = agent;
    this.fireRing = fireRing;
    this.dm = dm;
    this.dye = dye == 0 ? color(255) : dye;
  }
  
  public void process () {
    float agentX = this.agent.getPosition().x;
    float agentY = this.agent.getPosition().y;
    float fireRingX = this.fireRing.getPosition().x;
    float fireRingY = this.fireRing.getPosition().y;
    float ringRadius = this.fireRing.getRadius();
    
    boolean isInside = pow(agentX - fireRingX, 2) + pow(agentY - fireRingY, 2) < (ringRadius * ringRadius);
    
    if(this.debug) {
      this.dm.debug("sensor: ", this.getName(), this.dm.getPosition(), this.dye);
      this.dm.debug("is inside: ", String.valueOf(isInside), this.dm.getPosition(), this.dye);
    }
    // this.value = isInside ? 1 : -1;
    this.value = (pow(agentX - fireRingX, 2) + pow(agentY - fireRingY, 2)) / (ringRadius * ringRadius);
    this.value = -(float)Math.tanh((this.value * 2) - 1);
    // this.value = (float)Math.tanh(this.value);
  }

  public float getSignal() {
    return this.value;
  }
  
  public void setDebug(boolean debug) {
    this.debug = debug;
  }

  public String getName(){
    return "inside ring";
  }
}
