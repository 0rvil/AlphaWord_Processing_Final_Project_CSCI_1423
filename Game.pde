/**
 Game is an object that can create a new game, display an end message, or exit the app on game completion.
 */

static String[] row1 = new String[]{"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"};
static String[] row2 = new String[]{"A", "S", "D", "F", "G", "H", "J", "K", "L"};
static String[] row3 = new String[]{"Z", "X", "C", "V", "B", "N", "M"};
static String[][] rows = {row1, row2, row3};

class Game {
  // Atrributes
  String solution;
  String guess;
  ArrayList<String> guesses;
  WordGrid grid;
  Boolean isFinished;
  boolean submit;
  boolean overNewGameBtn;
  color newGameBtnClr;
  boolean overExitBtn;
  color exitBtnClr;
  boolean delayDisplay;
  int gridHeightCoord;
  int numOfGuesses;
  boolean won;
  boolean hasPlayed;
  List<List<Letter>> rowsList;

  // Constructor
  Game(String currentGuess, int guessesAllowed, int solutionType) {

    switch(solutionType) {
    case 0:
      solution = getSolution(summerList);
      break;
    case 1:
      solution = getSolution(autumnList);
      break;
    case 2:
      solution = getSolution(winterList);
      break;
    default:
      solution = getSolution(wordList);
    }

    guess = currentGuess;
    isFinished = false;
    submit = false;
    overNewGameBtn = false;
    newGameBtnClr = #6AAA64;
    overExitBtn = false;
    exitBtnClr = #797c7e;
    gridHeightCoord = 50;
    numOfGuesses = guessesAllowed;
    won = false;
    hasPlayed = false;
    rowsList = Arrays.stream(rows)
      .map(row -> Arrays.stream(row)
      .map(letter -> new Letter(letter, ""))
      .collect(Collectors.toList()))
      .collect(Collectors.toList());
    guesses = new ArrayList<String>();
    grid = new WordGrid(solution, guesses);
  }


  /** Method for clearing the screen, showing two buttons, and a final message */
  void displayFinished() {
    pushMatrix();
    fill(#FEFEFC);
    rect(0, 0, 1000, 800);

    translate(width/3, height/3);

    fill(color(#0f0f0f));
    textSize(50);
    text(finishedMSG(), 290 / 2, 100 / 2);

    fill(newGameBtnClr);
    rect(290/3 - 70, 150, 100, 5000/145, 20);

    fill(color(#FEFEFC));
    textSize(20);
    text("New Game", 290/2 - 70, 167.5);

    fill(exitBtnClr);
    rect(290/3 + 70, 150, 100, 5000/145, 20);

    fill(color(#FEFEFC));
    textSize(20);
    text("Main Menu", 290/2 + 70, 167.5);

    popMatrix();
  }

  /** Method from Button Example, where it updates the state of a button if the mouse cursor is over the button */
  void update() {
    if (overButton(width/3 + 290/3 - 70, height/3 + 150, 100, 5000/145)) {
      overNewGameBtn = true;
    } else {
      overNewGameBtn = false;
    }

    if (overButton(width/3 + 290/3 + 70, height/3 + 150, 100, 5000/145)) {
      overExitBtn = true;
    } else {
      overExitBtn = false;
    }
  }

  /** Method from Button Example, used to determine if the mouse is over a set of coordinates */
  boolean overButton(int x, int y, int width, int height) {
    if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }

  /** Method for controling the Finished display of the game */
  void controlFinishedDisplay() {
    displayFinished();
    update();

    if (overNewGameBtn) {
      newGameBtnClr = #8FD888;
    } else {
      newGameBtnClr = #6AAA64;
    }

    if (overExitBtn) {
      exitBtnClr = #AFAFAF;
    } else {
      exitBtnClr = #797c7e;
    }
  }

  /** Method for determining the final message based on the size of the guesses arraylist and if the solution was found */
  String finishedMSG() {
    String msg;
    if (guesses.get(guesses.size() - 1).toUpperCase().equals(solution)) {
      switch(guesses.size()) {
      case 1:
        msg = "Genius";
        break;
      case 2:
        msg = "Magnificent";
        break;
      case 3:
        msg = "Impressive";
        break;
      case 4:
        msg = "Splendid";
        break;
      case 5:
        msg = "Great";
        break;
      case 6:
        msg = "Phew";
        break;
      default:
        msg = "Correct";
      }
    } else {
      msg = "The word was: " + solution;
    }
    return msg;
  }
}


/** Method for displaying a blank grid, this grid is drawn over as the user makes guesses */
void EmptyGrid() {
  int h = mygame.gridHeightCoord;
  for (int i = 0; i < mygame.numOfGuesses; i++) {
    renderRow(h);
    h += 60;
  }
}

void renderRow(int h) {
  int i = width / 3 + 20;
  for (int j = 0; j < 5; j ++) {
    displayBlank(i, h);
    i += 60;
  }
}

void displayBlank(int x, int y) {
  pushMatrix();
  translate(x, y);
  strokeWeight(2);
  stroke(#e2e2e2);
  rect(0, 0, 50, 50);
  noStroke();
  popMatrix();
}
