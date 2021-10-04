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
        println (i + ": \"" + InputCode[i] + '"');
      }
    }
    
    ArrayList <PreStatement1> CleanedCode = CleanInputCode (InputCode);
    if (PrintDebug) {
      println();
      println ("After Cleaning:");
      for (PreStatement1 S : CleanedCode) {
        println (S.OrigLineNumber + ": " + S.Level + ", '" + S.Data + '\'');
      }
    }
    
    ArrayList <PreStatement2> TokenizedCode = Tokenize (CleanedCode);
    if (PrintDebug) {
      println();
      println ("After Tokenizing:");
      for (PreStatement2 S : TokenizedCode) {
        println (S.OrigLineNumber + ": " + S.Level + ",   " + Misc.CombineStrings ('\'', S.Tokens, "', '", '\''));
      }
    }
    
    Out = new ArrayList <Statement> ();
    return Misc.ArrayListToArray_Statement (Out);
  }
  
  
  
  
  
  
  
  
  
  
  // Internal functions
  
  
  
  ArrayList <PreStatement1> CleanInputCode (String[] InputCode) {
    ArrayList <PreStatement1> Out = new ArrayList <PreStatement1> ();
    for (int i = 0; i < InputCode.length; i ++) {
      PreStatement1 CleanedInputCodeLine = CleanInputCodeLine (InputCode[i], i);
      if (CleanedInputCodeLine != null) {
        Out.add (CleanedInputCodeLine);
      }
    }
    return Out;
  }
  
  
  
  PreStatement1 CleanInputCodeLine (String CurrLine, int i) {
    
    // count tabs (level)
    int Level = 0;
    char CurrChar = CurrLine.charAt(0);
    while (CurrChar == 9) { // tab
      Level ++;
      CurrChar = CurrLine.charAt(Level);
    }
    
    // find any comment start
    int CurrLineLength = CurrLine.length();
    for (int j = 0; j < CurrLineLength - 1; j ++) {
      if (CurrLine.charAt(j) == '/' && CurrLine.charAt(j+1) == '/') {
        CurrLineLength = j;
        break;
      }
    }
    
    // cut out tabs and comments
    CurrLine = CurrLine.substring(Level, CurrLineLength);
    
    // make sure line isn't just whitespace
    boolean FoundNonWhitespace = false;
    for (int j = 0; j < CurrLineLength; j ++) {
      if (!CharIsWhitespace (CurrLine.charAt(j))) {
        FoundNonWhitespace = true;
        break;
      }
    }
    if (!FoundNonWhitespace) return null;
    
    // return
    return new PreStatement1 (i, Level, CurrLine);
    
  }
  
  
  
  boolean CharIsWhitespace (char In) {
    return In == 32 || In == 9; // 32 = space, 9 = tab
  }
  
  
  
  
  
  
  
  
  
  
  ArrayList <PreStatement2> Tokenize (ArrayList <PreStatement1> CleanedInputCode) {
    ArrayList <PreStatement2> Out = new ArrayList <PreStatement2> ();
    for (PreStatement1 CurrStatement : CleanedInputCode) {
      Out.add(TokenizeStatement (CurrStatement));
    }
    return Out;
  }
  
  
  
  PreStatement2 TokenizeStatement (PreStatement1 CurrStatement) {
    String CurrLine = CurrStatement.Data;
    ArrayList <String> Tokens = new ArrayList <String> ();
    char[] CurrLineChars = new char [CurrLine.length()];
    CurrLine.getChars(0, CurrLineChars.length, CurrLineChars, 0);
    
    String CurrToken = "";
    for (int i = 0; i < CurrLineChars.length; i ++) {
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
        i --;
        Tokens.add(CurrToken);
        CurrToken = "";
        continue;
      }
      
      if (CurrChar != ' ') Tokens.add(CurrToken);
      
      CurrToken = "";
    }
    
    int LineNumber = CurrStatement.OrigLineNumber;
    int Level = CurrStatement.Level;
    String[] TokensArray = Misc.ArrayListToArray_String (Tokens);
    return new PreStatement2 (LineNumber, Level, TokensArray);
    
  }
  
  
  
  boolean CharIsNameChar (char CharIn) {
    return (CharIn >= '0' && CharIn <= '9')
      || (CharIn >= 'A' && CharIn <= 'Z')
      || (CharIn >= 'a' && CharIn <= 'z')
      || CharIn == '$'
      || CharIn == '_';
  }
  
  
  
  
  
  
  
  
  
  
}










// Structures





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



class PreStatement1 {
  
  int OrigLineNumber;
  int Level;
  String Data;
  
  public PreStatement1 (int OrigLineNumber, int Level, String Data) {
    this.OrigLineNumber = OrigLineNumber;
    this.Level = Level;
    this.Data = Data;
  }
  
}



class PreStatement2 {
  
  int OrigLineNumber;
  int Level;
  String[] Tokens;
  
  public PreStatement2 (int OrigLineNumber, int Level, String[] Tokens) {
    this.OrigLineNumber = OrigLineNumber;
    this.Level = Level;
    this.Tokens = Tokens;
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
