public class SensorAgentMapDirection implements ISignal {
  private Agent agent;
  private FireRing fireRing;

  public SensorAgentMapDirection (Agent agent, FireRing fireRing) {
    this.agent = agent;
    this.fireRing = fireRing;
  }

  public float getSignal() {

    float dx = fireRing.getPosition().x - this.agent.getPosition().x;
    float dy = fireRing.getPosition().y - this.agent.getPosition().y;
    float radians = atan2(dy, dx); // -PI a PI
    float angle = degrees(radians);


    float circularDirection = (this.agent.getDirection() % 360) < 0 ? 360 - abs(this.agent.getDirection() % 360) : (this.agent.getDirection() % 360);
    float agentDirection =  radians(circularDirection); // -PI a PI
    float agentAngle = degrees(agentDirection);
    float diff = agentAngle - angle;
  
    diff = abs(diff % 360) > 180 ? 180 - abs(diff % 180) : abs(diff % 180);

    pushMatrix();
      stroke(0, 255, 255);
      translate(this.agent.getPosition().x, this.agent.getPosition().y);
      rotate(radians);
      line(0, 0, 100, 0);
    popMatrix();

    pushMatrix();
      stroke(255, 0, 255);
      translate(this.agent.getPosition().x, this.agent.getPosition().y);
      rotate(agentDirection);
      line(0, 0, 100, 0);
    popMatrix();
    stroke(255, 255, 0);

    stroke(255, 255, 0);
    writeDebug("angle: ", String.valueOf(angle), new PVector(this.agent.getPosition().x , this.agent.getPosition().y), -5, color(255));
    writeDebug("agent angle: ", String.valueOf(agentAngle), new PVector(this.agent.getPosition().x , this.agent.getPosition().y), -6, color(255));
    writeDebug("Difference", String.valueOf(diff), new PVector(this.agent.getPosition().x , this.agent.getPosition().y), -7, color(255));
    return diff;
  }
}
