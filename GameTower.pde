class Tower {
  int level;
  int score;
  boolean gameOver;
  
  Tower() {
    level = 0;
    score = 0;
    gameOver = false;
  }

  void nextLevel() {
    level ++;
  }

  void increaseScore(int points) {
    score += points;
  }

  int getLevel() {
    return level;
  }

  int getScore() {
    return score;
  }

  boolean getGameState() {
    return gameOver;
  }

  void setGameOver() {
    gameOver = true;
  }

  int guessesAllowed() {
    int glevel = level + 1;
    if (glevel <= 5) {
      return  6;
    } else if (glevel <= 7) {
      return  5;
    } else if (glevel == 8) {
      return  4;
    } else {
      return 3;
    }
  }

}



class TowerGame extends Game {

  Tower tol;

  TowerGame(String currentGuess, Tower twr) {
    super(currentGuess, twr.guessesAllowed(), -1);
    tol = twr;
  }

  @Override
  /** Method for clearing the screen, showing two buttons, and a final message */
    void displayFinished() {

    fill(#FEFEFC);
    rect(0, 0, 1000, 800);
    pushMatrix();
    translate(width/3, height/3);
    fill(newGameBtnClr);
    rect(290/3 - 70, 150, 100, 5000/145, 20);

    fill(color(#FEFEFC));
    textSize(20);
    text(activeBtnMsg(), 290/2 - 70, 167.5);

    fill(exitBtnClr);
    rect(290/3 + 70, 150, 100, 5000/145, 20);

    fill(color(#FEFEFC));
    textSize(20);
    text("Main Menu", 290/2 + 70, 167.5);

    popMatrix();

    if (tol.level <= 9) {

      pushMatrix();
      translate(width/3, height/3);

      fill(color(#0f0f0f));
      textSize(75);
      text("Score: " + String.valueOf(tol.getScore()), 290 / 2, 100 / 2 - 100 );
      textSize(50);
      text(finishedMSG(), 290 / 2, 100 / 2);

      popMatrix();
    } else {
      pushMatrix();
      translate(width/3, height/3);

      fill(color(#0f0f0f));
      textSize(75);
      text("You saved Princess Lexicon!", 290 / 2, 100 / 2 - 100 );
      textSize(50);
      text("Final Score: " + String.valueOf(tol.getScore()), 290 / 2, 100 / 2);

      popMatrix();
    }
    
  }

  String activeBtnMsg() {
    String msg;
    if (tol.getGameState()) {
      msg = "Try Again";
    } else {
      if (tol.level == 10) {
        msg = "Play Again";
      } else {
        msg = "Continue";
      }
    }
    return msg;
  }


  /** Method for determining the final message based on if the level was passed or not*/
  @Override
    String finishedMSG() {
    String msg;
    if (guesses.get(guesses.size() - 1).toUpperCase().equals(solution)) {
      msg = "Level " + String.valueOf(tol.getLevel()) + " complete!";
    } else {
      msg = "The word was: " + solution;
    }
    return msg;
  }
}
