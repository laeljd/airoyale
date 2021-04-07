public class ActionAgentMove implements IAction {
  private Agent agent;
  private ISignal signal;
  private float value;

  public ActionAgentMove (Agent agent) {
    this.agent = agent;
  }

  public void setSignal(ISignal signal){
    this.signal = signal;
  }

  public float getValue() {
    return this.value;
  }

  public void activate() {
    // float speed = -(cos((float)Math.PI * this.signal.getSignal()) - 3.2) / 2;
    float speed = this.signal.getSignal() * 10;
    this.value = speed;
    this.agent.setSpeed(speed);
  }
}
