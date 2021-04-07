public class Brain {
  private List<ISignal> sensors;
  private List<IAction> actions;
  private List<Layer> layers;
  private float[] genes;
  private int nNeurons;
  private int nLayers;

  // debugging props
  public boolean debug = false;
  public int debugX = 50;
  public int debugY = 50;
  public int verticalOffset = 100;
  public int horizontalOffset = 200;
  public int dotsSize = 50;
  public color dye = color(255);

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
      float geneValue = geneIndex < this.genes.length ? this.genes[geneIndex] : 1; // 1: otherwise it will return a 0 to the action //<>// //<>//
 
      Dendrite dendrite = new Dendrite(signal, geneValue);

      dendrites.add(dendrite);
    }

    return dendrites;
  }

  public void generateLayers(List<ISignal> signals) {
    for (int currentLayer = 0; currentLayer < this.nLayers - 1; currentLayer++) {
      List<Neuron> neurons = new ArrayList<Neuron>();
      for (int currentNeuron = 0; currentNeuron < this.nNeurons / (this.nLayers - 1); currentNeuron++) {

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
    for (ISignal sensor : this.sensors) {
      sensor.process();
    }
    
    for (Layer layer : this.layers) {
      layer.process();
    }

    List<ISignal> lastSignals = this.layers.get(this.nLayers - 1).getSignals();

    for (int currentAction = 0; currentAction < this.actions.size(); currentAction++) {
      ISignal actionSignal = lastSignals.get(currentAction);
      this.actions.get(currentAction).setSignal(actionSignal);
      this.actions.get(currentAction).activate();
    }

    if (this.debug) this.debug();
  }

  public void setDebug (boolean debug) {
    this.debug = debug;
  }

  private void debug () {
    // draw sensors
    stroke(this.dye);
    strokeWeight(2);
    for (int currentSensor = 0; currentSensor < this.sensors.size(); currentSensor++) {
      int x = debugX - this.dotsSize / 2;
      int y = (debugY + (currentSensor * this.verticalOffset)) - this.dotsSize / 2;

      noFill();
      rect(x, y, this.dotsSize, this.dotsSize);

      float value = this.sensors.get(currentSensor).getSignal();
      fill(this.dye);
      textAlign(CENTER, CENTER);
      text(String.format("%.3f", value), x + this.dotsSize / 2, y + this.dotsSize / 2);
    }

    // draw layers
    for (int currentLayer = 0; currentLayer < this.layers.size(); ++currentLayer) {
      List<Neuron> neurons = this.layers.get(currentLayer).getNeurons();
      for (int currentNeuron = 0; currentNeuron < neurons.size(); ++currentNeuron) {
        int x = debugX + this.horizontalOffset + (currentLayer * this.horizontalOffset);
        int y = debugY + (currentNeuron * this.verticalOffset);

        noFill();
        ellipse(x, y, this.dotsSize, this.dotsSize);

        float value = neurons.get(currentNeuron).getSignal();
        fill(this.dye);
        textAlign(CENTER, CENTER);
        text(String.format("%.3f", value), x, y);
      }
    }

    // draw actions
    int actionsOffset = this.horizontalOffset + this.layers.size() * this.horizontalOffset;
    for (int currentAction = 0; currentAction < this.actions.size(); currentAction++) {
      int x = debugX - this.dotsSize / 2 + actionsOffset;
      int y = (debugY + (currentAction * this.verticalOffset)) - this.dotsSize / 2;

      noFill();
      rect(x, y, this.dotsSize, this.dotsSize);

      float value = this.actions.get(currentAction).getValue();
      fill(this.dye);
      textAlign(CENTER, CENTER);
      text(String.format("%.3f", value), x + this.dotsSize / 2, y + this.dotsSize / 2);
    }
  }
}
