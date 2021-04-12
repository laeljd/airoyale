public class Neuron implements ISignal {
  private String id;
  private List<Dendrite> dendrites;
  private float axon;
  private float value;

   // debuggers
  public boolean debug = false;

  public Neuron (List<Dendrite> dendrites, String id) {
    this.dendrites = dendrites;
    this.id = id;
  }

  public void process() {
    float axon = 0;
    for (Dendrite dendrite : this.dendrites) { 
      axon += dendrite.getValue() * dendrite.getGene();
    }
     
    this.axon = axon; 
    // this.axon = (float)Math.tanh(this.axon);
    // this.axon = (float)Math.sinh(this.axon);
  }

  public float getSignal() {
    return this.axon;
  }

  public void setDebug(boolean debug) {
    this.debug = debug;
  }

  public String getName(){
    return this.id;
  }
}
