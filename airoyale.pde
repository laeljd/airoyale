import java.util.*;

DebugManager dm;
List<Agent> agents = new ArrayList<Agent>();
FireRing fireRing;
int nAgents = 100;

int width = 1024;
int height = 1024;
int translateX = 0;
int translateY = 0;
boolean loop = false;

void setup() {
  size(1024, 1024);
  noLoop();
  dm = new DebugManager(new PVector(150, 150), 0, false);
  fireRing = new FireRing(new PVector(width / 2, height / 2), 100, width/2, 0.5, 1, dm);
  fireRing.dye = color(255, 60, 60);  
  fireRing.setDebug(true);
  
  for (int i = 0; i < nAgents; i++) {
    float x = random(0, width);
    float y = random(0, height);

    float[] genes = new float[10000];    
    for (int j = 0; j < 10000; ++j) {
      genes[j] = random(-1, 1);
    }
    
    Agent agent = new Agent(new PVector(x, y), 15, genes);
    // agent.setDebug(true);
    agent.dye = color(random(50, 255), random(50, 255), random(50, 255));
    agent.rotateTo(random(0, 361));

    // Sensors
    ISignal sensor1 = new LocationSensorDirection(agent, fireRing, agent.dm, agent.dye + 200);
    ISignal sensor2 = new InsideRingSensor(agent, fireRing, agent.dm, agent.dye + 400);
    ISignal sensor3 = new RingBorderProximitySensor(agent, fireRing, agent.dm, agent.dye + 600);
    // sensor1.setDebug(true);
    // sensor2.setDebug(true);
    // sensor3.setDebug(true);
    
    agent.addSensor(sensor1);
    agent.addSensor(sensor2);
    agent.addSensor(sensor3);

    agent.wakeUp();
    agents.add(agent);
  }
  
  agents.get(0).setBrainDebug(true);
}

void draw() {
  background(0);
  translate(translateX, translateY);

  for (Agent agent : agents) {
    agent.update();
  }
  fireRing.update();
  fireRing.dealDamage(agents);
  
  this.dm.draw();
  
  this.fireRing.position.x = mouseX;
  this.fireRing.position.y = mouseY;
}



void keyPressed() {
  if (key == 32) loop = !loop;

  if(!loop) writeDebug("", "pausado. SPACE ou MOUSE 1", new PVector(20, 0), 1, color(255));

  if(loop) loop(); else noLoop();
}

void keyTyped() {
  // println("typed " + int(key) + " " + keyCode);
  if (key == 100) this.agents.get(0).spin(5);
  if (key == 97) this.agents.get(0).spin(-5);
  if (key == 119) this.agents.get(0).move(5);
  if (key == 115) this.agents.get(0).move(-5);
}

void mousePressed() {
  loop = !loop;

  if(!loop) writeDebug("", "pausado. SPACE ou MOUSE 1", new PVector(20, 0), 1, color(255));

  if(loop) loop(); else noLoop();
}

private void writeDebug(String label, String value, PVector position, int line, color dye) {
    fill(dye);
    textAlign(RIGHT);
    text(label, position.x, position.y + (line * 20));
    textAlign(LEFT);
    text(value, position.x, position.y + (line * 20));
  }
