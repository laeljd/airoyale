public class RingBorderProximitySensor implements ISignal {

  private Agent agent;
  private FireRing fireRing;
  private float value;

  // debuggers
  private DebugManager dm;
  public boolean debug = false;
  public color dye = color(255);

  // constructor default
  public RingBorderProximitySensor (Agent agent, FireRing fireRing, DebugManager dm, color dye) {
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
    
    this.value = (ringRadius - dist(agentX, agentY, fireRingX, fireRingY)) / ringRadius;
    
    if(this.debug) {
      this.dm.debug("border proximity: ", String.valueOf(this.value), this.dm.getPosition(), this.dye);
    }
  }

  public float getSignal() {
    return this.value;
  }
  
  public void setDebug(boolean debug) {
    this.debug = debug;
  }
}
