var myBoard: [[Bool]]=[]
myBoard.append([false,false,false,false,false,false,false,false,false,false]);
for _ in 0...9{
    myBoard.append([false,false,false,false,false,false,false,false,false,false]);
}
func setShip(_ board:inout [[Bool]],_ start:(Int,Int),_ end:(Int,Int))->Bool{
    var vert:Bool=true;
    if(start.0<0||end.0<0 || start.1<0||end.1<0){
        print("ERROR: one point is UNDER/BEYOND the board\nPlease keep it between 1 and 10\nKeep in mind that the minimum size of a ship is 2 boxes\n");
        return false;
    }
    if(start.1>9 || end.1>9 || start.0>9 || end.0>9){
        print("ERROR: one point is UNDER/BEYOND the board\nPlease keep it between 1 and 10\nKeep in mind that the minimum size of a ship is 2 boxes\n");
        return false;    
    }
    //check if vertical or horizontal
    if(start.0 != end.0){
        if(start.1 != end.1){
            print("ERROR: the points do not seem to point directly vertically/horizontally\n")
            return false
        }
        else{
            vert=false;
        }
    }
    else{
        if(start.1 == end.1){
            print("ERROR: the start point and the end point cannot be the same!\nMinimum length is 2 boxes")
            return false;
        }
    }
    //check the nearbies of a line
    if(vert){
        for i in start.1...end.1{
            if(start.0>0){
                if(board[i][start.0-1]){
                    print("ERROR:there must be space between ships")
                    return false
                }
            }
            if(start.0<9){
                if(board[i][start.0+1]){
                    print("ERROR: there must be space between ships")
                    return false;
                }
            }
        }
        //check the top and the bottom
        if(start.1>0){
            if(board[start.1-1][start.0]){
                    print("ERROR: there must be space between ships")
                    return false;
            }
        }
        if(end.1<9){
            if(board[end.1+1][end.0]){
                    print("ERROR: there must be space between ships")
                    return false;
            }
        }
    }
    else{
        for i in start.0...end.0{
            //check top
            if(start.1>0){
                if(board[start.1-1][i]){
                    print("ERROR: there must be space between ships");
                    return false;
                }
            }
            //check bottom
            if(end.1<9){
                if(board[end.1+1][i]){
                    print("ERROR: there must be space between ships");
                    return false;
                }
            }
        }
        if(start.0>0){
            if(board[start.1][start.0-1]){
                print("ERROR: there must be space between ships")
                return false;
            }
        }
        if(end.0<9){
            if(board[end.1][end.0+1]){
                print("ERROR: there must be space between ships")
                return false;
            }
        }
    }
    if(vert){
        for i in (start.1)...(end.1){
            board[i][start.0] = true;
            // print(i,",",start.0,","," set to TRUE !");
        }
    }
    else{
        for i in start.0...(end.0){
            board[start.1][i] = true;
            // print(i,",",start.1,","," set to TRUE !");
        }
    }
    return true;
}
func printBoard(_ board: [[Bool]]){
    print(" ",terminator:" ")
    for i in 0...9{
        print(i,terminator: " ")
    }
    print("")
    for i in 0...9{ 
        print(i,terminator:" ")
        for j in 0...9{
            print(((board[i][j]) ? 1 : 0),terminator: " ")
        }
        print("")
    }
}
// printBoard(myBoard);
var res = setShip(&myBoard,(2,1),(2,5))
printBoard(myBoard);
print(res ? "SHIP SET !" : "NOT SET !");