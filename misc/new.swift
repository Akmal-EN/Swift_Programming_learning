//data types - variables
var mystring: String = "hello world"
print(mystring)
var myfloat: Float  = 3.14;
print(myfloat)
var myint:Int = Int(243.21);
print(myint)
let myconst: Int = Int(2312313);
print(myconst)
//optionals
var perhapsInt: Int? = nil
print(perhapsInt)

//unwrapping
var myoptstr:String?
myoptstr="this is optional string";
print(myoptstr)
print(myoptstr!)

//automatic unwrapping 
var stringo: String!
stringo="why not"
print(stringo!)

//optional binding
var myString:String?
myString = "Optional Binding"

if let yourString = myString {
   print(yourString);
}
//so the scope of that constant is out of this
// print(yourString)
// var error501 = (501,"Not implemented")
// print(error501.0)
var error501 = (errorCode: 501, description: "Not Implemented")
print(error501.errorCode)   // prints 501.

print("This mystring: \(mystring)")
