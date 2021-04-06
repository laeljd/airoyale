public class LocationSensorDirection implements ISignal {

  private Agent agent;
  private IPosition target;

  // debuggers
  private DebugManager dm;
  public boolean debug = false;
  public color dye = color(255);

  // constructor default
  public LocationSensorDirection (Agent agent, IPosition target, DebugManager dm, color dye) {
    this.agent = agent;
    this.target = target;
    this.dm = dm;
    this.dye = dye == 0 ? color(255) : dye;
  }

  public float getSignal() {

    float dx = this.target.getPosition().x - this.agent.getPosition().x;
    float dy = this.target.getPosition().y - this.agent.getPosition().y;
    float targetDirection = degrees(atan2(dy, dx));

    float agentDirectionMod = this.agent.getDirection() % 360;
    float agentPositiveAngle = agentDirectionMod < 0 ? 360 - abs(agentDirectionMod) : agentDirectionMod;

    float diff = agentPositiveAngle - targetDirection; 
  
    diff = abs(diff % 360) > 180 ? 180 - abs(diff % 180) : abs(diff % 180);
    diff = (diff-90)/90;

    if(this.debug) {
      pushMatrix();
        stroke(this.dye);
        translate(this.agent.getPosition().x, this.agent.getPosition().y);
        rotate(radians(targetDirection));
        line(0, 0, dist(this.agent.getPosition().x, this.agent.getPosition().y, this.target.getPosition().x, this.target.getPosition().y), 0);
      popMatrix();

      this.dm.debug("targer angle: ", String.valueOf(targetDirection), this.dm.getPosition(), this.dye);
      this.dm.debug("agent angle: ", String.valueOf(agentPositiveAngle), this.dm.getPosition(), this.dye);
      this.dm.debug("diff agent/target: ", String.valueOf(diff), this.dm.getPosition(), this.dye);
    }

    return diff;
  }
  
  public void setDebug(boolean debug) {
    this.debug = debug;
  }
}
