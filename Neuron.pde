public class Neuron implements ISignal {
  private List<Dendrite> dendrites;
  private float axon;
  
  public Neuron (List<Dendrite> dendrites) {
    this.dendrites = dendrites;
  }

  public void process() {
    float axon = 0;
    for (Dendrite dendrite : this.dendrites) {
      axon += dendrite.getValue() * dendrite.getGene();
    }
    this.axon = axon;
  }

  public float getSignal() {
    return this.axon;
  }
}
