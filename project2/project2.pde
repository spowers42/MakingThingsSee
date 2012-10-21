//Making Things See 
//project 2
//
//Read the depth sensor and camera data and display the images
import SimpleOpenNI.*;
SimpleOpenNI kinect;

void setup()
{
  size(640*2, 480);
  kinect = new SimpleOpenNI(this);
  
  kinect.enableDepth();
  kinect.enableRGB();
}

void draw()
{
  kinect.update();
  image(kinect.depthImage(), 0, 0);
  image(kinect.rgbImage(), 640, 0);
}
