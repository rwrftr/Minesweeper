import de.bezier.guido.*;
int frameSize;
int numBombs = 5;
int squaresize = 20;
int NUM_COLS = squaresize;
int NUM_ROWS = squaresize;
int colortest;
boolean isLost;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(1000, 1000);
  frameSize = width;
  textSize((int)(0.04 * frameSize));
  textAlign(CENTER, CENTER);
  isLost = false;

  // make the manager
  Interactive.make( this );

  buttons = new MSButton [NUM_ROWS][NUM_COLS];
  mines = new ArrayList <MSButton>();

  //your code to initialize buttons goes here

  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c] = new MSButton(r, c);
    }
  }

  setMines();
}
public void setMines()
{
  for (int i = 0; i < numBombs; i ++) {
    int randRow = (int)(Math.random()*squaresize);
    int randCol = (int)(Math.random()*squaresize);
    if (!mines.contains(buttons[randRow][randCol])) {
      mines.add(buttons[randRow][randCol]);
    } else {
      i--;
    }
  }
  //generate random number between 0 and max
  //use "contains()" func to check if it is already a mine. 
  //if it isn't, make it a mine. If it is, try again.
}

public void draw ()
{
  //if (!isWon() && !isLost){background(255);}else{}`
  background(255);
  if (isWon() == true)
    displayWinningMessage();
}
public boolean isWon()
{
  //if all of the buttons that are not boms have been clicked, count as won
  //maybe iterate through the unclicked buttons and check for non-bombs. If a non-bomb is found just instantly return false. Else, return true.
  //how do we get a list of unclicked buttons
  //iterate through the buttons and return false if (!clicked) && (!mines.contains[][])

  for (int x = 0; x < NUM_ROWS; x++) {
    for (int y = 0; y < NUM_COLS; y++) {
      //if the button hasn't been clicked and it isn't a mine, return false
      if ((!buttons[x][y].clicked) && (!mines.contains(buttons[x][y]))) {
        return false;
      }
    }
  }
  return true;
}
public void displayLosingMessage()
{

  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      //hello mr chan
      //it is 10:03 on friday march 3rd! 
      //I will never remember putting this in here, so this moment in time is only survived by you now. My cat is on the couch next to me. 
      //she can get bitey/scratch-y and she didn't want to share the couch. Usually she likes the fireplace where I am, but for some
      //reason she is still on the couch.
      if (mines.contains(buttons[r][c])) {
        buttons[r][c].clicked = true;
      }
      //forgot to add the if statement for if the button is a bomb
    }
  }

  buttons[7][7].setLabel("Y");
  buttons[7][8].setLabel("o");
  buttons[7][9].setLabel("u");

  buttons[7][11].setLabel("L");
  buttons[7][12].setLabel("o");
  buttons[7][13].setLabel("s");
  buttons[7][14].setLabel("t");

  buttons[8][7].setLabel("S");
  buttons[8][8].setLabel("o");
  buttons[8][9].setLabel("r");
  buttons[8][10].setLabel("r");
  buttons[8][11].setLabel("y");
  buttons[8][12].setLabel(":");
  buttons[8][13].setLabel("(");
}
public void displayWinningMessage()
{
 buttons[7][7].setLabel("Y");
  buttons[7][8].setLabel("O");
  buttons[7][9].setLabel("U");

  buttons[7][11].setLabel("W");
  buttons[7][12].setLabel("O");
  buttons[7][13].setLabel("N");
  buttons[7][14].setLabel("!");

  //for (int c = 0; c < NUM_COLS; c++){
  //if(c > 0){
  //buttons[6][c].color();
  
  //}
  
  
  //}
  
  
}
public boolean isValid(int r, int c)
{
  //check if r,c is a valid location on the grid
  if (r >= 0 && r < squaresize && c >= 0 && c < squaresize) {
    return true;
  }
  return false;
}
public int countMines(int row, int col)
{
  int numMines = 0;
  //go through all the neighbors of row,col and check if they're bombs

  if (isValid(row-1, col-1) && mines.contains(buttons[row-1][col-1])) {
    numMines++;
  }
  if (isValid(row-1, col) && mines.contains(buttons[row-1][col])) {
    numMines++;
  }
  if (isValid(row-1, col+1) && mines.contains(buttons[row-1][col+1])) {
    numMines++;
  }
  if (isValid(row, col-1) && mines.contains(buttons[row][col-1])) {
    numMines++;
  }
  if (isValid(row, col+1) && mines.contains(buttons[row][col+1])) {
    numMines++;
  }
  if (isValid(row+1, col-1) && mines.contains(buttons[row+1][col-1])) {
    numMines++;
  }
  if (isValid(row+1, col) && mines.contains(buttons[row+1][col])) {
    numMines++;
  }
  if (isValid(row+1, col+1) && mines.contains(buttons[row+1][col+1])) {
    numMines++;
  }
  return numMines;
}
public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged, winTest;
  private String myLabel;

  public MSButton ( int row, int col )
  {
    width = frameSize/NUM_COLS;
    height = frameSize/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = winTest = false;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () 
  {
    if (isWon() == false && !isLost) {
      clicked = true;
      if (mouseButton  == RIGHT) {
        //set flagged to it's opposite value(if true set false, if false set true)
        if (!clicked) {
          if (flagged) {
            flagged = false;
            clicked = false;
          } else {
            flagged = true;
          }
        }
      } else if (flagged == true) {
      }
      //else if mines contains this button, 
      else if (mines.contains(this)) {
        //display the losing message
        displayLosingMessage();
        isLost = true;
      }
      //else if countMines returns a number of neighboring mines greater than zero
      else if (countMines(myRow, myCol) > 0) {
        //set the label to that number
        myLabel = "" +countMines(myRow, myCol);
      } else {
        //else recursively call mousePressed with the valid, unclicked, neighboring buttons in all 8 squares

        if (isValid(myRow-1, myCol-1) && !(buttons[myRow-1][myCol-1].clicked) && !mines.contains(buttons[myRow-1][myCol-1])) {
          buttons[myRow-1][myCol-1].mousePressed();
        }
        if (isValid(myRow-1, myCol) && !(buttons[myRow-1][myCol].clicked) && !mines.contains(buttons[myRow-1][myCol])) {
          buttons[myRow-1][myCol].mousePressed();
        }
        if (isValid(myRow-1, myCol+1)  && !(buttons[myRow-1][myCol+1].clicked) && !mines.contains(buttons[myRow-1][myCol+1])) {
          buttons[myRow-1][myCol+1].mousePressed();
        }
        if (isValid(myRow, myCol-1)  && !(buttons[myRow][myCol-1].clicked) && !mines.contains(buttons[myRow][myCol-1])) {
          buttons[myRow][myCol-1].mousePressed();
        }
        if (isValid(myRow, myCol+1)  && !(buttons[myRow][myCol+1].clicked) && !mines.contains(buttons[myRow][myCol+1])) {
          buttons[myRow][myCol+1].mousePressed();
        }
        if (isValid(myRow+1, myCol-1)  && !(buttons[myRow+1][myCol-1].clicked)  && !mines.contains(buttons[myRow+1][myCol-1])) {
          buttons[myRow+1][myCol-1].mousePressed();
        }
        if (isValid(myRow+1, myCol)  && !(buttons[myRow+1][myCol].clicked)  && !mines.contains(buttons[myRow+1][myCol])) {
          buttons[myRow+1][myCol].mousePressed();
        }
        if (isValid(myRow+1, myCol+1)  && !(buttons[myRow+1][myCol+1].clicked)  && !mines.contains(buttons[myRow+1][myCol+1])) {
          buttons[myRow+1][myCol+1].mousePressed();
        }
      }
    }
  }
  public void draw () 
  { 
    //if(winTest)fill(colortest);
    if (flagged)
      fill(0);
    else if ( clicked && mines.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(myLabel, x+width/2, y+height/2);
  }  

  public void setLabel(String newLabel)
  {
    myLabel = newLabel;
  }
  public void setLabel(int newLabel)
  {
    myLabel = ""+ newLabel;
  }
  public boolean isFlagged()
  {
    return flagged;
  }
}
