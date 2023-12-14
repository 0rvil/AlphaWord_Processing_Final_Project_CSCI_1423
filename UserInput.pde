/** Method for controlling KeyBoard input and mouse clicks */
void keyPressed() {
  if (mygame.isFinished) {
    return;
  }

  // Controls for pressing backspace; deleting a letter
  if (keyCode == BACKSPACE) {
    if (mygame.guess.length() >= 1) {
      mygame.guess = mygame.guess.substring(0, mygame.guess.length() - 1);
      mygame.grid.updateWordRows(mygame.guesses, false, mygame.guess);
    }
  }
  // Controls for submitting a guess
  if (keyCode == ENTER) {
    if (mygame.guess.isEmpty()) {
      return;
    }
    if (mygame.guesses.size() == mygame.numOfGuesses - 1|| mygame.guess.toUpperCase().equals(mygame.solution)) {
      enter();
      displayCurrent();
      mygame.delayDisplay = true;
      mygame.isFinished = true;
    }
    if (mygame.guesses.size() <= mygame.numOfGuesses - 1 && mygame.guess.length() == 5 && !mygame.guess.contains(" ")) {
      enter();
    }
  }
  // Controls for typing; adding letters
  if ((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z')) {
    if (mygame.guess.length() < 5) {
      mygame.guess += String.valueOf(key);
      mygame.grid.updateWordRows(mygame.guesses, false, mygame.guess);
    }
  }
}

// Method for adding guess to list, clearing guess, and updating display with submit set to true
void enter() {
  mygame.guesses.add(mygame.guess);
  mygame.guess = "";
  mygame.grid.updateWordRows(mygame.guesses, true, mygame.guess);
}

/** Method for creating a new game or exiting the app if a game has finished and the user clicks on an Event button */
void mousePressed() {

  if (!mygame.isFinished && (screen == 2 || screen == 3 || screen == 4)) {
    return;
  }

  if (mygame.isFinished) {
    if (!mygame.overNewGameBtn && !mygame.overExitBtn) {
      return;
    }
  }

  if (screen == 4) {
    if (mygame.overNewGameBtn) {
      if (mygame.isFinished) {
        if (tol.getLevel() == 10) {
          tol = new Tower();
        }
        mygame = new TowerGame("", tol);
      }
    }
  }

  if (screen != 4) {
    if (mygame.overNewGameBtn) {
      if (mygame.isFinished) {
        mygame = new Game("", 6, img);
      }
    }
  }


  if (mygame.overExitBtn && mygame.isFinished && (screen == 2 || screen == 3 || screen == 4)) {
    changeMSG();
    screen = 1;
    homeScreen();
  }



  if (screen == 1) {

    if (classicMode.overPlayBtn) {
      screen = 2;
      img = -1;
      if (mygame.isFinished) {
        mygame = new Game("", 6, img);
      }
    }

    if (themedMode.overPlayBtn && cards.contains(themedMode)) {
      themedSelection();
    }

    if (towerOfLexiMode.overPlayBtn) {
      System.out.println("Rescue Lexi!");
      screen = 4;
      tol = new Tower();
      mygame = new TowerGame("", tol);
    }

    if (summerCard.overPlayBtn) {
      screen = 3;
      img = 0;
      BG = summerBG;
      mygame = new Game("", 6, img);
    }
    if (autumnCard.overPlayBtn) {
      screen = 3;
      img = 1;
      BG = autumnBG;
      mygame = new Game("", 6, img);
    }

    if (winterCard.overPlayBtn) {
      screen = 3;
      img = 2;
      BG = winterBG;
      mygame = new Game("", 6, img);
    }

    if (ld.overLongBtn) {
      screen = 5;
    }
  } else if (screen == 5) {
    if (menu.overLongBtn) {
      screen = 1;
    }
  }
}

void changeMSG() {
  msg = "Main Menu";
}
