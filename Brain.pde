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
    this.nLayers = nLayers + 1; // add 1 because of the last layer (that computes the genes to the action)
    this.actions = actions;
    this.nNeurons = sensors.size() * nLayers;
    this.layers = new ArrayList<Layer>();

    this.generateLayers(this.sensors);
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
      int layerOffset = ((signalsSize * this.nNeurons) * layerIndex);

      int geneIndex = (currentSignal + (signalsSize * currentNeuron) + layerOffset);

      // test if the gene exists, without repeating
      float geneValue = geneIndex < this.genes.length ? this.genes[geneIndex] : 0;

      Dendrite dendrite = new Dendrite(signal, geneValue);

      dendrites.add(dendrite);
    }

    return dendrites;
  }

  public void generateLayers(List<ISignal> signals) {
    for (int currentLayer = 0; currentLayer < this.nLayers - 1; currentLayer++) {
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

    // generate neurons layer for actions
    List<Neuron> neurons = new ArrayList<Neuron>();
    int layerSize = this.layers.size();
    for (int currentAction = 0; currentAction < this.actions.size(); currentAction++) {
      List<ISignal> axons = this.layers.get(layerSize - 1).getSignals();
      List<Dendrite> dendrites = this.getLayerDendrites(layerSize, currentAction, axons);
      Neuron neuron = new Neuron(dendrites);
      neurons.add(neuron);
    }
    Layer layer = new Layer(neurons);
    this.layers.add(layer);
  }

  public void think () {
    for (Layer layer : this.layers) {
      layer.process();
    }

    List<ISignal> lastSignals = this.layers.get(this.nLayers - 1).getSignals();

    for (int currentAction = 0; currentAction < this.actions.size(); currentAction++) {
      ISignal actionSignal = lastSignals.get(currentAction);
      this.actions.get(currentAction).setSignal(actionSignal);
      this.actions.get(currentAction).activate();
    }
  }
}
