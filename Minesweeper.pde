import de.bezier.guido.*;

private int NUM_ROWS = 10;
private int NUM_COLS = 10;
private int NUM_BOMBS = (NUM_ROWS*NUM_COLS)/6;

private int gameLength = 800;
private int gameWidth = 800;

public int gameWonBombCount = 0;
public boolean gameState = true;

//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

public void setup ()
{
    size(800, 800);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r<NUM_ROWS; r++) 
    {
        for(int c = 0; c<NUM_COLS;c++)
        {
            buttons[r][c] = new MSButton(r,c);
        }
    }
    
    for(int i = 0; i<NUM_BOMBS; i++)
    {
        setBombs();
    }

}



public void setBombs()
{
    //your code
    int row = (int)(Math.random()*NUM_ROWS);
    int col = (int)(Math.random()*NUM_COLS);


    if(!bombs.contains(buttons[row][col]))
    {
        bombs.add(buttons[row][col]);
    }
}



public void draw ()
{
    background( 0 );
    if(isWon())
    {
        displayWinningMessage();
    }
}


public boolean isWon()
{
    //your code here


    for(int r = 0; r<NUM_ROWS; r++) 
    {
        for(int c = 0; c<NUM_COLS;c++)
        {
            if(buttons[r][c].isClicked() && bombs.contains(buttons[r][c]))
            {
                gameWonBombCount++;
                if(gameWonBombCount==(NUM_ROWS*NUM_COLS)/6)
                {

                    return true;
                }
            }
        }
    }




    return false;
}


public void displayLosingMessage()
{
    //your code here
    gameState = false;
    for(int i = 0; i<NUM_BOMBS; i++)
    {
        bombs.get(i).clicked = true;
    }   
    buttons[NUM_ROWS/2][NUM_COLS/2-3].setLabel("Y");
    buttons[NUM_ROWS/2][NUM_COLS/2-2].setLabel("O");
    buttons[NUM_ROWS/2][NUM_COLS/2-1].setLabel("U");
    buttons[NUM_ROWS/2][NUM_COLS/2].setLabel(" ");
    buttons[NUM_ROWS/2][NUM_COLS/2+1].setLabel("L");
    buttons[NUM_ROWS/2][NUM_COLS/2+2].setLabel("O");
    buttons[NUM_ROWS/2][NUM_COLS/2+3].setLabel("S");
    buttons[NUM_ROWS/2][NUM_COLS/2+4].setLabel("E");

}


public void displayWinningMessage()
{
    //your code here
    buttons[NUM_ROWS/2][NUM_COLS/2-3].setLabel("Y");
    buttons[NUM_ROWS/2][NUM_COLS/2-2].setLabel("O");
    buttons[NUM_ROWS/2][NUM_COLS/2-1].setLabel("U");
    buttons[NUM_ROWS/2][NUM_COLS/2].setLabel(" ");
    buttons[NUM_ROWS/2][NUM_COLS/2+1].setLabel("W");
    buttons[NUM_ROWS/2][NUM_COLS/2+2].setLabel("I");
    buttons[NUM_ROWS/2][NUM_COLS/2+3].setLabel("N");
}


public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
         width = gameLength/NUM_COLS;
         height = gameWidth/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {

        //your code here
        if(gameState)
        {
            if(mouseButton == RIGHT)
            {
                marked = !marked;
            }

            else

            if(mouseButton == LEFT)
            {
                clicked = true;
                if(bombs.contains(this))
                {
                    displayLosingMessage();
                } 
                else 

                if(this.countBombs(r,c)>0)
                {
                    this.setLabel(Integer.toString(countBombs(r,c)));
                } 
            
                else 
                {
                    if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked())
                    {
                        buttons[r-1][c-1].mousePressed();
                    }

                    if(isValid(r-1,c) && !buttons[r-1][c].isClicked())
                    {
                        buttons[r-1][c].mousePressed();
                    }

                    if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked())
                    {
                        buttons[r-1][c+1].mousePressed();
                    }

                    if(isValid(r,c-1) && !buttons[r][c-1].isClicked())
                    {
                        buttons[r][c-1].mousePressed();
                    }   

                    if(isValid(r,c+1) && !buttons[r][c+1].isClicked())
                    {
                        buttons[r][c+1].mousePressed();
                    }   

                    if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked())
                    {
                        buttons[r+1][c-1].mousePressed();
                    }

                    if(isValid(r+1,c) && !buttons[r+1][c].isClicked())
                    {
                        buttons[r+1][c].mousePressed();
                    }

                    if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked())
                    {
                        buttons[r+1][c+1].mousePressed();
                    }        
                }
            }
        }
    }

    public void draw () 
    {    
        if (marked)
        {
            fill(0);
        }
        else if( clicked && bombs.contains(this) )
        {
             fill(255,0,0);
        }
        else if(clicked)
        {
            fill( 200 );
        }
        else
        {
            fill( 100 );
        }

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }

    public void setLabel(String newLabel)
    {
        label = newLabel;
    }

    public boolean isValid(int r, int c)
    {
        //your code here
        if(r<NUM_ROWS && r>=0 && c<NUM_COLS && c>=0)
        {
            return true;
        }
        return false;


    }

    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        // for(int r = 0; r<9; r++)
        //     if(r==0)
        //     {
        //         if(buttons[1][1].isValid)
        //         {
        //             if(bombs.contains(buttons[r][c]))
        //             {
        //                 numBombs++;
        //             }
        //         }
        //     }else
        //     {
                
        //     }

        if(isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1]))
        {
            numBombs++;
        }
        if(isValid(row-1,col) && bombs.contains(buttons[row-1][col]))
        {
            numBombs++;
        }
        if(isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1]))
        {
            numBombs++;
        }
        if(isValid(row,col-1) && bombs.contains(buttons[row][col-1]))
        {
            numBombs++;
        }         
        if(isValid(row,col+1) && bombs.contains(buttons[row][col+1]))
        {
            numBombs++;
        }       
        if(isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1]))
        {
            numBombs++;
        }
        if(isValid(row+1,col) && bombs.contains(buttons[row+1][col]))
        {
            numBombs++;
        }
        if(isValid(row+1,col+1) && bombs.contains(buttons[row+1][col+1]))
        {
            numBombs++;
        }        
        return numBombs;
    }

}




/*

//you might already have variables for these, you can just use those
//set these variables equal to whatever your circle is equal to
var circle1X = whatever your first circle x value is;
var circle2X = whatever your second circle x value is;
var circle1Y = whatever your first circle y value is;
var circle2Y = whatever your second circle y value is;

var circle1Radius = first circle radius;
var circle2Radius = second circle radius;

//the code without comments doesn't need to be changed
//change the variable names if you need to
var xDistanceOfCircles = circle1X - circle2X;
var yDistanceOfCircles = circle1Y - circle2y;

//basically the distance formula/Pytagorean's Theorem
//if Math.sqrt doesn't work, replace bottom code with below
//var distanceBetweenTwoCircles = (xDistanceOfCircles*xDistanceOfCircles + yDistanceOfCircles*yDistanceOfCircles)^(1/2);
var distanceBetweenTwoCircles = Math.sqrt(xDistanceOfCircles*xDistanceOfCircles + yDistanceOfCircles*yDistanceOfCircles);

//actual check for collision code
if(distanceBetweenTwoCircles < circle1Radius + circle2Radius)
{
    //collision
}


*/