class TIBBTGL2_Interpreter {
  
  
  
  
  
  // Vars
  
  Statement[] Code;
  
  
  
  
  
  
  
  
  
  
  // Constructors
  
  public TIBBTGL2_Interpreter() {}
  
  public TIBBTGL2_Interpreter (String[] InputCode) {
    Code = Compile (InputCode, false);
  }
  
  
  
  
  
  
  
  
  
  
  // External functions
  
  public Statement[] Compile (String[] InputCode, boolean PrintDebug) {
    ArrayList <Statement> Out;
    
    ArrayList <PreStatement> CleanedInputCode = CleanInputCode (InputCode);
    if (PrintDebug) for (PreStatement S : CleanedInputCode) {
      println (S.OrigLineNumber + ": " + S.Level + ", \"" + S.Data + "\"");
    }
    
    Out = Tokenize (CleanedInputCode);
    if (PrintDebug) for (Statement S : Out) {
      println (S.OrigLineNumber + ": " + S.Level + ",   " + Misc.CombineStrings (S.Tokens, ", "));
    }
    
    return Misc.ArrayListToArray_Statement (Out);
  }
  
  
  
  
  
  
  
  
  
  
  // Internal functions
  
  ArrayList <PreStatement> CleanInputCode (String[] InputCode) {
    ArrayList <PreStatement> Out = new ArrayList <PreStatement> ();
    for (int i = 0; i < InputCode.length; i ++) {
      String CurrLine = InputCode[i];
      
      // make sure line isn't whitespace
      int CurrLineLength = CurrLine.length();
      boolean FoundNonWhitespace = false;
      for (int j = 0; j < CurrLineLength; j ++) {
        if (!CharIsWhitespace (CurrLine.charAt(j))) {
          FoundNonWhitespace = true;
          break;
        }
      }
      if (!FoundNonWhitespace) continue;
      
      // count tabs (level)
      int Level = 0;
      char CurrChar = CurrLine.charAt(0);
      while (CurrChar == 9) { // tab
        Level ++;
        CurrChar = CurrLine.charAt(Level);
      }
      
      // cut out tabs
      CurrLine = CurrLine.substring(Level);
      
      // add curr line to out
      Out.add (new PreStatement (i, Level, CurrLine));
      
    }
    return Out;
  }
  
  
  
  boolean CharIsWhitespace (char In) {
    return In == 32 || In == 9; // 32 = space, 9 = tab
  }
  
  
  
  
  
  ArrayList <Statement> Tokenize (ArrayList <PreStatement> CleanedInputCode) {
    ArrayList <Statement> Out = new ArrayList <Statement> ();
    
    println ("WIP: Interpreter.Tokenize");
    
    return Out;
  }
  
  
  
  
  
}










class Statement {
  
  int OrigLineNumber;
  int Level;
  String[] Tokens;
  
  public Statement (int OrigLineNumber, int Level, String[] Tokens) {
    this.OrigLineNumber = OrigLineNumber;
    this.Level = Level;
    this.Tokens = Tokens;
  }
  
}



class PreStatement {
  
  int OrigLineNumber;
  int Level;
  String Data;
  
  public PreStatement (int OrigLineNumber, int Level, String Data) {
    this.OrigLineNumber = OrigLineNumber;
    this.Level = Level;
    this.Data = Data;
  }
  
}
