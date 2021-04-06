interface IAction {
  public void setSignal(ISignal signal);
  public void activate();
}

interface ISignal {
  public float getSignal();
  public void setDebug(boolean debug);
}

interface IPosition {
  public PVector getPosition();
}