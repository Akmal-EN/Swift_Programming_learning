//PLEASE INPUT YOUR STATEMENT INTO THE VARIABLE BELOW
var INPUT_STATEMENT: String = "124 123 -"

func trimmer(_ mystr:String)->String{
    var strtemp:String = mystr;
    let allowedChars: Set<Character> = ["."," ","0", "1","2", "3","4", "5","6", "7","8", "9","*","/","+","-","%"]
    strtemp.removeAll(where: {!(allowedChars.contains($0))})
    while(String(strtemp.prefix(1)) == " "){
        strtemp = String(strtemp.suffix(strtemp.count-1));
    }
    while(String(strtemp.suffix(1)) == " "){
        strtemp = String(strtemp.prefix(strtemp.count-1));
    }
    return strtemp;
}
// trimmed inverse string is passed to the function
func RPN(_ input: String)->(Double,Int){
    let mystr = input;
    var oper1:Bool = true,oper2:Bool = true;
    let digits: Set<Character> = [".","1","2","3","4","5","6","7","8","9","0"];
    let operators: Set<Character> = ["+","-","%","*","/"];
    var temp: (Double,Int);
    var operand1:Double! = nil,operand2:Double! = nil,index: Int = 0;
    var opertor:String = "";
    var tempoper:String = "";
    var keepUp:Int = 0;
    for chars in mystr{
        // print(index, " , ",keepUp)
        if (keepUp < index){
            keepUp += 1; 
            continue;
        }
        //get the operator
        if(index == 0){
            if(operators.contains(chars)){
                opertor = String(chars);
                keepUp += 1;
                index += 1;
                continue;
            }
            else{
                print("\nERROR: missing operator");
                break;
            }
        }
        //get the first operand
        if(operators.contains(chars)){
            temp = RPN(String(mystr.suffix(from: String.Index(utf16Offset: index,in: mystr))));
            if(oper1){
                operand1 = temp.0;
                oper1 = false;
            }
            else{
                operand2 = temp.0;
                oper2 = false;
            }
            index += temp.1;
        }
        else if(digits.contains(chars)){
            tempoper += String(chars);
        }
        //if it is the end of the operand
        else if(chars == " "){
            if(tempoper == ""){
                if(!oper2){
                    break;
                }
                index+=1;
                keepUp+=1;
                continue;
                // print("ERROR: no operand found")
                // break;
            }
            // print(String(tempoper.reversed()));
            if(oper1){
                operand1 = Double(String(tempoper.reversed()))!;
                oper1 = false;
            }
            else{
                oper2 = false;
                break;
            }
            tempoper = "";
         }
        index+=1;
        keepUp+=1;
    }
    if(operand2 == nil)
    { 
        operand2=Double(String(tempoper.reversed()))!;
    }
    var result: Double;
    if(operand1 == nil || operand2 == nil){
        print("ERROR: one of the operands is missing, or the statement is written INCORRECTLY")
        return (0,0);
    }
    //calculation part
    switch (opertor){
        case "+":
            result = operand1 + operand2;
        case "-":
            result = Double(Double(operand2!) - Double(operand1!));
        case "*":
            result = operand1 * operand2;
        case "/":
            result = operand2/operand1;
        case "%":
            result = Double(Int(operand2) % Int(operand1)) ;
        default:
            print("ERROR: operator not found !")
            return (0,0);
    }
    // print(operand1!,oper1,operand2!)
    // print("The index returned: ", index)
    return (result,index);
}
INPUT_STATEMENT = trimmer(INPUT_STATEMENT)
print(INPUT_STATEMENT,"=",terminator:" ");
INPUT_STATEMENT = String(INPUT_STATEMENT.reversed());
print(RPN(INPUT_STATEMENT).0)
