
CorrelationGraph cGraph;

void setup() {
    size(800, 700);
    cGraph = new CorrelationGraph(0,0,800,700);
}

void draw() {
  background(255);
  cGraph.draw();
}

void mouseMoved(){
  cGraph.mouseMoved(mouseX, mouseY);
}

void mousePressed()
{
  cGraph.mousePressed(mouseX, mouseY);
}

