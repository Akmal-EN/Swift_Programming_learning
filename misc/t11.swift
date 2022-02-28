func trimmer()->String{
    
}
//substr function from to
func substr1(mystr:String,from:Int,to:Int)->String{
    return (mystr.prefix(through:to)).suffix(from:from);
}
//trim function left+right
func trim(mystr:String)->String{
    while(mystr.prefix(1)==" "){
        mystr=mystr.suffix(from:1);
    }
    while(mystr.suffix(1)==" "){
        mystr=mystr.prefix(through:(mystr.count-1));
    }
    return mystr;
}
//getting the operator
func RPN(statement:String)->Int{
    statement=trim(statement);
    var result: Int = 0;
    //getting two numbers
    statement.removeAll(where:{$0 == "(" || $0 == ")"});
    //check if we have statements in the two operands
    statement.suffix()
    //getting the operator 
    var oper:String=statement.suffix(1);
    switch(oper){
        case "+":

        case "-":

        case "*":
        
        case "/":

        default:
            return nil;
    }
    return result;
}
//convert the string to Ints
