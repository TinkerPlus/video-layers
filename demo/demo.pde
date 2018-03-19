import processing.video.*;

Capture cam;
Movie movie;

int xspacing = 16;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave

float theta = 0.0;  // Start angle at 0
float amplitude = 75.0;  // Height of wave
float period = 500.0;  // How many pixels before the wave repeats
float dx;  // Value for incrementing X, a function of period and xspacing
float[] yvalues;  // Using an array to store height values for the wave

void setup(){
  size(640, 480);
  cam = new Capture(this, 640, 480, 30);
  cam.start();
  
  movie = new Movie(this, "Diffusion_Choir.mp4");
  movie.play();
  
  w = width+16;
  dx = (TWO_PI / period) * xspacing;
  yvalues = new float[w/xspacing];
}

void captureEvent(Capture cam){
  cam.read();
}

void movieEvent(Movie movie){
  movie.read();
}

void draw(){
  background(0);
  //tint(255, mouseY, mouseY);
  
  tint(255, 255);
  image(movie,0,0);
  
  tint(255, 100);
  image(cam, 0, 0);
  
  fill(150, 50);
  calcWave();
  renderWave();
}


void calcWave() {
  // Increment theta (try different values for 'angular velocity' here
  theta += 0.02;
  amplitude = mouseX * 0.1;
  // For every x value, calculate a y value with sine function
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x)*amplitude;
    x+=dx;
  }
}

void renderWave() {
  noStroke();
  fill(255,0,0,150);
  // A simple way to draw the wave with an ellipse at each location
  for (int x = 0; x < yvalues.length; x++) {
    ellipse(x*xspacing, height/2+yvalues[x], 16, 16);
  }
}