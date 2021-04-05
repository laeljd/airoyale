public class ActionAgentMove implements IAction {
  private Agent agent;
  private List<ISignal> signal;

  public ActionAgentMove (Agent agent) {
    this.agent = agent;
  }

  public void setSignals(List<ISignal> signal){
    this.signal = signal;
  }

  public void activate(){
    float synapse = 0;
    for (ISignal signal : this.signal) {
      synapse += signal.getSignal();
    }

    if(synapse > 0){
      this.agent.move();
    }
  }
}
