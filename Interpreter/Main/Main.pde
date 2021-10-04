// Started 08/23/21

// A 1.1.0  (10/03/21)





String[] TestCode = {
  "test1 test2 test3",
  "test4 // test",
  "\t",
  "\ttest5 \"test6 test7\"",
  "\t\ttest8",
  "test9",
  "\ttest10",
  ""
};





void setup() {
  TIBBTGL2_Interpreter Interpreter = new TIBBTGL2_Interpreter();
  Interpreter.CompilePage (TestCode, true);
}



void draw() {
  
}
