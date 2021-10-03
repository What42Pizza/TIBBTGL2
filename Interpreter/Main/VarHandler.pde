class VarHandler {
  
  
  
  
  
  ArrayList <Variable> InternalVars = new ArrayList <Variable> ();
  ArrayList <Variable> GlobalVars = new ArrayList <Variable> ();
  ArrayList <VariableList> VariableStack = new ArrayList <VariableList> ();
  VariableList CurrVarList = new VariableList();
  // VariableStack.add(CurrVarList);  // doesn't work here, has to be in constructor
  
  
  
  
  
  public VarHandler() {
    VariableStack.add(CurrVarList);
  }
  
  
  
  
  
  
  
  
  
  
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
  
  
  
  public DataValue SearchForVar (ArrayList <Variable> ListOfVars, String VarName) {
    
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
  
}
