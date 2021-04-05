public class Dendrite {
  private ISignal signal;
  private float gene;

  public Dendrite (ISignal signal, float gene) {
   this.signal = signal;
   this.gene = gene; 
  }

  public float getValue () {
    return this.signal.getSignal();
  }

  public float getGene () {
    return this.gene;
  }
}
