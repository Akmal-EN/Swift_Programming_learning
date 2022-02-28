
var mystr: String = "hello world!"
// func substr1(_ mystr:String,_ from:Int,_ to:Int)->String{
    // return (mystr.prefix(through:to)).suffix(from:from);
// }
// func substring(_ mystr:String,_ from:Int, _ len: Int) -> String{
//     return String(String(mystr.suffix(mystr.count-from)).prefix(len))
// }
// print(substring(mystr,1,4))
// print(mystr.suffix(from: ))
// print(String(mystr.reversed()))
// var keepUp: Int = 0, index: Int = 0;

// for chars in mystr{
//     print(keepUp," , ", index)
//     if(chars == " "){
//         index += 10;
//         continue;
//     }
    
//     if(index > keepUp){
//         keepUp += 1;
//         continue;
//     }
//     else{
//         index += 1;
//         keepUp += 1;
//     }
// }
print(String(mystr.suffix(from: String.Index(utf16Offset: 1,in: mystr))))
// // var phrase = "The rain in Spain stays mainly in the plain."


// // let vowels: Set<Character> = ["a", "e", "i", "o", "u"]
// // phrase.removeAll(where: { $0 })
// // // phrase == "Th rn n Spn stys mnly n th pln."
// // print(phrase)
// var tempint: Int = 10;
// func tempfun(_ myint: Int = 10)->Int{
//     myint+=1;
//     return myint;
// }
// tempfun(tempint);
// print(tempint);
// print(Int(" 23123 ")!)

// reverse the input string
// 
// var level: Int = 0;
// var mystr:String = String(input.reversed()); 
//function receives, a string with starting index
//and returns a tuple: (calculated result, finishing index)
//thus the first operand is calculated and then moves on to the next operand with the same scheme
// statement="3 4 +";
    // let allowedChars: Set<Character> = ["0", "1","2", "3","4", "5","6", "7","8", "9","*","/","+","-"]
// RPN(statement,0);
