import de.bezier.guido.*;
private static final int NUM_ROWS = 5;
private static final int NUM_COLS = 5;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c] = new MSButton(r, c);
    }
  }
  buttons[1][2].mousePressed();

  setMines();
}
public void setMines()
{
  int randR = (int)(Math.random()*NUM_ROWS);
  int randC = (int)(Math.random()*NUM_COLS);

  if (!mines.contains(buttons[randR][randC])) {
    mines.add(buttons[randR][randC]);
  }
}

public void draw ()
{
  background( 0 );
  if (isWon() == true)
    displayWinningMessage();
}
public boolean isWon()
{
  //your code here
  return false;
}
public void displayLosingMessage()
{
  //your code here
}
public void displayWinningMessage()
{
  //your code here
}
public boolean isValid(int r, int c)
{
  if (r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
    return true;
  return false;
}
public int countMines(int row, int col)
{
  int numMines = 0;
  if (isValid(row, col+1) && mines.contains(buttons[row][col+1]))
    numMines++;
  if (isValid(row+1, col+1) && mines.contains(buttons[row+1][col+1]))
    numMines++;
  if (isValid(row+1, col) && mines.contains(buttons[row+1][col]))
    numMines++;
  if (isValid(row+1, col-1) && mines.contains(buttons[row+1][col-1]))
    numMines++;
  if (isValid(row, col-1) && mines.contains(buttons[row][col-1]))
    numMines++;
  if (isValid(row-1, col-1) && mines.contains(buttons[row-1][col-1]))
    numMines++;
  if (isValid(row-1, col) && mines.contains(buttons[row-1][col]))
    numMines++;
  if (isValid(row-1, col+1) && mines.contains(buttons[row-1][col+1]))
    numMines++;
  return numMines;
}
public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton ( int row, int col )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () 
  {
    clicked = true;
    if (mouseButton == RIGHT) {
      flagged = !flagged;
      if (flagged == false)
        clicked = false;
    } else if (clicked && mines.contains(this)) {
      displayLosingMessage();
    } else if (countMines(myRow, myCol) > 0) {
      myLabel = countMines(myRow, myCol)+""; // +"" converts int to string
    } else {
      if (isValid(myRow, myCol+1) && clicked == false)
        buttons[myRow][myCol+1].mousePressed();
      if (isValid(myRow+1, myCol+1) && clicked == false)
        buttons[myRow+1][myCol+1].mousePressed();
      if (isValid(myRow+1, myCol) && clicked == false)
        buttons[myRow+1][myCol].mousePressed();
      if (isValid(myRow+1, myCol-1) && clicked == false)
        buttons[myRow+1][myCol-1].mousePressed();
      if (isValid(myRow, myCol-1) && clicked == false)
        buttons[myRow][myCol-1].mousePressed();
      if (isValid(myRow-1, myCol-1) && clicked == false)
        buttons[myRow-1][myCol-1].mousePressed();
      if (isValid(myRow-1, myCol) && clicked == false)
        buttons[myRow-1][myCol].mousePressed();
      if (isValid(myRow-1, myCol+1) && clicked == false)
        buttons[myRow-1][myCol+1].mousePressed();
    }
  }
  public void draw () 
  {    
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
