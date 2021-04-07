public class Neuron implements ISignal {
  private List<Dendrite> dendrites;
  private float axon;
  private float value;

   // debuggers
  public boolean debug = false;

  public Neuron (List<Dendrite> dendrites) {
    this.dendrites = dendrites;
  }

  public void process() {
    float axon = 0;
    for (Dendrite dendrite : this.dendrites) { //<>// //<>//
      axon += dendrite.getValue() * dendrite.getGene();
    }
    this.axon = axon; //<>// //<>//
  }

  public float getSignal() {
    float tanh = (float)Math.tanh(this.axon);
    //float derivateFromTanh = (float)Math.sinh(tanh);
    this.value = tanh;
    return this.value;
  }

  public void setDebug(boolean debug) {
    this.debug = debug;
  }
}
