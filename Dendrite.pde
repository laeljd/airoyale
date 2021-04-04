public class Dendrite {
  private Signal signal;
  private float gene;

  public Dendrite (Signal signal, float gene) {
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
