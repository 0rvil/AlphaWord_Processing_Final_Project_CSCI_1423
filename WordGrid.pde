/**
 A WordGrid is an object made up of WordRows.
 */

class WordGrid {
  String solution;
  ArrayList<String> guessedWords;
  ArrayList<WordRow> wordRows;

  WordGrid(String mySolution, ArrayList<String> myGuesses) {
    solution = mySolution;
    guessedWords = new ArrayList<String>(Collections.nCopies(myGuesses.size(), ""));
    wordRows = new ArrayList<WordRow>();
    updateWordRows(myGuesses, false, "");
  }

  // Method for updating the WordRow if there's a new guess
  void updateWordRows(ArrayList<String> newGuesses, boolean isSubmitted, String guess) {

    // Remove the last element in WordRows if it is set to not submitted
    if (wordRows.size() >= 1 && !wordRows.get(wordRows.size() - 1).isSubmitted) {
      wordRows.remove(wordRows.size() - 1);
    }

    // Add WordRows and display correctly based on submitted state
    if (!isSubmitted) {
      wordRows.add(new WordRow(guess, solution, false));
    } else if ( newGuesses.size() > wordRows.size()) {
      wordRows.add(new WordRow(newGuesses.get(newGuesses.size() - 1), solution, true));
    }
  }
}
