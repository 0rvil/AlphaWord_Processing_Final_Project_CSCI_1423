/**
 A Letter is a 50 x 50 box displaying a letter,
 It is the basic building block of a Game.
 It's color changes according to its state:
 Not-submitted (denoted by an empty string), "correct",
 "incorrect", and "wrong-place".
 */
class Letter {
  // Attributes
  String letter;
  String state;

  // Constructor
  Letter(String myLetter, String myState) {
    letter = myLetter;
    state = myState;
  }

  /** Method for changing the state of a Letter */
  void setState(String newState) {
    state = newState;
  }

  /** Method for displaying a letter onto the screen */
  void display(int x, int y) {
    pushMatrix();
    translate(x, y);

    if (letter.equals("")){
      stroke(getColor());
      strokeWeight(2);
    } else {
      fill(getColor());
    }

    rect(0, 0, 50, 50);
    noStroke();


    fill(color(#FEFEFC));
    textSize(50);
    textAlign(CENTER, CENTER);

    if (!letter.equals("")) {
      text(letter, 25, 25);
    }
    fill(color(#FEFEFC));

    popMatrix();
  }

  /** Method for obtaining the letterBox color based on the Letter State */
  color getColor() {
    color boxColor;
    switch(state) {
    case "correct":
      boxColor = #6AAA64;
      break;
    case "incorrect":
      boxColor = #797c7e;
      break;
    case "wrong-place":
      boxColor = #c9b458;
      break;
    default:
      boxColor = #cfcfcf;
    }
    return boxColor;
  }
}
