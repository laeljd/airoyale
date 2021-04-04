public class Layer {
  private List<Neuron> neurons;

  public Layer (neurons) {
    this.neurons = neurons;
  }

  public List<Signal> getSignals () {
    return this.neurons;
  }

  public List<Signal> process () {
    for (Neuron neuron : this.neurons) {
      neuron.process();
    }
  }
}
