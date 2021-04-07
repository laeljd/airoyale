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
    this.agent.spin(this.signal.getSignal() * 10);
  }
}
