public class Brain {
  private List<Signal> sensors;
  private List<Action> actions;
  private List<Layer> layers;
  private float genes;
  private int nNeurons;
  private int nLayers;

  public Brain (List<Signal> sensors, float[] genes, int nLayers, List<Action> actions) {
    this.sensors = sensors;
    this.genes = genes;
    this.nLayers = nLayers;
    this.actions = actions;
    this.nNeurons = sensors.size() * nLayers;
  }

  // get the dendites of the current neuron from the current layer
  private List<Dendrite> getLayerDendrites(int layerIndex, int currentNeuron, List<Signal> signals) {
    List<Dendrite> dendrites;
    int signalsSize = signals.size();
    
    // for each neuron to generate the list of dendrites
    for (int currentSignal = 0; currentSignal < signalsSize; currentSignal++) {
      // get value of receiver
      float signal = signals.get(currentSignal);

      float currentGene = this.genes[1 + (2 * 1) + (2 + 1 * 0)];

      // offset to not repeat the genes
      int layerOffset = ((signalsSize * nNeurons) * layerIndex);

      float currentGene = this.genes[currentSignal + (signalsSize * currentNeuron) + layerOffset];

      // get the respective gene from the list of gene without repeating
      float gene = (this.genes.length - 1 < currentSignal) ? currentGene : 0;

      Dendrite dendrite = new Dendrite(signal, gene);

      dendrites.add(dendrite);
    }

    return dendrites;
  }

  public void generateLayers(List<Signal> signals) {
    for (int currentLayer = 0; currentLayer < this.nLayers; currentLayer++) {
      List<Neuron> neurons;
      for (int currentNeuron = 0; currentNeuron < this.nNeurons; currentNeuron++) {

        List<Signal> axons = currentLayer > 0 ? this.layers[currentLayer - 1].getSignals() : signals;
        
        List<Dendrite> dendrites = this.getLayerDendrites(currentLayer, currentNeuron, axons);

        Neuron neuron = new Neuron(dendrites);
        neurons.add(neuron);
      }
      Layer layer = new Layer(neurons);
      this.layers.add(layer);
    }
  }

  public void think () {
    for (Dendrite layer : this.layers) {
      layer.process();
    }

    List<Signal> lastSignals = this.layers[this.nLayers - 1].getSignals();

    for (Action action : this.actions) {
      action.setSignals(lastSignals);
      action.activate();
    }
  }
}
