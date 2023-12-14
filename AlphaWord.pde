import processing.serial.*;
import java.util.Arrays;
import java.util.Deque;
import java.util.Collections;
import java.util.Random;
import java.util.List;
import java.util.stream.Collectors;
import processing.sound.*;

//Serial port;
Game mygame;

PImage logo, classicImg, themedImg, towerImg, summerImg, autumnImg, winterImg, summerBG, autumnBG, winterBG, BG;
Card classicMode, themedMode, towerOfLexiMode, summerCard, autumnCard, winterCard;
ArrayList<Card> cards = new ArrayList<Card>();

SoundFile classicMusic, correct, wrong, autumn, summer, winter, mainMenu, tower;
ParticleSystem p1, p2;
boolean load;
int screen, img;
String msg;
Tower tol;
Score[] scores;
JSONObject json;
longBtn ld, menu;

void setup() {
  size(1000, 800);
  background(#FEFEFC);
  windowTitle("Alpha Word");
  noStroke();
  //port = new Serial(this, "/dev/tty.usbmodem142401");
  // Load Assets
  mainMenu = new SoundFile(this, "Assets/main_menu.wav");
  classicMusic = new SoundFile(this, "Assets/game.wav");
  correct = new SoundFile(this, "Assets/correct.mp3");
  wrong = new SoundFile(this, "Assets/wrong.mp3");
  autumn = new SoundFile(this, "Assets/autumn.wav");
  summer = new SoundFile(this, "Assets/summer.wav");
  winter = new SoundFile(this, "Assets/winter.wav");
  tower = new SoundFile(this, "Assets/tower.wav");

  loadData();

  logo = loadImage("AlphaWord.png");
  classicImg = loadImage("classic.png");
  themedImg = loadImage("themesPX.png");
  towerImg = loadImage("towerPX.png");

  summerImg = loadImage("summerPX.png");
  autumnImg = loadImage("autumnPX.png");
  winterImg = loadImage("winterPX.png");

  summerBG = loadImage("summerBG.jpeg");
  autumnBG = loadImage("autumnBG.jpeg");
  winterBG = loadImage("winterBG.jpeg");


  classicMode = new Card(classicImg, "Classic Wordle", "The game as you know it. Get 6 chances to guess a 5-letter word.", "Play", 300, 300, 30, height/3);
  themedMode = new Card(themedImg, "Themed Collections", "Guess the 5-letter word based on a theme.", "Play", 300, 300, 350, height/3);
  towerOfLexiMode = new Card(towerImg, "Tower of Lexicon", "Lexicon has been trapped in a tower. Can you beat all 10 levels and reach the top?", "Play", 300, 300, 670, height/3);

  summerCard = new Card(summerImg, "Summer Collection", "The coconuts are ripe! Can you guess the Summer words in this collection?", "Play", 300, 300, 30, height/3);
  autumnCard = new Card(autumnImg, "Autumn Collection", "The leaves are falling. Can you guess the Autumn words in this collection?", "Play", 300, 300, 350, height/3);
  winterCard = new Card(winterImg, "Winter Collection", "It's snowing! Can you guess the Winter words in this collection?", "Play", 300, 300, 670, height/3);


  cards.add(classicMode);
  cards.add(themedMode);
  cards.add(towerOfLexiMode);

  ld = new longBtn("Leaderboard", 75, 940, 30, 600);
  menu = new longBtn("Menu", 75, 940, 30, 600);


  msg = "Main Menu";
  img = -1;
  mygame = new Game("", 6, img);
  screen = 0;
  load = false;

  p1 = new ParticleSystem(new PVector(width/6, -50));
  p2 = new ParticleSystem(new PVector(width - width/6, -50));
}

void draw() {
  background(#FEFEFC);

  switch(screen) {
  case 0:
    splashScreen();
    break;
  case 1:
    if (msg.equals("Collections")) {
      themedSelection();
    } else {
      menuSelection();
    }
    checkDisplayDelay(2000);
    homeScreen();
    break;
  case 2:
    classicGame();
    break;
  case 3:
    themedGame(img, BG);
    break;
  case 4:
    towerGame();
    break;
  case 5:
    leaderboard();
    break;
  }
}


void splashScreen() {
  if (!load) {
    mygame.delayDisplay = true;
    image(logo, width/4, height / 6);
    screen = 1;
    load = true;
  }
}

void homeScreen() {

  playMenuMusic();
  stopThemedMusic();

  fill(0);
  textAlign(LEFT);
  textSize(100);
  text(msg, width/2 - 225, height/6);
  textSize(20);

  for (Card card : cards) {
    card.display();
    card.update();
  }

  ld.display();
  ld.update();
}

void classicGame() {
  stopMenuMusic();
  if (mygame.isFinished) {
    classicMusic.stop();
    if (mygame.guesses.get(mygame.guesses.size() - 1).toUpperCase().equals(mygame.solution)) {
      mygame.won = true;
    }
    gameCompleteSound();
    checkDisplayDelay(200);
    mygame.controlFinishedDisplay();
  } else {
    playClassicMusic();
    EmptyGrid();
    displayCurrent();
    KeyBoard();
  }

  System.out.println(mygame.solution); // For testing purposes, we print out the solution to the console
}

/** Method for delaying the display  **/
void checkDisplayDelay(int delayTime) {
  if (mygame.delayDisplay) {
    delay(delayTime);
    mygame.delayDisplay = false;
  }
}

/** Method for displaying the keyboard **/
void KeyBoard() {
  int x = 150;
  int y = 450;
  int i = 0;

  for (List<Letter> letterList : mygame.rowsList) {
    for (Letter l : letterList) {
      x += 60;
      l.display(x, y);
    }
    i ++;
    x = 150 + 25 * i;
    if (i == 2) {
      x += 20;
    }
    y += 60;
  }
}

/** Method for drawing the WordRows from the guesses the user has made */
void displayCurrent() {
  int h = mygame.gridHeightCoord;
  for (WordRow row : mygame.grid.wordRows) {
    row.submit(h);
    h += 60;
  }
}

/** Methods for adding the indicated cards to the menu **/
void themedSelection() {
  msg = "Collections";
  cards.clear();
  cards.add(summerCard);
  cards.add(autumnCard);
  cards.add(winterCard);
}

void menuSelection() {
  msg = "Main Menu";
  cards.clear();
  cards.add(classicMode);
  cards.add(themedMode);
  cards.add(towerOfLexiMode);
}

void themedGame(int i, PImage bg) {
  stopMenuMusic();

  bg.resize(1000, 800);
  background(bg);
  p1.addParticle(i);
  p2.addParticle(i);
  p1.run();
  p2.run();

  if (mygame.isFinished) {
    stopThemedMusic();
    if (mygame.guesses.get(mygame.guesses.size() - 1).toUpperCase().equals(mygame.solution)) {
      mygame.won = true;
    }
    gameCompleteSound();
    checkDisplayDelay(200);
    mygame.controlFinishedDisplay();
    p1.particles = new ArrayList<Particle>();
    p2.particles = new ArrayList<Particle>();
  } else {
    switch(i) {
    case 0:
      playSummerMusic();
      break;
    case 1:
      playAutumnMusic();
      break;
    case 2:
      playWinterMusic();
      break;
    }

    EmptyGrid();
    displayCurrent();
    KeyBoard();
  }
  System.out.println(mygame.solution); // For testing purposes, we print out the solution to the console
}

void towerGame() {
  stopMenuMusic();
  PImage bg = loadImage("towerBG.jpeg");
  bg.resize(1000, 800);
  background(bg);
  p1.addParticle(3);
  p2.addParticle(3);
  p1.run();
  p2.run();

  if (tol.getGameState()) {
    tol = new Tower();
  }

  if (mygame.isFinished) {
    stopTowerMusic();
    if (mygame.guesses.get(mygame.guesses.size() - 1).toUpperCase().equals(mygame.solution)) {
      mygame.won = true;
    }
    gameCompleteSound();
    checkDisplayDelay(200);
    mygame.controlFinishedDisplay();
    p1.particles = new ArrayList<Particle>();
    p2.particles = new ArrayList<Particle>();
  } else {
    playTowerMusic();
    EmptyGrid();
    displayCurrent();
    KeyBoard();
  }
  System.out.println(mygame.solution); // For testing purposes, we print out the solution to the console
}

void leaderboard() {

  background(255);
  
  fill(0);
  textAlign(LEFT);
  textSize(100);
  text("Leaderboard", width/2 - 275, height/6);
  textSize(20);

  int x = 65;
  int y = 100;
  int count = 0;
  for (Score s : scores) {
    s.display(x, y);
    x += 80;
    count ++;
    if (count % 5 == 0) {
      x = 65;
      y += 35;
    }
  }

  menu.display();
  menu.update();
  
}
