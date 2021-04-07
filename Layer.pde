public class Layer {
  private List<Neuron> neurons;

  public Layer (List<Neuron> neurons) {
    this.neurons = neurons;
  }

  public List<ISignal> getSignals () {
    List<ISignal> signals = new ArrayList<ISignal>(); // = new ArrayList<ISignal>(this.neurons);
    for (Neuron neuron : this.neurons) {
      signals.add(neuron);
    }
    return signals;
  }

  public void process () {
    for (Neuron neuron : this.neurons) {
      neuron.process();
    }
  }

  public List<Neuron> getNeurons () {
    return this.neurons;
  }
}