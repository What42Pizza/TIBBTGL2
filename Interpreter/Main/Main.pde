// Started 08/23/21

// A 1.1.1  (10/04/21)





String[] TestCode = {
  "// Test code:",
  "a = {}",
  "a[1] = \"b\"..\"c\"",
};





void setup() {
  TIBBTGL2_Interpreter Interpreter = new TIBBTGL2_Interpreter();
  Interpreter.CompilePage (TestCode, true);
}



void draw() {
  
}
