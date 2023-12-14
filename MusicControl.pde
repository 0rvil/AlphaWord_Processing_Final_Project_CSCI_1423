void playMenuMusic() {
  if (!mainMenu.isPlaying()) {
    mainMenu.loop();
  }
}

void gameCompleteSound() {
  if (!mygame.hasPlayed) {
    if (mygame.won) {
      correct.play();
      if (screen == 4) {
        tol.nextLevel();
        tol.increaseScore(100 - 10 * (mygame.guesses.size() - 1));
        
        if (tol.getLevel() == 10 && tol.score > scores[scores.length - 1].getScore()) {
          newHighScore("Player 1", tol.score);
        }
      }
      //port.write("c");
    } else {
      if (screen == 4) {
        tol.setGameOver();

        if (tol.score > scores[scores.length - 1].getScore()) {
          newHighScore("Player 1", tol.score);
        }
      }
      wrong.play();
      //port.write("i");
    }
    mygame.hasPlayed = true;
    //port.write("a");
  }
}

void playClassicMusic() {
  if (!classicMusic.isPlaying()) {
    classicMusic.loop();
  }
}

void playSummerMusic() {
  if (!summer.isPlaying()) {
    summer.loop();
  }
}

void playAutumnMusic() {
  if (!autumn.isPlaying()) {
    autumn.loop();
  }
}

void playWinterMusic() {
  if (!winter.isPlaying()) {
    winter.loop();
  }
}

void playTowerMusic() {
  if (!tower.isPlaying()) {
    tower.loop();
  }
}

void stopMenuMusic() {
  if (mainMenu.isPlaying()) {
    mainMenu.stop();
  }
}


void stopSummerMusic() {
  if (summer.isPlaying()) {
    summer.stop();
  }
}

void stopAutumnMusic() {
  if (autumn.isPlaying()) {
    autumn.stop();
  }
}

void stopWinterMusic() {
  if (winter.isPlaying()) {
    winter.stop();
  }
}

void stopTowerMusic() {
  if (tower.isPlaying()) {
    tower.stop();
  }
}

void stopThemedMusic() {
  stopSummerMusic();
  stopAutumnMusic();
  stopWinterMusic();
}
