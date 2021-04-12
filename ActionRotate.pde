public class ActionRotate implements IAction {
  private Agent agent;
  private ISignal signal;
  private float value;

  public ActionRotate (Agent agent) {
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
    this.value =  (float)Math.tanh(this.value) + Math.signum(this.value) * 5;
    this.agent.spin(this.value);
  }

  public String getName() {
    return "rotate";
  }
}
