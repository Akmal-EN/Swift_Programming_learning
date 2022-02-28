

//function for dividing the string into 2 operands and an operator
func getOper1(_ mystr:String)->String{
    
}
func getOper2(_ mystr:String)->String{
    var resultstr:String="";    
    var indexer:Int=1;
    while(indexer<mystr.count + 1){
        if(" " == mystr.suffix(indexer).prefix(1)){
            mystr.suffix(indexer-1);
        }
    
    }

}
func temptemp(mystr:String)->String{
    switch(mystr.suffix().prefix()){
        case "+":
        case "-":
        case "*":
        case "/":
        default:

    }
}
func calc(_ operand1:String, _ operand2: String,_ op3rator: String)->Float{
    //recognize if the given operands are statements
    var oper1:Float,oper2:Float;
    if(operand1.suffix(1)<48 || operand1.suffix(1)>57){
        oper1=calc()
    }
}


var statement: String = "(3 3 * 2 2 * +)"
print(statement)
let brackets: Set<Character> = ["(", ")"]
statement.removeAll(where: {$0 == "(" || $0 == ")"});
print(statement)    

func trimmer(_ mystr:String)->String{
    var result:String = mystr;
    let allowedChars: Set<Character> = [" ","0", "1","2", "3","4", "5","6", "7","8", "9","*","/","+","-"]
    result.removeAll(where: {!(allowedChars.contains($0))})
    return result;
}
statement = "123gadsg 5231t *res";
statement=trimmer(statement);
print(statement);
