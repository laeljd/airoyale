public class Layer {
  private List<Neuron> neurons;

  public Layer (List<Neuron> neurons) {
    this.neurons = neurons;
  }

  public ArrayList<ISignal> getSignals () {
    ArrayList<ISignal> signals =  new ArrayList<ISignal>(this.neurons);
    return signals;
  }

  public void process () {
    for (Neuron neuron : this.neurons) {
      neuron.process();
    }
  }
}