// Started 08/23/21
// Last updated 10/02/21





String[] TestCode = {
  "test1 test2 test3",
  "test4",
  "\t",
  "\ttest5 test6",
  "\t\ttest7",
  "tets8",
  "\ttest9",
  ""
};





void setup() {
  TIBBTGL2_Interpreter Interpreter = new TIBBTGL2_Interpreter();
  Interpreter.Compile (TestCode, true);
}



void draw() {
  
}
