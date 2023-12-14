class Card {
  PImage img;
  String title;
  String description;
  String btnTxt;
  boolean overPlayBtn;
  float cardHeight;
  float cardWidth;
  color playBtnClr;
  int x;
  int y;

  Card(PImage cardImg, String cardTitle, String cardDesc, String btnLabel, float heightDisplay, float widthDisplay, int x1, int y1) {
    img = cardImg;
    title = cardTitle;
    description = cardDesc;
    btnTxt = btnLabel;
    overPlayBtn = false;
    cardHeight = heightDisplay;
    cardWidth = widthDisplay;
    playBtnClr = #797c7e;
    x = x1;
    y = y1;
  }

  void display() {

    pushMatrix();
    translate(x, y);

    // Create the base display with round corners
    stroke(#e2e2e2);
    strokeWeight(4);
    fill(#FFFFFF);
    rect(0, 0, cardWidth, cardHeight, 28);
    noStroke();

    // Fill image
    if (img != null) {
      img.resize(125, 125);
      image(img, cardWidth / 2 - 62.5, cardHeight/16);
    }

    //Display title
    fill(#797c7e);
    text(title, 10, cardHeight/2 + 10);

    // Display description
    fill(#9CA0A2);
    wrapText(description, 10, cardHeight / 2 + 35, cardWidth - 20, 20);

    // Display Button
    fill(playBtnClr);
    rect(10, cardHeight - 60, cardWidth - 20, 50, 28);

    // Display Button Text
    fill(color(#FEFEFC));
    textSize(20);
    text(btnTxt, cardWidth/2 - 20, cardHeight - 30);

    popMatrix();
  }

  void update() {
    if (overButton(x + 10, y + (int)cardHeight - 60, (int)cardWidth - 20, 50)) {
      overPlayBtn = true;
      playBtnClr = #6AAA64;
    } else {
      overPlayBtn = false;
      playBtnClr = #797c7e;
    }
  }
}

// Function to wrap text
void wrapText(String txt, float x, float y, float w, float leading) {
  String[] words = split(txt, ' ');
  String line = "";

  for (String word : words) {
    if (textWidth(line + word) < w) {
      line += word + " ";
    } else {
      text(line, x, y);
      y += leading;
      line = word + " ";
    }
  }

  // Handle the last line
  if (!line.equals("")) {
    text(line.trim(), x, y);  // Use trim() to remove trailing space
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


class longBtn {
  String btnTitle;
  boolean overLongBtn;
  float longBtnHeight;
  float longBtnWidth;
  color longBtnClr;
  int x;
  int y;


  longBtn(String title, float btnHeight, float btnWidth, int x1, int y1 ) {
    btnTitle = title;
    overLongBtn = false;
    longBtnHeight = btnHeight;
    longBtnWidth = btnWidth;
    longBtnClr = #797c7e;
    x = x1;
    y = y1;
  }
  
  void display(){
    pushMatrix();
    translate(x,y);
    
    stroke(#e2e2e2);
    strokeWeight(4);
    
    fill(longBtnClr);
    rect(0, 0, longBtnWidth, longBtnHeight, 28);
    
    fill(#FEFEFC);
    textSize(20);
    text(btnTitle, longBtnWidth/2 - (btnTitle.length() * 5), longBtnHeight/2 + 5);
    
    popMatrix();
  
  }
  
  void update(){
  
    if(overButton(x, y, (int)longBtnWidth, (int)longBtnHeight)){
      overLongBtn = true;
      longBtnClr = #6AAA64;
    } else {
      overLongBtn = false;
      longBtnClr = #797c7e;
    }
  
  }
}
