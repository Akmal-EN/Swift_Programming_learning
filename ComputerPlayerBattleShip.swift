var enemBoard: [[Int]]=[];
var truBoard: [[Bool]]=[];
//fulfilling the enemyBoard
for _ in 0...9{
    enemBoard.append([0,0,0,0,0,0,0,0,0,0])
}
//fulfilling the trueBoard
for _ in 0...9{
    truBoard.append([false,false,false,false,false,false,false,false,false,false]);
}
//BE MINDED THAT UNCOMMENTING ALL OF THE FOLLOWING BELOW AT THE SAME TIME
//DOES NOT AFFECT THE RESULT - THE PROGRAM CAN TEST ALL AT ONCE

//uncomment to test for vertical successfull attack
// enemBoard[5][5]=1;
// for i in 2...6{
//     truBoard[i][5] = true;
// }
// for i in 2...5{
//     truBoard[5][i]=true;
// }
//uncomment to test for horizontal successful attack
// enemBoard[8][3]=1;
// for i in 3...8{
//     truBoard[8][i] = true;
// }

//THIS FUNCTION
//prints the given 10x10 board 
func printBoard(_ board: [[Int]]){
    print(" ",terminator:" ")
    for i in 0...9{
        print(i,terminator: " ")
    }
    print("")
    for i in 0...9{ 
        print(i,terminator:" ")
        for j in 0...9{
            print((board[i][j]),terminator: " ")
        }
        print("")
    }
}
// printBoard(myBoard);

