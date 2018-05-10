/***************************************************************************
 Assignment 1 for ISC3U
 Written by Koby W.
 April 20 - 29, 2018
 
 What the program is: This program contains 2 modules; 
 1. Math game - User is given an addition question
 2. Maze game - user must use WASD to move the circle to the end of the maze.
 
 Functions:
 * IntroCircles()   : This function is used when the program is launched.
 * CreateQuestion() : This function creates a addition question for the math screen.
 
 Classes:
 * Button : This class holds the constructer and MouseIsOver() boolean for buttons, the functions for buttons are defined in mousePressed.
 * Wall   : This holds the constructor and draw function for walls.
 * Player : This holds all the functions for the player (movement, draw, collisions).
 
 ****************************************************************************/



Button math_button;                    // menu screen button to switch to math screen
Button maze_button;                    // menu screen button to switch to maze screen
Button increaseValue;                  // math screen button to increase value
Button decreaseValue;                  // math screen button to decrease value
Button checkAns;                       // Check answer button in math screen
Button menuScreen;                     // Button to go back to menu screen (for math screen)
Button menuScreen2;                    // Menu screen button for maze (first menu button didnt work due to bug that could not be resolved, so I made a second for the maze)
Button exitBtn;                        // Button @ menu screen to exit application
player user;                           // Circle that user moves in maze
wall[] walls;                          // Walls in maze

int state = 0;                         // [state #0 = Intro] [state #1 = Menu] [state #2 = math] [state #3 = maze] [state #4 = User is correct screen (for math question)] [state #5 = User is wrong screen (for math question)] [state #6 = Maze winner]
String menuText ="";                   // menu screen text
int value = 0;                         // value of user input @ math screen
int qValue1 = (int) random(10);        // Expression value #1
int qValue2 = (int) random(10);        // Expression value #2
int score = 0;                         // score for both Math screen and Maze screen
int circle1x = 600;                    // Intro animation circle1 x value
int circle2x = 0;                      // Intro animation circle2 x value
int circleSize = 10;                   // Intro animation's circle's size
int timer1 = 0;                        // timer (alternative to delay() which just adds a delay to the entire code rather than adding a delay after the code)

void setup() {
  background(200);
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
  checkAns      = new Button("Check Answer", 0, 430, 200, 50);
  menuScreen    = new Button("Menu", 0, 540, 60, 60);
  menuScreen2   = new Button("Menu", 0, 540, 60, 60);

  user     = new player(50, 300);       // user in maze
  walls    = new wall[9];               // # of walls (Using Arrays)
  walls[0] = new wall(250, 0, 50, 325);
  walls[1] = new wall(0, 370, 300, 50);
  walls[2] = new wall(350, 0, 70, 425);
  walls[3] = new wall(0, 460, 700, 50);
  walls[4] = new wall(465, 375, 250, 50);
  walls[5] = new wall(405, 285, 150, 50);
  walls[6] = new wall(455, 105, 155, 135);
  walls[7] = new wall(405, 45, 160, 30);
  walls[8] = new wall(0, 45, 200, 30);
}

void draw() {
  /*
  
   Intro
   
   */

  if (state == 0) {
    introCircles();
    fill(255);
    textSize(20);
    //text("Click Anywhere to continue!", 50, 550);
    timer1++;
    if (timer1 == 65) {
      state = 1;
      timer1 = 0;
    }
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
      background(200); // hide text if mouse is not over button
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
    background(200);
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
    background(200);
    noStroke();
    user.draw();
    user.move(walls);
    menuScreen2.Draw();

    for (int i = 0; i < walls.length; i++) { //draws all the walls at once, instead of adding a walls[#].draw(); for each wall.
      walls[i].draw();
    }

    fill(0);
    text("Use WASD to move, Dont hit the walls!", 350, 580);

    //winning obj
    fill(0, 255, 20);
    rect(420, 15, 15, 15);
  }
  /*
  
   
   User is Correct Screen
   
   
   */
  else if (state == 4) {
    background(200);
    fill(0, 255, 0);
    textSize(55);
    text("Correct!", 300, 300);
    
    timer1++;
    println("timer: ", timer1);
    if (timer1 == 50) {
      state =2;
      createQuestion();
      timer1 = 0;
    }
  }
  /*
  
   
   User is Wrong Screen
   
   
   */
  else if (state == 5) {
    background(200);
    fill(255, 0, 0);
    textSize(55);
    text("Wrong!", 300, 300);
    timer1++;
    println("timer: ", timer1);
    if (timer1 == 50) {
      state =2;
      createQuestion();
      timer1 = 0;
    }
  }
  /*
  
   
   Maze complete screen
   
   
   */
  else if (state == 6) {
    background(200);
    fill(0, 255, 50);
    textSize(55);
    stroke(10);
    text("Nice!", 300, 300);

    timer1++;
    println("timer: ", timer1);
    if (timer1 == 65) {
      state =1;
      timer1 = 0;
    }
  }
}
/* 
 
 Mouse click event (mainly used for buttons)
 
 */
void mousePressed() {

  /*if (state == 0) {
   state = 1;
   }*/

  //math button @ menu screen
  if (math_button.MouseIsOver() && state == 1) {
    background(200);
    println("Clicked: Math Problem @ Menu, ");
    println("Launching Math problem screen");
    createQuestion();
    state = 2;
  }
  //maze button @ menu screen
  if (maze_button.MouseIsOver() && state == 1) {
    println("Clicked: Maze @ Menu");
    println("Launching Maze screen");
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
    if (isCorrect()) {
      state = 4;
    } else {
      state = 5;
    }
  }

  if (menuScreen.MouseIsOver() && state == 2) {
    state = 1;
    println(" Going back to menu ");
  }

  if (menuScreen2.MouseIsOver() && state == 3) {
    state = 1;
    println(" Going back to menu ");
  }

  if (exitBtn.MouseIsOver() && state == 1) {
    exit();
    println(" User clicked exit ");
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
    println("State is = 0 but not running animation");
  }
}

//function that creates question in math screen
void createQuestion() {
  background(200);
  int qValue1 = (int) random(10);    //Expression value #1
  int qValue2 = (int) random(10);    //Expression value #2
  println(" qValue1: ", qValue1);
  println(" qValue2: ", qValue2);
}

boolean isCorrect() { //boolean to check if user is correct
  if (qValue1 + qValue2 == value) {
    return true;
  } 
  return false;
}

//player class for maze
class player {

  float x;
  float y;

  player(float _x, float _y) {
    x = _x;
    y = _y;
  }

  void draw() {
    fill(0);
    ellipse(x, y, 30, 30);

    if (x > 418 && x < (418 + 15) && y > 10 && y < (10 + 15)) { //checks every frame to see if user is at the end of the maze
      state = 6;
      print("User completed maze, going back to menu");
      x = 50;
      y = 300;
    }
  }
  //function to move player
  void move(wall[] walls) {
    float playerX = x;
    float playerY = y;

    if (keyPressed==true) {
      //print(key);

      if (key=='a') {
        playerX -= 2;
      } else if (key=='w') {
        playerY -= 2;
      } else if (key=='s') {
        playerY += 2;
      } else if (key=='d') {
        playerX += 2;
      }
    }
    //boolean to check if player collides with wall
    boolean didCollide = false;
    for (int i = 0; i < walls.length; i++) {
      if (playerX > walls[i].x && playerX < (walls[i].x + walls[i].w) && playerY > walls[i].y && playerY < walls[i].y + walls[i].h) {
        didCollide = true;
        x = 50;
        y = 300;
        //print("******COLLISION*******");
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

  void draw() {
    noStroke();
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
