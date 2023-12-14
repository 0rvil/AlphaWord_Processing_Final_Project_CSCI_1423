/**
 The WordRow is an object made up of 5 Letters, that display a users' guess.
 It has the ability to determine the correctness of a letter's position in a guess
 when compared to the solution.
 */
class WordRow {
  // Attributes
  String guessedWord;
  String solutionWord;
  ArrayList<String> guessArray;
  ArrayList<String> solutionArray;
  ArrayList<Letter> letterList;
  boolean isSubmitted;

  // Constructor
  WordRow(String currentGuess, String solution, boolean submit) {
    guessedWord = currentGuess.toUpperCase();
    solutionWord = solution;
    isSubmitted = submit;

    guessArray = new ArrayList<>(Arrays.asList(guessedWord.split("", 5)));
    solutionArray = new ArrayList<>(Arrays.asList(solutionWord.split("", 5)));

    // Initialize LetterList with default values
    letterList = new ArrayList<Letter>();
    for (int i = 0; i < 5; i++) {
      letterList.add(new Letter("", ""));
    }
  }

  /** Method that calls the letters in the user's guessedWord to be displayed */
  void submit(int h) {
    int w = width / 3 + 20;
    if (!isSubmitted) {
      for (int j = 0; j<5; j++) {
        String ch = j < guessedWord.length() ? String.valueOf(guessedWord.charAt(j)) : "";
        new Letter(ch, "").display(w, h);
        w += 60;
      }
    } else {
      checkPosition();
      for (Letter l : letterList) {
        l.display(w, h);
        w += 60;
      }
    }
  }

  /** Method for determining if a letter is correct, incorrect, or in the wrong-place */
  void checkPosition() {


    // First check each letter to determine if its in the solution and correct position
    for (int i = 0; i < 5; i++) {
      String currentLetter = guessArray.get(i);
      if (solutionArray.get(i).equals(currentLetter)) {
        letterList.set(i, new Letter(currentLetter, "correct"));
        solutionArray.set(i, "");

        mygame.rowsList.forEach( row -> row.replaceAll( letter -> {
          if (currentLetter.equals(letter.letter)) {
            letter.setState("correct");
          }
          return letter;
          }
        ));
      }
    }

    // Check each remaining letter and determine if its in the wrong place or not in the solution
    for (int j = 0; j < 5; j++) {
      String currentLetter = guessArray.get(j);
      int letterIndex = solutionArray.indexOf(currentLetter);

      if (!solutionArray.get(j).equals("") && !letterList.get(j).letter.equals(currentLetter)) {
        if (letterIndex != -1) { // The letter is in the solution, but in the wrong place
          letterList.set(j, new Letter(guessArray.get(j), "wrong-place"));
          solutionArray.set(letterIndex, "");

          // Update the grid to display the current letter's state
          mygame.rowsList.forEach( row -> row.replaceAll( letter -> {
            if (currentLetter.equals(letter.letter) && !letter.state.equals("correct") && !letter.state.equals("incorrect")) {
              letter.setState("wrong-place");
            }
            return letter;
            }
          ));
        }
      }
    }

    for (int k = 0; k < 5; k++) {
      String currentLetter = guessArray.get(k);
      if (letterList.get(k).state.equals("")) {
        if (!solutionArray.contains(currentLetter)) { // The letter is not in the solution
          letterList.set(k, new Letter(currentLetter, "incorrect"));
          mygame.rowsList.forEach( row -> row.replaceAll( letter -> {
            if (currentLetter.equals(letter.letter) && letter.state.equals("")) {
              letter.setState("incorrect");
            }
            return letter;
            }
          ));
        }
      }
    }
    solutionArray = new ArrayList<>(Arrays.asList(solutionWord.split("", 5)));
  }
}
