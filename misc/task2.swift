var myBoard: [[Bool]] = [];
for  in 0...9{
    myBoard.append([false,false,false,false,false,false,false,false,false,false]);
}

func setShip(_ board: [[Bool]] ,_ from: (Int,Int), _ to: (Int,Int))-> Bool{
    //check horizontality/verticality
    var vert: Bool;
    if(from.0 != to.0){
        if(from.1 != to.1){
            print("ERROR: The ship can be placed either horizontally or vertically!")
            return false;
        }
        else{
            vert = false;
        }
    }
    else{
        if(from.1 != to.1){
            vert = true;
        }
        else{
            print("ERROR: A ship can take the size of at least 2 cells!")
            return false;
        }
    }
    //check boundaries
    if(from.0 < 1 || from.1 < 1 || to.0 < 1 || to.1 < 1){
        print("ERROR: One of the coordinates is BELOW the size of the board.\n
                Please keep it between 1 and 10.")
        return false;
    }
    if(from.0 > 10 || from.1 > 10 || to.0 > 10 || to.1 > 10){
        print("ERROR: One of the coordinates EXCEEDS the size of the board.\n 
               Keep it between 1 and 10 please.")
        return false;
    }
    //check the surroundings
    if(vert){
        for i in from.0...to.0{
            if(board[from.1-1][] || to.1-1)
        }
    }
    else{
        for i in from.1...to.1{
            
        }
    }
    if(board[])
    return false;
}