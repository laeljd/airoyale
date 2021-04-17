public class OwnSpeedSensor implements ISignal {

  private Agent agent;
  private float value;

  // debuggers
  private DebugManager dm;
  public boolean debug = false;
  public color dye = color(255);

  // constructor default
  public OwnSpeedSensor (Agent agent, DebugManager dm, color dye) {
    this.agent = agent;
    this.dm = dm;
    this.dye = dye == 0 ? color(255) : dye;
  }
  
  public void process () {
    
    this.value = (this.agent.getSpeed() / this.agent.getMaxSpeed() * 2) - 1;
    
    if(this.debug) {
      this.dm.debug("sensor: ", this.getName(), this.dm.getPosition(), this.dye);
      this.dm.debug(this.agent.getName() + " speed: ", String.valueOf(this.value), this.dm.getPosition(), this.dye);
    }
  }

  public float getSignal() {
    return this.value;
  }
  
  public void setDebug(boolean debug) {
    this.debug = debug;
  }

  public String getName() {
    return "agent speed";
  }
}
