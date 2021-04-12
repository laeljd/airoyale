interface IAction {
  public String getName();
  public void setSignal(ISignal signal);
  public float getValue();
  public void activate();
}

interface ISignal {
  public String getName();
  public float getSignal();
  public void process();
  public void setDebug(boolean debug);
}

interface IPosition {
  public String getName();
  public PVector getPosition();
}
