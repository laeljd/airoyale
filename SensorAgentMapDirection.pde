public class SensorAgentMapDirection implements ISignal {
  private Agent agent;
  private FireRing fireRing;

  public SensorAgentMapDirection (Agent agent, FireRing fireRing) {
    this.agent = agent;
    this.fireRing = fireRing;
  }

  public float getSignal() {
    float direction =  (float)Math.atan2((this.agent.getPosition().x - fireRing.getPosition().x), (this.agent.getPosition().y - fireRing.getPosition().y));
    writeDebug("", String.valueOf(direction), new PVector(this.agent.getPosition().x , this.agent.getPosition().y), -2, color(255));
    return direction;
  }
}
