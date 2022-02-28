
//function to update the board for sunken ships / (not) successful attacks
//mark the nearbies of sunken ships as 3 also
//and when attack is performed and verified if it is vertical or horizontal - 
//also mark the nearbies of the successful attack    
func updateBoards(_ attack:(Int,Int),_ enemyBoard: inout[[Int]],_ trueBoard:[[Bool]]){
    //mark as successful attack or not on enemyboard
    if(trueBoard[attack.1][attack.0]){
        enemyBoard[attack.1][attack.0] = 1;
        var vert:Bool=true,fullship1:Bool=false,fullship2:Bool=false;
        //check if horizontal or vertical
        if(attack.1>0){
            if(!trueBoard[attack.1-1][attack.0]){
                vert = false;
            }
        }
        if(attack.1<9){
            if(!trueBoard[attack.1+1][attack.0]){
                vert = false;
            }
        }
        if(attack.0>0){
            if(trueBoard[attack.1][attack.0-1]){
                vert = false;
            }
        }
        if(attack.0<9){
            if(trueBoard[attack.1][attack.0+1]){
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
            while(temp<9 && enemyBoard[temp][attack.0]==1){
                if(!trueBoard[temp+1][attack.0]){
                    fullship2=true;
                    break;
                }
                temp+=1;
            }
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
            temp=attack.1;
            //check right
            while(temp<9 && enemyBoard[attack.0][temp] == 1){
                if(!trueBoard[attack.1][temp+1]){
                    fullship2=true;
                    break;
                }
                temp+=1;
            }
        }
        if(fullship1 && fullship2){
            //if the ship is completely broken
            //then mark it and the nearbies of it as 3
            if(vert){
                var temp: Int = attack.1;
                while(temp>=0 && enemyBoard[temp][attack.0]==1){
                    enemyBoard[temp][attack.0] = 3;
                    if(attack.0>0){
                        enemyBoard[temp][attack.0-1] = 3;
                    }
                    if(attack.0<9){
                        enemyBoard[temp][attack.0+1] = 3;
                    }
                    temp-=1;
                }
                if(temp>=0){
                    enemyBoard[temp][attack.0] = 3;
                }
                temp=attack.1;
                //check bottom
                while(temp<=9 && enemyBoard[temp][attack.0] == 1){
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
            print("\nFULL ship destroyed ! Congratulations!\n")
        }
    }
    else{
        enemyBoard[attack.1][attack.0] = 2;
    }
}
//if the box is not attacked -> 0
//if the box is attacked and successful -> 1
//if the box is attacked and not successful -> 2
//if the whole ship is gone -> 3
//returns the picked position to attack
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
    print("\nFinding part finished\n");
    if(firstInd == nil){
        //if there are no successfuls then
        //pick any box except the nearbies of sunken ships
        //and except unsuccessful attacks
        //and attack by chance 
        var myrange:[Int]=[0,1,2,3,4,5,6,7,8,9];
        //TODO: CHECK THIS RANDOM FUNCTION
        var temp:Int = Int(myrange.randomElement()!);
        //attack by chance
        while(!enemyBoard[temp].contains(0)){
            if(myrange.count==0){
                print("CANNOT ACCESS ANY UNATTACKED SLOTS !")
                return (0,0);
            }
            myrange.remove(at:temp);
            temp = Int(myrange.randomElement()!);
        }
        return (Int(enemyBoard[temp].firstIndex(of:0)!),temp);
    }
    else{
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
                while(temp>0 && enemyBoard[line][temp] == 2){
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
                while(temp<9 && enemyBoard[line][temp] == 2){
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
func useAI(_ enemBoard: inout[[Int]], _ truBoard:[[Bool]]){
    updateBoards(attackByComputer(&enemBoard),&enemBoard,truBoard);
}
useAI(&enemyBoard,myBoard);