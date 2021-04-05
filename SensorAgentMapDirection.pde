public class SensorAgentMapDirection implements ISignal {
  private Agent agent;
  private FireRing fireRing;

  public SensorAgentMapDirection (Agent agent, FireRing fireRing) {
    this.agent = agent;
    this.fireRing = fireRing;
  }

  public float getSignal() {
    float direction = (float)Math.atan2((this.agent.getPosition().y - fireRing.getPosition().y), (this.agent.getPosition().x - fireRing.getPosition().x));
    float directionMap = map(direction, (float)-Math.PI, (float)Math.PI, 0, 360);
    float agentDirection = this.agent.getDirection() % 360;
    float diff = abs(agentDirection - directionMap);

    stroke(255, 0, 0);
    float ringX = 0;
    float ringY = 0;
    line(this.agent.getPosition().x, this.agent.getPosition().y, ringX, ringY);

    stroke(255, 255, 0);
    float agentX = cos(radians(agentDirection)) * 50 + this.agent.getPosition().x;
    float agentY = sin(radians(agentDirection)) * 50 + this.agent.getPosition().y;
    
    line(this.agent.getPosition().x, this.agent.getPosition().y, agentX, agentY);

    float angle = atan2(abs(0 - this.agent.getPosition().y), abs(0 - this.agent.getPosition().x)) - atan2(abs(agentY - this.agent.getPosition().y), abs(agentX - this.agent.getPosition().x));
    angle = angle * 180 / (float)Math.PI;
    
    float hyp = dist(this.agent.getPosition().x, this.agent.getPosition().y, fireRing.getPosition().x, fireRing.getPosition().y);
    writeDebug("Ring Direction", String.valueOf(directionMap), new PVector(this.agent.getPosition().x , this.agent.getPosition().y), -5, color(255));
    writeDebug("Agent Direction", String.valueOf(agentDirection), new PVector(this.agent.getPosition().x , this.agent.getPosition().y), -6, color(255));
    writeDebug("Difference", String.valueOf(diff), new PVector(this.agent.getPosition().x , this.agent.getPosition().y), -7, color(255));
    writeDebug("Distance", String.valueOf(hyp), new PVector(this.agent.getPosition().x , this.agent.getPosition().y), -8, color(255));
    writeDebug("Angle", String.valueOf(angle), new PVector(this.agent.getPosition().x , this.agent.getPosition().y), -9, color(255));
    writeDebug("Future Point", String.valueOf(agentX + " : " + agentY), new PVector(this.agent.getPosition().x , this.agent.getPosition().y), -12, color(255));
    return diff;
  }
}
