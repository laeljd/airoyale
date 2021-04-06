public class DebugManager {

  private PVector position;
  private int direction;
  private List<DebugObj> debugQueue = new ArrayList<DebugObj>();
  private float offset;
  
  // constructor defaut
  public DebugManager (PVector position, float offset, boolean reverse) {
    this.direction = reverse ? -1 : 1;
    this.offset = offset;
    this.position = position;
  }

  // register debug
  public void debug (String label, String value, PVector position, color dye) {
    this.debugQueue.add(new DebugObj(label, value, position, dye));
  }

  // draw debugs
  public void draw () {
    int index = 0;
    for(DebugObj obj : this.debugQueue){
      writeDebug(
        obj.label,
        String.valueOf(obj.value),
        new PVector(obj.position.x, obj.position.y + offset),
        (this.direction * index++),
         obj.dye);
    }
    this.debugQueue = new ArrayList<DebugObj>();
  }

  private void writeDebug(String label, String value, PVector position, int line, color dye) {
    fill(dye);
    textAlign(RIGHT);
    text(label, position.x, position.y + (line * 20));
    textAlign(LEFT);
    text(value, position.x, position.y + (line * 20));
  }  
  
  public PVector getPosition() {
    return this.position;
  }
}

public class DebugObj {
  public color dye;
  public String label;
  public String value;
  public PVector position;

  public DebugObj(String label, String value, PVector position, color dye) {
    this.dye = dye;
    this.label = label;
    this.value = value;
    this.position = position;
  }  
}