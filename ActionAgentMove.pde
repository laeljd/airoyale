public class ActionAgentMove implements IAction {
  private Agent agent;
  private ISignal signal;

  public ActionAgentMove (Agent agent) {
    this.agent = agent;
  }

  public void setSignal(ISignal signal){
    this.signal = signal;
  }

  public void activate() {
    float speed = -(cos((float)Math.PI * this.signal.getSignal()) - 3.2) / 2;
    this.agent.setSpeed(this.signal.getSignal()*9);
  }
}
