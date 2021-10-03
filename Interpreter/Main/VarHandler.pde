class VarHandler {
  
  
  
  
  
  ArrayList <Variable> InternalVars;
  ArrayList <Variable> GlobalVars;
  ArrayList <VariableList> VariableStack;
  VariableList CurrVarList;
  
  
  
  
  
  public VarHandler() {
    InternalVars = new ArrayList <Variable> ();
    GlobalVars = new ArrayList <Variable> ();
    Reset();
  }
  
  
  
  
  
  
  
  
  
  
  // external functions
  
  
  
  public void AddVar (String VarName, DataValue VarValue) {
    Variable VarToAdd = new Variable (VarName, VarValue);
    switch (GetVarType (VarName)) {
      case (0):  CurrVarList.add(VarToAdd); return;
      case (1):   GlobalVars.add(VarToAdd); return;
      case (2): InternalVars.add(VarToAdd); return;
    }
    throw (new RuntimeException ("This should never be thrown since the previous switch has to recieve a number from 0 to 2, meaning it will always return"));
  }
  
  
  
  
  
  public DataValue GetVar (String VarName) {
    switch (GetVarType (VarName)) {
      case (0): return SearchForVar (CurrVarList.Vars, VarName);
      case (1): return SearchForVar (GlobalVars      , VarName);
      case (2): return SearchForVar (InternalVars    , VarName);
    }
    throw (new RuntimeException ("This should never be thrown since the previous switch has to recieve a number from 0 to 2, meaning it will always return"));
  }
  
  
  
  
  
  // entering a code block
  public void IncreaseLevel() {
    CurrVarList.IncreaseLevel();
  }
  
  // exitting a code block
  public void DecreaseLevel() {
    CurrVarList.DecreaseLevel();
  }
  
  // calling a function
  public void PushVars() {
    VariableStack.add(CurrVarList);
    CurrVarList = new VariableList();
  }
  
  // returning from a function
  public void PopVars() {
    CurrVarList = VariableStack.remove(VariableStack.size()-1);
  }
  
  
  
  // going to a new page (or first init)
  public void Reset() {
    VariableStack = new ArrayList <VariableList> ();
    CurrVarList = new VariableList();
  }
  
  
  
  
  
  
  
  
  
  
  // internal functions
  
  
  
  DataValue SearchForVar (ArrayList <Variable> ListOfVars, String VarName) {
    
    // search for var
    for (Variable CurrVar : ListOfVars) {
      if (CurrVar.Name.equals(VarName)) return CurrVar.Value;
    }
    
    // add var if not found
    DataValue Out = new DataValue();
    ListOfVars.add (new Variable (VarName, Out));
    return Out;
    
  }
  
  
  
  int GetVarType (Variable VarIn) {
    return GetVarType (VarIn.Name);
  }
  
  int GetVarType (String VarName) {
    switch (VarName.charAt(0)) {
      default: return 0;
      case ('_'): return 1;
      case ('$'): return 2;
    }
  }
  
  
  
  
  
}










class Variable {
  
  String Name;
  DataValue Value;
  
  public Variable (String Name, DataValue Value) {
    this.Name = Name;
    this.Value = Value;
  }
  
}





class VariableList {
  
  ArrayList <Variable> Vars = new ArrayList <Variable> ();
  ArrayList <Integer> LevelIndices = new ArrayList <Integer> ();
  
  public VariableList() {}
  
  public void add (Variable VarIn) {
    Vars.add(VarIn);
  }
  
  public void IncreaseLevel() {
    LevelIndices.add (Vars.size());
  }
  
  public void DecreaseLevel() {
    int NewLength = LevelIndices.remove(LevelIndices.size()-1);
    int NumToRemove = Vars.size() - NewLength;
    int Index = Vars.size() - 1;
    for (int i = 0; i < NumToRemove; i ++) {
      Vars.remove(Index);
      Index --;
    }
  }
  
}
