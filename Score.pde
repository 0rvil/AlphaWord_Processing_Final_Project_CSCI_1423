class Score {
  String userName;
  int userScore;

  Score(String name, int score) {
    userName = name;
    userScore = score;
  }
  
  String getUserName(){
    return userName;
  }
  
  int getScore(){
    return userScore;
  }

  void display(int x, int y) {

    pushMatrix();
    translate(x, y);
    
    fill(0);
    textSize(40);
    text(userName, x, y );
    
    fill(#6AAA64);
    textSize(30);
    text("Score: " + userScore, x, y + 25);
    
    popMatrix();
    
  }
}

void loadData() {

  json = loadJSONObject("data.json");
  JSONArray scoresData = json.getJSONArray("high_scores");
  scores = new Score[scoresData.size()];

  for (int i = 0; i < scoresData.size(); i++) {
    JSONObject score = scoresData.getJSONObject(i);
    String userName = score.getString("Name");
    int userScore = score.getInt("Score");
    scores[i] = new Score(userName, userScore);
  }
}

void newHighScore(String userName, int userScore){
  // Create a new JSONObject for the new score to be added to the leaderboard
  JSONObject newscore = new JSONObject();
  
  newscore.setString("Name", userName);
  newscore.setInt("Score", userScore);
  
  // Retrive the current leaderboard
  JSONArray scoresData = json.getJSONArray("high_scores");
    
  scoresData.remove(scoresData.size()-1); // Remove the last score in the leaderboard
  scoresData.append(newscore); // Add the new score into the leaderboard
  
  // Create a temporary list that is a copy of the leaderboard to conduct sorting
  List<JSONObject> scoreList = new ArrayList<>();
  for (int i = 0; i < scoresData.size(); i++) {
    scoreList.add(scoresData.getJSONObject(i));
  }

  // Sort the list using a custom comparator
  scoreList.sort((s1, s2) -> Integer.compare(s2.getInt("Score"), s1.getInt("Score")));

  // Clear the original JSONArray
  while (scoresData.size() > 0) {
    scoresData.remove(0);
  }
  
  // Add the newly sorted scores into the JSONArray
  for (JSONObject score : scoreList) {
    scoresData.append(score);
  }

  // Save the scores with the new high score in the JSON file
  saveJSONObject(json,"data/data.json");
  loadData();


}