//THIS FUNCTION
//generates a point to attack
//with minded fact that there is already a succesfull attack
//trying to understand if the ship is vertical or horizontal
//after understanding it goes on to destroy the whole ship
//in other cases it understands the points available for attacking
//ignoring the non-successful and the sunken ship with it's area of coverage
func attackByComputer(_ enemyBoard:inout [[Int]])->(Int,Int){
    //find successful attacks and make sure it's either horizontal or vertical
    //if not verified - attack all 4 different directions step by step
    // if it was already attacked
    //then attack another direction
    
    //if there are no successfuls then
    //pick any box except the nearbies of sunken ships
    //and attack by chance 
    
    var firstInd:Int! = nil,vert:Bool! = nil,line:Int! = nil; 

    //find successful attacks and make sure it's either horizontal or vertical
    //finding
    for i in 0...9{
        if(enemyBoard[i].contains(1)){
            firstInd = enemyBoard[i].firstIndex(of:1);
            //check if bool
            var tempchecker:Int=0;
            if(i==9){
                tempchecker=i-1;
            }
            else{
                tempchecker=i+1;
            }
            //checking top or bottom first
            //why mostly we check for the bottom ? 
            //because the search for the available successful attack
            //comes from top to bottom
            if(enemyBoard[tempchecker][firstInd] == 1){
                vert=true;
            }
            else{
                //then check right
                if(firstInd<9){
                    if(enemyBoard[i][firstInd+1]==1){
                        vert=false;
                    }
                }
                else{
                    //then check left if right is not possible
                    if(enemyBoard[i][firstInd-1]==1){
                        vert=false;
                    }
                }
            }
            line=i;
            break;
        }
    }
    // print("\nFinding part finished\n");
    if(firstInd == nil){
        //if there are no successfuls then
        //pick any box except the nearbies of sunken ships
        //and except unsuccessful attacks
        //and attack by chance 
        var myrange:[Int]=[0,1,2,3,4,5,6,7,8,9];
        var myrange2:[Int]=[0,1,2,3,4,5,6,7,8,9];
        //TODO: CHECK THIS RANDOM FUNCTION
        var temp:Int = Int(myrange.randomElement()!);
        // print("THE RANDOM ELEMENT FROM RANGE:", temp)
        //attack by chance
        while(!enemyBoard[temp].contains(0)){
            if(myrange.count==0){
                print("ERROR:CANNOT ACCESS ANY UNATTACKED SLOTS !")
                return (0,0);
            }
            myrange.remove(at:myrange.firstIndex(of:temp)!);
            temp = Int(myrange.randomElement()!);
        }
        var temp2:Int = Int(myrange2.randomElement()!);
        while(enemyBoard[temp][temp2] != 0){
            myrange2.remove(at:myrange2.firstIndex(of:temp2)!);
            temp2 = Int(myrange2.randomElement()!);
        }
        // Int(enemyBoard[temp].firstIndex(of:0)!
        return (temp,temp2);
    }
    else{
        // print("FIRST IND:", Int(firstInd));
        //if there is succesful
        if(vert == nil){
            //if not verified that it's vertical/horizontal
            //then attack all 4 different directions step by step
            // if one direction was already attacked
            //then attack another direction
            if(line>0){
                //start with top - if not attacked - do it
                if(enemyBoard[line-1][firstInd]==0){
                    //if top is not attacked then attack
                    return (firstInd,line-1)
                }
                else{
                    //then with bottom - if not attacked
                    if(line<9){
                        if(enemyBoard[line+1][firstInd]==0){
                            //do it
                            return (firstInd,line+1);
                        }
                        else{
                            //after both top and bottom is unavailable
                            //we attack left
                            if(firstInd>0){
                                if(enemyBoard[line][firstInd-1]==0){
                                    return (firstInd-1,line);
                                }
                                else{
                                    //otherwise right
                                    if(firstInd<9){
                                        if(enemyBoard[line][firstInd+1]==0){
                                            return (firstInd+1,line)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        print("\nRandom attack part finished\n");
        }
        else{
            
            if(vert){
                //if it's vertical then
                var temp:Int = line;
                //check top
                while(temp>0 && enemyBoard[temp][firstInd] == 1){
                    //checking top
                    if(enemyBoard[temp-1][firstInd]==0){
                        //if top is not attacked then attack
                        return (firstInd,temp-1)
                    }
                    else if(enemyBoard[temp-1][firstInd] != 1){
                        break;
                    }
                    temp-=1;
                }
                temp = line;
                //checking bottom
                while(temp<9 && enemyBoard[temp][firstInd] == 1){
                    if(enemyBoard[temp+1][firstInd] == 0){
                        return (firstInd,temp+1);
                    }
                    else if(enemyBoard[temp+1][firstInd] != 1){
                        break;
                    }
                    temp+=1;
                }
                if(temp == 9){
                    print("couldn't find the next");  
                }
            }
            else{
                //so it's horizontal so we
                var temp:Int = firstInd;
                //check left
                while(temp>0 && enemyBoard[line][temp] == 1){
                    if(enemyBoard[line][temp-1] == 0){
                        return (temp-1,line);
                    }
                    else if(enemyBoard[line][temp-1] != 1){
                        break;
                    }
                    temp-=1;
                }
                temp=firstInd;
                //check right
                while(temp<9 && enemyBoard[line][temp] == 1){
                    if(enemyBoard[line][temp+1] == 0){
                        return (temp+1,line);
                    }
                    else if(enemyBoard[line][temp+1] == 0){
                        break;
                    }
                    temp+=1;
                }
                if(temp == 9){
                    print("Couldn't find the next horizontal")
                }
            }
            print("Attack near successful finished");
        }
    }
    return (0,0);
}
//THIS FUNCTION
//updates the board for keeping attack records
//with provided new attack and the actual ship placement of the defending player
//and lets know the opponent if the attack is successful or not
//and also if the ship is destroyed completely or not
func updateBoards(_ attack:(Int,Int),_ enemyBoard: inout[[Int]],_ trueBoard:[[Bool]]){
    print("ATTACK",attack,terminator:": ");
    //mark as successful attack or not on enemyboard
    if(trueBoard[attack.1][attack.0]){
        print("ATTACK SUCCESSFUL!")
        enemyBoard[attack.1][attack.0] = 1;
        var vert:Bool=true,fullship1:Bool=false,fullship2:Bool=false;
        //check if horizontal or vertical
        if (attack.1>0 && attack.1<9) {
            if(trueBoard[attack.1-1][attack.0] || trueBoard[attack.1+1][attack.0]){
                vert = true
            }
            else{
                vert = false;
            }
        }
        else if (attack.1 == 0) {
            if(!trueBoard[attack.1+1][attack.0])
            {
                vert=false;
            }
        }
        else{
            if(!trueBoard[attack.1-1][attack.0])
            {
                vert=false;
            }
        }
        //check if the ship is fully destroyed
        if(vert){
            var temp: Int = attack.1;
            //check top
            while(temp>0 && enemyBoard[temp][attack.0] == 1){
                if(!trueBoard[temp-1][attack.0]){
                    fullship1=true;
                    break;
                }
                temp-=1;
            }
            temp=attack.1;
            //check bottom
            print("IndexCheck:",terminator:"")
            while(temp<9 && enemyBoard[temp][attack.0]==1){
                print(temp+1,terminator: ",")
                if(!trueBoard[temp+1][attack.0]){
                    fullship2=true;
                    break;
                }
                temp+=1;
            }
            print("")
        }
        else{
            var temp: Int = attack.0;
            //check left
            while(temp>0 && enemyBoard[attack.1][temp] == 1){
                if(!trueBoard[attack.1][temp-1]){
                    fullship1=true;
                    break;
                }
                temp-=1;
            }
            temp=attack.0;
            //check right
            while(temp<9 && enemyBoard[attack.1][temp] == 1){
                if(!trueBoard[attack.1][temp+1]){
                    fullship2=true;
                    break;
                }
                temp+=1;
            }
        }
        // print("FSH1: ", fullship1," FSH2: ", fullship2);
        if(fullship1 && fullship2){
            // print("FULL SHIP TAKEN !");
            //if the ship is completely broken
            //then mark it and the nearbies of it as 3
            if(vert){
                var temp: Int = attack.1;
                while(temp>=0 && truBoard[temp][attack.0]){
                    enemyBoard[temp][attack.0] = 3;
                    if(attack.0 > 0){
                        enemyBoard[temp][attack.0-1] = 3;
                    }
                    if(attack.0 < 9){
                        enemyBoard[temp][attack.0+1] = 3;
                    }
                    temp-=1;
                }
                if(temp>=0){
                    enemyBoard[temp][attack.0] = 3;
                }
                if(attack.1<9){
                    temp=attack.1+1;
                }
                //check bottom
                while(temp<=9 && truBoard[temp][attack.0]){
                    enemyBoard[temp][attack.0] = 3;
                    if(attack.0>0){
                        enemyBoard[temp][attack.0-1] = 3;
                    }
                    if(attack.0<9){
                        enemyBoard[temp][attack.0+1] = 3;
                    }
                    temp+=1;
                }
                if(temp<=9){
                    enemyBoard[temp][attack.0] = 3;
                }
            }
            else{
                print("OK it does recognize that it is actually HORIZ")
                var temp: Int = attack.0;
                //check left
                while(temp>=0 && enemyBoard[attack.1][temp] == 1){
                    enemyBoard[attack.1][temp] = 3;
                    if(attack.1>0){
                        enemyBoard[attack.1-1][temp] = 3;
                    }
                    if(attack.1<9){
                        enemyBoard[attack.1+1][temp] = 3;
                    }
                    temp-=1;
                }
                if(temp>=0){
                    enemyBoard[attack.1][temp] = 3;
                }
                temp=attack.0;
                //check bottom
                while(temp<10 && enemyBoard[attack.1][temp] == 1){
                    enemyBoard[attack.1][temp] = 3;
                    if(attack.1>0){
                        enemyBoard[attack.1-1][temp] = 3;
                    }
                    if(attack.1<9){
                        enemyBoard[attack.1+1][temp] = 3;
                    }
                    temp+=1;
                }
                if(temp<=9){
                    enemyBoard[attack.1][temp] = 3;
                }
            }
            //FULL SHIP MARKED
            print("FULL ship destroyed ! Congratulations!")
        }
    }
    else{
        print("No luck")
        enemyBoard[attack.1][attack.0] = 2;
    }
}
// print(attackByComputer(&enemBoard));
// updateBoards(attackByComputer(&enemBoard),&enemBoard,truBoard);

//THIS FUNCTION
//makes easier combined use of two functions above
//to generate an attack from the program and updates the board automatically
func useAI(_ enemBoard:inout [[Int]], _ truBoard:[[Bool]])->(Int,Int){
    let temp: (Int,Int)=attackByComputer(&enemBoard);
    updateBoards(temp,&enemBoard,truBoard);
    return temp;
}

//THIS CODE
//generates the specific number of steps
//from the computer and prints the board
//along the way
for _ in 0...7{
    temp = useAI(&enemBoard,truBoard);
    printBoard(enemBoard);
}

