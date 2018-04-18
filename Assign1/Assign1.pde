Button math_button;  
Button maze_button;
int state = 1; // [state #1 = Menu] [state #2 = math] [state #3 = maze] If any other value = close app 


void setup() {
  size (600, 600);
  print("state:", state);
  //smooth();
}

void draw() {
  /* 
      Menu Screen
  */
  if (state == 1) {
    //Buttons
    math_button = new Button("Math Problem", 390, 400, 200, 100);
    maze_button = new Button("Maze", 10, 400, 200, 100);
    // draw text if mouse is over button
    if (math_button.MouseIsOver()) {
      fill(255);
      text("Go to Math Problem Screen", 400, 100);
    } else if (maze_button.MouseIsOver()) {
      fill(255);
      text("Go to Maze Screen", 200, 100);
    } else {
      // hide text if mouse is not over button
      background(0);
    }
    // draw the button in the window
    math_button.Draw();
    maze_button.Draw();
  } 
  /*
      Math Screen
  */
  else if (state == 2){
    background(0);
    
  }
  /*
      Maze Screen
  */
  else if (state == 3){
    background(0);
  }
}
// mouse button clicked
void mousePressed()
{
  // print to console when clicked
  if (math_button.MouseIsOver()) {
    print("Clicked: Math Problem @ Menu, ");
    print("Launching Math problem screen");
    //launch("Assign1/mathScreen.pde");
    state = 2;
  }
  if (maze_button.MouseIsOver()) {
    print("  Clicked: Maze @ Menu");
  }
}

// the Button class
class Button {
  String label; // button label
  float x;      // top left corner x position
  float y;      // top left corner y position
  float w;      // width of button
  float h;      // height of button

  // constructor
  Button(String labelB, float xpos, float ypos, float widthB, float heightB) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
  }

  void Draw() {
    fill(218);
    stroke(141);
    rect(x, y, w, h, 10);
    textAlign(CENTER, CENTER);
    fill(0);
    text(label, x + (w / 2), y + (h / 2));
  }

  boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }
    return false;
  }
}