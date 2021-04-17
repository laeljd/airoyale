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
    this.value = this.signal.getSignal();
    // this.value += Math.signum(this.value);
    this.value = ((float)Math.tanh(this.value)+1)/2 * this.agent.getMaxSpeed(); //0 - 10
    this.agent.setSpeed(this.value);
  }
  
  public String getName() {
    return "move";
  }
}
