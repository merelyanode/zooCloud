/* Xe annotated
 * Sphere.pde
 * ----------
 * Creates a parent object to hold a series of smaller items arrayed randomly on its surface
 * Has methods to rotate the whole globe, the inner mesh, and to manage the contained items.
 *
 * Adapted from the tutorial by Jer Thorp
 * at http://blog.blprnt.com/blog/blprnt/processing-tutorial-spherical-coordinates
 * Jer's code released under CC-GNU GPL license v2.0 or later,
 * The license is viewable here: http://creativecommons.org/licenses/GPL/2.0/
 *
 * Adapted from Gauden Galea, 12 September 2010
 * Gauden's code also released under CC-GNU GPL license v2.0 or later
 */


class Sphere {
  float xPos; //X Position of the Sphere
  float yPos; //Y Position of the Sphere
  float zPos; //Z Position of the Sphere
  float radius; //Radius of the Sphere
  //Xe These are the SphereItems. They are defined as a part of the "Sphere" class
  ArrayList items = new ArrayList(); //List of all of the items contained in the Sphere
  //Xe The "icon" is defined as a part of the "Sphere" class
  //PImage icon; // holds the icon of the action plan logo
 
   //Xe The "mode" (circle v. icon) is delcared here and may be altered here by exchanging the value of "CIRCLE" and "ICON"
  int CIRCLE = 0;
  int ICON = 1;
  int mode = CIRCLE;

//Xe ¿How do the Sphere attributes defined here relate to the "Sphere" class of which they are a part? 
//Xe Is this just a new Sphere class object that happens to be named "Sphere"?
  Sphere(float xPos, float yPos, float zPos, float radius) { 
    this.xPos = xPos; //X Position of the Sphere
    this.yPos = yPos; //Y Position of the Sphere
    this.zPos = zPos; //Z Position of the Sphere
    this.radius = radius; //Radius of the Sphere
    icon = loadImage("icon.png");
  }
   
  public void toggleMode() {
      //Xe evaluates whether to use "icon mode" or "circle mode"//Xe this line seems have no consequence in any way.
    mode = (mode == CIRCLE) ? ICON : CIRCLE;
  }
  //The positions of the sphereItems are defined here
  //Xe where is the value of "diam" declared? Is it part of the opengl lib?
  public void addSphereItem(int diam) {
    //Make a new SphereItem
    SphereItem si = new SphereItem();
    //Set the parent sphere
    si.parentSphere = this;
    //Set random values for the spherical coordinates...//Xe ...of each SphereItem. All these values designate surface coordinates ONLY
    // using the method on http://mathworld.wolfram.com/SpherePointPicking.html
    //Xe Create two variables, u and v, to use for defining the spherical coordinates (functions of theta and phi)  of each sphereItem
    float u = random(0,1);
    float v = random(0,1);
    si.theta = TWO_PI * u;
    si.phi = acos(2 * v - 1);
    // set size
    //si.itemSize = random(1, diam);
    //XL increase the maximum size of the particles
    si.itemSize = random(1, 30);
    //Add the new sphere item to the end of our ArrayList
    items.add(items.size(), si);
    si.init();
  }

  public void render(float x, float y) {
    //Mark our position in 3d space
   
  pushMatrix();
    //Move to the center point of the sphere
    translate(xPos, yPos, zPos);
      float phi = map(x, 0, width, 0, TWO_PI);
     rotateY(phi);
     float theta = map(y, 0, width, 0, TWO_PI);
    //XL faster rotation -->
    //XL float theta = map(y, 0, width, 0, PI*100);
    rotateX(theta);

    // render the inner mesh as a symbol of the globe
    renderMesh();
    
    //Render each SphereItem
    //Xe XL temporarily commented this out -->
    for (int i = 0; i < items.size(); i ++) {
       SphereItem si = (SphereItem) items.get(i);
       si.render(mode);
     };
     
     
    //Go back to our original position in 3d space
    popMatrix();
  }

  public void renderMesh() {
    // Draw the inner circles of longitude 
    //Xe the Longitude Mesh is defined and iterated here
    int steps = 10;
    pushStyle();
    pushMatrix();
    noFill();
    stroke(150);
    //Xe divides the area of the sphere into equal sized angular slices. The number of slices == steps
    float angle = PI/steps;
    for (int i = 0; i < steps; i++) {
      rotateY( angle );
      ellipse(0, 0, radius*2-20, radius*2-20);
    }
    popMatrix();
    popStyle();
  }
}

