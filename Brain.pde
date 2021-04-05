public class Brain {
  private List<ISignal> sensors;
  private List<IAction> actions;
  private List<Layer> layers;
  private float[] genes;
  private int nNeurons;
  private int nLayers;

  public Brain (List<ISignal> sensors, float[] genes, int nLayers, List<IAction> actions) {
    this.sensors = sensors;
    this.genes = genes;
    this.nLayers = nLayers;
    this.actions = actions;
    this.nNeurons = sensors.size() * nLayers;
  }

  // get the dendites of the current neuron from the current layer
  private List<Dendrite> getLayerDendrites(int layerIndex, int currentNeuron, List<ISignal> signals) {
    List<Dendrite> dendrites = new ArrayList<Dendrite>();
    int signalsSize = signals.size();
    
    // for each neuron to generate the list of dendrites
    for (int currentSignal = 0; currentSignal < signalsSize; currentSignal++) {
      // get value of receiver
      ISignal signal = signals.get(currentSignal);

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

  public void generateLayers(List<ISignal> signals) {
    for (int currentLayer = 0; currentLayer < this.nLayers; currentLayer++) {
      List<Neuron> neurons = new ArrayList<Neuron>();
      for (int currentNeuron = 0; currentNeuron < this.nNeurons; currentNeuron++) {

        List<ISignal> axons = currentLayer > 0 ? this.layers.get(currentLayer - 1).getSignals() : signals;
        
        List<Dendrite> dendrites = this.getLayerDendrites(currentLayer, currentNeuron, axons);

        Neuron neuron = new Neuron(dendrites);
        neurons.add(neuron);
      }
      Layer layer = new Layer(neurons);
      this.layers.add(layer);
    }
  }

  public void think () {
    for (Layer layer : this.layers) {
      layer.process();
    }

    List<ISignal> lastSignals = this.layers.get(this.nLayers - 1).getSignals();

    for (IAction action : this.actions) {
      action.setSignals(lastSignals);
      action.activate();
    }
  }
}
