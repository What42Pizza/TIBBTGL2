class TIBBTGL2_Interpreter {
  
  
  
  
  
  // Vars
  
  Page[] AllPages;
  
  
  
  
  
  
  
  
  
  
  // Constructors
  
  public TIBBTGL2_Interpreter() {}
  
  public TIBBTGL2_Interpreter (File CodeIn) {
    
  }
  
  
  
  
  
  
  
  
  
  
  // External functions
  
  public Statement[] CompilePage (String[] InputCode, boolean PrintDebug) {
    ArrayList <Statement> Out;
    
    if (PrintDebug) {
      println();
      println ("Input Code:");
      for (int i = 0; i < InputCode.length; i ++) {
        println (i + ": " + InputCode[i]);
      }
    }
    
    ArrayList <PreStatement> CleanedInputCode = CleanInputCode (InputCode);
    if (PrintDebug) {
      println();
      println ("After Cleaning:");
      for (PreStatement S : CleanedInputCode) {
        println (S.OrigLineNumber + ": " + S.Level + ", \"" + S.Data + "\"");
      }
    }
    
    Out = Tokenize (CleanedInputCode);
    if (PrintDebug) {
      println();
      println ("After Tokenizing:");
      for (Statement S : Out) {
        println (S.OrigLineNumber + ": " + S.Level + ",   " + Misc.CombineStrings (S.Tokens, ", "));
      }
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
      
      // find any comment start
      int SubEnd = CurrLineLength;
      for (int j = 0; j < CurrLineLength - 1; j ++) {
        if (CurrLine.charAt(j) == '/' && CurrLine.charAt(j+1) == '/') {
          SubEnd = j;
          break;
        }
      }
      
      // cut out tabs and comments
      CurrLine = CurrLine.substring(Level, SubEnd);
      
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
    for (PreStatement CurrStatement : CleanedInputCode) {
      
      String CurrLine = CurrStatement.Data;
      ArrayList <String> Tokens = new ArrayList <String> ();
      char[] CurrLineChars = new char [CurrLine.length()];
      CurrLine.getChars(0, CurrLineChars.length, CurrLineChars, 0);
      
      String CurrToken = "";
      for (int i = 0; i < CurrLineChars.length; i ++) {
        //println (i);
        char CurrChar = CurrLineChars[i];
        CurrToken += CurrChar;
        
        // add entire string as token
        if (CurrChar == '"') {
          i ++;  CurrChar = CurrLineChars[i];
          CurrToken += CurrChar;
          while (i < CurrLineChars.length && CurrChar != '"') {
            i ++;  CurrChar = CurrLineChars[i];
            if (CurrChar == '\\') {i ++;  CurrChar = CurrLineChars[i];}
            CurrToken += CurrChar;
          }
          Tokens.add(CurrToken);
          CurrToken = "";
          continue;
        }
        
        // add entire name as token
        if (CharIsNameChar (CurrChar)) {
          i ++;  CurrChar = CurrLineChars[i];
          while (i < CurrLineChars.length - 1 && CharIsNameChar (CurrChar)) {
            CurrToken += CurrChar;
            i ++;  CurrChar = CurrLineChars[i];
          }
          Tokens.add(CurrToken);
          CurrToken = "";
          continue;
        }
        
        if (CurrChar != ' ') Tokens.add(CurrToken);
        
        CurrToken = "";
      }
      
      int StatementLineNumber = CurrStatement.OrigLineNumber;
      int StatementLevel = CurrStatement.Level;
      String[] StatementTokens = Misc.ArrayListToArray_String (Tokens);
      Out.add(new Statement (StatementLineNumber, StatementLevel, StatementTokens));
      
    }
    return Out;
  }
  
  
  
  boolean CharIsNameChar (char CharIn) {
    return (CharIn >= '0' && CharIn <= '9')
      || (CharIn >= 'A' && CharIn <= 'Z')
      || (CharIn >= 'a' && CharIn <= 'z')
      || CharIn == '$'
      || CharIn == '_';
  }
  
  
  
  
  
}










class Statement {
  
  int OrigLineNumber;
  int Level;
  String[] Tokens;
  String MainToken;
  
  public Statement (int OrigLineNumber, int Level, String[] Tokens) {
    this.OrigLineNumber = OrigLineNumber;
    this.Level = Level;
    this.Tokens = Tokens;
    this.MainToken = Tokens[0];
  }
  
  public Statement (int OrigLineNumber, int Level, String[] Tokens, String MainToken) {
    this.OrigLineNumber = OrigLineNumber;
    this.Level = Level;
    this.Tokens = Tokens;
    this.MainToken = MainToken;
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





class Page {
  
  String Name;
  Statement[] Code;
  
  public Page (String Name, Statement[] Code) {
    this.Name = Name;
    this.Code = Code;
  }
  
}
