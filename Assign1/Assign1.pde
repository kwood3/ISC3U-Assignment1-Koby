/***************************************************************************
 Assignment 1 for ISC3U
 Written by Koby W.
 April 25, 2018
 
 What the program is: This program contains 2 modules; 
 1. Math game - User is given an addition question, if the user gets it correct +1 score, if not -1 score
 2. Maze game - user must use arrow keys to move the circle to the end of the maze.
 
 Functions:
 
 Classes:
 
 ****************************************************************************/



Button math_button;                    // menu screen button to switch to math screen
Button maze_button;                    // menu screen button to switch to maze screen
Button increaseValue;                  // math screen button to increase value
Button decreaseValue;                  // math screen button to decrease value
Button checkAns;                       // Check answer button in math screen
Button menuScreen;                     // Button to go back to menu screen
Button exitBtn;                        // Button @ menu screen to exit application
player user;                           // Circle that user moves in maze
wall[] walls;                          // Walls in maze

int state = 0;                         // [state #0 = Intro][state #1 = Menu] [state #2 = math] [state #3 = maze] 
String menuText ="";                   // menu screen text
int value = 0;                         // value of user input @ math screen
int qValue1 = (int) random(10);        // Expression value #1
int qValue2 = (int) random(10);        // Expression value #2
int score = 0;                         // score for both Math screen and Maze screen
int circle1x = 600;
int circle2x = 0;
int circleSize = 10;

void setup() {
  background(255);
  //introCircles();
  size (600, 600);
  fill(0);
  textSize(30);
  text("Assignment 1 by Koby W", 120, 300);
  //print("state: ", state);
  //smooth();
  math_button   = new Button("Math Problem", 390, 400, 200, 100);
  maze_button   = new Button("Maze", 10, 400, 200, 100);
  exitBtn       = new Button("Exit", 280, 500, 60, 60);

  increaseValue = new Button("+", 300, 500, 50, 50);
  decreaseValue = new Button("-", 400, 500, 50, 50);
  checkAns      = new Button("Check Answer", 320, 430, 200, 50);
  menuScreen    = new Button("Menu", 100, 500, 60, 60);
}

void draw() {
  /*
  
   Intro
   
   */

  if (state == 0) {
    introCircles();
    fill(255);
    textSize(20);
    text("Click Anywhere to continue!", 50, 550);
  }

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
    } else if (exitBtn.MouseIsOver()) {
      fill(0);
      menuText = "Exit the application";
      //print("mouseisover = true for exitBtn");
    } else {
      background(255); // hide text if mouse is not over button
    }
    // Drawing buttons to screen
    math_button.Draw();
    maze_button.Draw();
    exitBtn.Draw();
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
    menuScreen.Draw();
  }
  /*
  
   
   Maze Screen
   
   
   */
  else if (state == 3) {
    background(255);
    
    user     = new player(50,300);
    walls    = new wall[2];
    walls[0] = new wall(250,0,50,300);
    walls[1] = new wall(370,25,50,300);
  }
}
/* 
 
 Mouse click event (mainly used for buttons)
 
 */
void mousePressed() {

  if (state == 0) {
    state = 1;
  }
  //math button @ menu screen
  if (math_button.MouseIsOver() && state == 1) {
    background(255);
    print("Clicked: Math Problem @ Menu, ");
    print("Launching Math problem screen");
    createQuestion();
    state = 2;
  }
  //maze button @ menu screen
  if (maze_button.MouseIsOver() && state == 1) {
    print("Clicked: Maze @ Menu");
    print("Launching Maze screen");
    state = 3;
  }

  //increase value button @ math screen
  if (increaseValue.MouseIsOver() && state == 2) { 
    value++;
    //print(" value: ", value);
  }

  //decrease value button @ math screen
  if (decreaseValue.MouseIsOver() && state == 2) {
    value--;
    //print(" value: ", value);
  }

  //check answer button @ math screen
  if (checkAns.MouseIsOver() && state == 2) {
    print(" User Clicked checkAns ");
    print("Answer is ", qValue1 + qValue2);
    if (value == qValue1 + qValue2) {
      print(" Correct ");
      score++;
      fill(10, 200, 10);
      //text("Correct!", 300, 300);
      createQuestion();
    } else if (value != qValue1 + qValue2) { // checks if user input does not equal to qValue1 + qValue2
      score--;
      fill(10, 10, 200);
      //text("Wrong!", 300, 300);
    }
  }

  if (menuScreen.MouseIsOver() && state == 2) {
    state = 1;
    print(" Going back to menu ");
  }

  if (exitBtn.MouseIsOver() && state == 1) {
    exit();
    print(" User clicked exit ");
  }
}

/*

 Functions and Classes
 
 */

//function for intro animation
void introCircles() {

  if (state == 0) {
    loop();
    //print(circle1x);

    circle1x -= 20;
    circle2x += 20;
    circleSize += 20;

    fill(0);
    ellipse(circle1x, 680, circleSize, circleSize);
    ellipse(circle2x, -80, circleSize, circleSize);
    //print("Commencing intro animation");
  } else {
    noLoop();
    print("State is = 0 but not running animation");
  }
}

//function that creates question
void createQuestion() {
  background(255);
  int qValue1 = (int) random(10);    //Expression value #1
  int qValue2 = (int) random(10);    //Expression value #2
  print(" qValue1: ", qValue1);
  print(" qValue2: ", qValue2);
}

//player class for maze
class player {

  float x;
  float y;

  player(float _x, float _y) {
    x = _x;
    y = _y;
  }

  void Draw() {
    fill(0);
    ellipse(x, y, 30, 30);
  }

  //function to move player
  void move(wall[] walls) {
    float playerX = x;
    float playerY = y;

    if (keyPressed==true) {
      print(key);

      if (key==LEFT) {
        playerX -= 5;
      } else if (key==UP) {
        playerY += 5;
      } else if (key==DOWN) {
        playerY -= 5;
      } else if (key==RIGHT) {
        playerX += 5;
      }
    }
    //boolean to check if player collides with wall
    boolean didCollide = false;
    for (int i = 0; i < walls.length; i++) {
      if (playerX > walls[i].x && playerX < (walls[i].x + walls[i].w) && playerY > walls[i].y && playerY < walls[i].y + walls[i].h) {
        didCollide = true;
      }
    }

    if (didCollide == false) {
      x = playerX;
      y = playerY;
    }
  }
}  

//wall class for maze
class wall {

  float x;
  float y;
  float w;
  float h;

  //constructor
  wall(float _x, float _y, float _w, float _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }

  void Draw() {
    fill(100);
    rect(x, y, w, h);
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

  void Draw() { // function to draw the button
    fill(218);
    stroke(141);
    rect(x, y, w, h, 10);
    textAlign(CENTER, CENTER);
    fill(0);
    text(label, x + (w / 2), y + (h / 2));
    textSize(20);
  }

  boolean MouseIsOver() { // if mouse is over button it returns true, if not then false
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    } 
    return false;
  }
}
