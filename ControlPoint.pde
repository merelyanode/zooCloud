/* Xe annotated
 * ControlPoint.pde
 * ----------------
 * Sets up a bouncing ball that reflects off the edges of the canvas.
 * The coordinates of the ball are passed to the SPhere item by the PApplet
 * and serve as inputs to the update (rotate) method there.
 * The control point has methods to ease towards the mouse when it moves.
 *
 * Code by Gauden Galea, 12 September 2010
 * Released under CC-GNU GPL license v2.0 or later
 * The license is viewable here: http://creativecommons.org/licenses/GPL/2.0/
 */


class ControlPoint {
  PVector loc, vel, target;
  float easing = 0.05;
  final int LOOPING = 0;
  final int CONTROLLING = 1;
  int mode;

  // three variables used when looping
  float angle = -PI; // start angle to loop
  float dA = TWO_PI / 1500; // step for each cycle of the loop
  //float dA =  PI; // step for each cycle of the loop
  float radius = width / 4; // radius of looping circle
 

  ControlPoint() {
    loc = new PVector( (float) width/2, (float) height/2 );
    vel = new PVector( 0.3, 0.4 );
    target = new PVector( -1, -1);
    mode = CONTROLLING;
    //    vel = new PVector( random(0.5, 1.5),   random(0.5, 1.5) );
  }

  void update() {
    switch(mode) {
    case LOOPING: 
      updateLooper(); 
      break;
    case CONTROLLING: 
      updateController(); 
      break;
    }
  }

  void updateLooper() {
    //angle += dA;
    loc.x = width/2 + radius * cos(angle);
    loc.y = height/2 + radius * sin(angle);
  }

  void updateController() {
    // if the control point is tracking the mouse, then ease it towards the target
    // if not tracking, then just keep going until mouse moves
    if (target.x == -1) {
      loc.add(vel);
      // do some boundary checks 
      // if the control point is going to cross its limits, then reflect it
      if (loc.x + vel.x < 0) { 
        vel.x = -vel.x;
      }
      if (loc.x + vel.x > width) { 
        vel.x = -vel.x;
      }
      if (loc.y + vel.y < 0) { 
        vel.y = -vel.y;
      }
      if (loc.y + vel.y > height) { 
        vel.y = -vel.y;
      }
    } 
    else {
      float dx = (target.x - loc.x) * easing;
      loc.x += dx;
      float dy = (target.y - loc.y) * easing;
      loc.y += dy;
      // if the control point gets within 20 pixels of the mouse, 
      // stop tracking the mouse till it moves again.
      // Note: the 20 pixels is arbitrary, determined by trial 
      // and error to reduce sudden changes in velocity when contro point reaches mouse
      if (loc.x - target.x < 20 && loc.y - target.y < 20) {
        target = new PVector( -1, -1);
      }
    }
  }

  void toggleMode() {
    switch(mode) {
    case LOOPING: 
      mode = CONTROLLING; 
      break;
    case CONTROLLING: 
      mode = LOOPING; 
      break;
    }
  }

  float getX() {
    return loc.x;
  }

  float getY() {
    return loc.y;
  }

  void setLoc(float x, float y) {
    loc = new PVector(x, y);
  }

  void setTarget(float x, float y) {
    target = new PVector(x, y);
    float dx = x - loc.x;
    float dy = y - loc.y;
    float denom = max(dx, dy);
    float vx = dx / abs( denom );
    float vy = dy / abs( denom );
    while ( max(abs(vx), abs(vy)) > 0.8 ) {
      vx *= 0.9;
      vy *= 0.9;
    }
    vel = new PVector( vx, vy );
  }

  void render() {
    // used for visualisation of the control point during debugging
    pushStyle();
    pushMatrix();
    translate( loc.x, loc.y );
    fill(255,255,0);
    ellipse(0,0, 5, 5);
    popMatrix();
    popStyle();
  }
}

