import java.util.*;

DebugManager dm;
List<Agent> agents = new ArrayList<Agent>();
FireRing fireRing;
int nAgents = 1000;

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
    Agent agent = new Agent(new PVector(x, y), 15, new float[]{random(-1, 1), random(-1, 1), random(-1, 1), random(-1, 1), random(-1, 1), random(-1, 1), random(-1, 1), random(-1, 1), random(-1, 1), random(-1, 1), random(-1, 1), random(-1, 1), random(-1, 1), random(-1, 1), random(-1, 1), random(-1, 1), random(-1, 1), random(-1, 1)});
    //agent.setDebug(true);
    agent.dye = color(random(50, 255), random(50, 255), random(50, 255));
    agent.rotateTo(random(0, 361));

    // Sensors
    ISignal sensor1 = new LocationSensorDirection(agent, fireRing, agent.dm, agent.dye + 200);
    ISignal sensor2 = new InsideRingSensor(agent, fireRing, agent.dm, agent.dye + 400);
    ISignal sensor3 = new RingBorderProximitySensor(agent, fireRing, agent.dm, agent.dye + 600);
    //sensor1.setDebug(true);
    //sensor2.setDebug(true);
    //sensor3.setDebug(true);
    
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
}



void keyPressed() {
  if (key == 32) loop = !loop;

  if(!loop) writeDebug("pausado. SPACE ou MOUSE 1", "", new PVector(translateX, translateY), -1, color(128, 128, 128));

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

  if(!loop) writeDebug("pausado. SPACE ou MOUSE 1", "", new PVector(translateX, translateY), -1, color(128, 128, 128));

  if(loop) loop(); else noLoop();
}

private void writeDebug(String label, String value, PVector position, int line, color dye) {
    fill(dye);
    textAlign(RIGHT);
    text(label, position.x, position.y + (line * 20));
    textAlign(LEFT);
    text(value, position.x, position.y + (line * 20));
  }
