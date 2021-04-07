interface IAction {
  public void setSignal(ISignal signal);
  public float getValue();
  public void activate();
}

interface ISignal {
  public float getSignal();
  public void process();
  public void setDebug(boolean debug);
}

interface IPosition {
  public PVector getPosition();
}
