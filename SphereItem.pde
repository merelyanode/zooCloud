/* Xe annotated
 * SphereItem.pde
 * --------------
 * Creates individual particles that are arrayed around the parent sphere.
 * Capable of displaying as a plain cirlce or as a small bitmap.
 *
 * Adapted from the tutorial by Jer Thorp
 * at http://blog.blprnt.com/blog/blprnt/processing-tutorial-spherical-coordinates
 * Jer's code released under CC-GNU GPL license v2.0 or later,
 * The license is viewable here: http://creativecommons.org/licenses/GPL/2.0/
 *
 * Adapted from Gauden Galea's NCD Logo
 * Gauden's code released under CC-GNU GPL license v2.0 or later
 */


class SphereItem {
  Sphere parentSphere; //Sphere object that holds this item

  int CIRCLE = 0;
  int ICON = 1;
  int mode = CIRCLE;

  //Spherical Coordinates
  float radius;
  float theta;
  float phi;
  //Speed properties
  //Xe ¿What do these settings affect?
  float thetaSpeed = 0;
  float phiSpeed = 0;
  //Size and color
  //Xe declares variable that will hold the value of sphereItem size
  float itemSize;
  // List of possible colours
  ArrayList colors = new ArrayList();
  //Xe assigns the "color" datatype to a variable named "clr"
  color clr;

  public void SphereItem() {
  }

  public void init() {  
    //Xe defines an array of possibe spereItem colors
    /*
    color[] colors = {
      color(162, 209, 215), // light blue bg circle 4
      color(235, 34, 40), // scarlet circle 0
      color(27, 86, 162), // dark blue circle 1
      color(235, 0, 139), // purple circle 2
      color(79, 116, 186) // medium blue circle 3
      */
      //add transparency to colors
      color[] colors = {
      color(162, 209, 215, 175), // light blue bg circle 4
      color(235, 34, 40, 175), // scarlet circle 0
      color(27, 86, 162, 175), // dark blue circle 1
      color(235, 0, 139, 175), // purple circle 2
      color(79, 116, 186, 175) // medium blue circle 3
    };
    //Set the fill colour //Xe by assigning a random color from the color array to it
    clr = colors [ (int) random(0, colors.length) ];
  }
//#
  public void render(int m) {
    //Get the radius from the parent Sphere
    float r = parentSphere.radius;
    //Convert spherical coordinates into Cartesian coordinates

    float x = cos(theta) * sin(phi) * r;
    float y = sin(theta) * sin(phi) * r;
    float z = cos(phi) * r;
    
    //float x = cos(theta) * sin(phi) * r/1.8;
    //float y = sin(theta) * sin(phi) * r/10;
    //float z = cos(phi) * r/8;
     /*
    println("theta =" + theta);
    println("phi =" + phi);
    //println(3 * -1);
    */
    //How big is the radius? --> r = 140.0
    //println("x = " + x);
    //println("y= " + y);
    //println("z= " + z);
          
    //Mark our 3d space
    pushMatrix();
    //Move to the position of this item
    translate(x,y,z);
    rotateY(-phi); // these two rotate functions might be changed to find tangent plane
    rotateZ(-phi);
    //Xe evaluates whether to use "icon mode" or "circle mode"
    if (m == CIRCLE) {
      fill( clr ); 
      noStroke();
      // Draw a circle
      //ellipse(0,0,itemSize,itemSize);
      // Draw a sphere
      sphere(itemSize);
    } 
    else {
      // Put up a bitmap representation of the logo
      image(parentSphere.icon, 0, 0, itemSize, itemSize);
    }
    //Go back to our position in 3d space
    popMatrix();
  }
}

