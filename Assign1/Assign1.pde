Button math_button;    //menu screen button to switch to math screen
Button maze_button;    //menu screen button to switch to maze screen
Button increaseValue;  //math screen button to increase value
Button decreaseValue;  //math screen button to decrease value
Button checkAns;       //Check answer button in math screen

int state = 1;          // [state #1 = Menu] [state #2 = math] [state #3 = maze] If any other value = close app 
String menuText ="";    //menu screen text
int value = 0;
int qValue1 = (int) random(10);      //Expression value #1
int qValue2 = (int) random(10);    //Expression value #2
int score = 0;          //score for both Math screen and Maze screen

void setup() {
  size (600, 600);
  //print("state: ", state);
  //smooth();
  math_button = new Button("Math Problem", 390, 400, 200, 100);
  maze_button = new Button("Maze", 10, 400, 200, 100);

  increaseValue = new Button("+", 300, 500, 50, 50);
  decreaseValue = new Button("-", 400, 500, 50, 50);
  checkAns      = new Button("Check Answer", 320, 430, 200, 50);
}

void draw() {
  /* 
   
   
   Menu Screen
   
   
   */
  if (state == 1) {

    // draw text if mouse is over button
    if (math_button.MouseIsOver()) {
      fill(0);
      menuText = "Go to Math Problem Screen";
      text(menuText, 300, 300);
    } else if (maze_button.MouseIsOver()) {
      fill(0);
      menuText = "Go to Maze Screen";
      text(menuText, 300, 300);
    } else {
      background(255); // hide text if mouse is not over button
    }
    // draw the button in the window
    math_button.Draw();
    maze_button.Draw();
  } 
  /*
      
   
   Math Screen
   
   
   */
  else if (state == 2) {
    background(255);
    text(value, 375, 520);
    text(qValue1, 200, 200);
    text("+", 230, 200);
    text(qValue2, 260, 200);
    increaseValue.Draw();
    decreaseValue.Draw();
    checkAns.Draw();
  }
  /*
  
   
   Maze Screen
   
   
   */
  else if (state == 3) {
    int rectX = (int) random(500);
    int rectY = (int) random(500);
    rect(rectX, rectY, 90, 90);
    if (mouseX > rectX && mouseX < (rectX + 500) && mouseY > rectY && mouseY < (rectY + 90)) {
      //if mouse is inside the rectangle
    }
  }
}
// mouse button clicked
void mousePressed() {

  if (math_button.MouseIsOver() && state == 1) {
    background(255);
    print("Clicked: Math Problem @ Menu, ");
    print("Launching Math problem screen");
    //launch("Assign1/mathScreen.pde");
    createQuestion();
    state = 2;
  }
  if (maze_button.MouseIsOver() && state == 1) {
    print("Clicked: Maze @ Menu");
    print("Launching Maze screen");
    state = 3;
    drawDots();
  }

  if (increaseValue.MouseIsOver() && state == 2) { 
    value++;
    //print(" value: ", value);
  }

  if (decreaseValue.MouseIsOver() && state == 2) {
    value--;
    //print(" value: ", value);
  }

  if (checkAns.MouseIsOver() && state == 2) {
    print(" User Clicked checkAns ");
    print("Answer is ", qValue1 + qValue2);
    if (value == qValue1 + qValue2) {
      print(" Correct ");
      score++;
      fill(10, 200, 10);
      //text("Correct!", 300, 300);
      createQuestion();
    } else if (value != qValue1 + qValue2) {
      score--;
      fill(10, 10, 200);
      //text("Wrong!", 300, 300);
    }
  }
}
//function that creates dots and displays to screen
void drawDots() {
  background(255);
  fill(0);
  ellipse(mouseX, mouseY, 50, 50);
}
//function that creates question
void createQuestion() {
  background(255);
  int qValue1 = (int) random(10);      //Expression value #1
  int qValue2 = (int) random(10);    //Expression value #2
  print(" qValue1: ", qValue1);
  print(" qValue2: ", qValue2);
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
    textSize(20);
  }

  boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    } 
    return false;
  }
}