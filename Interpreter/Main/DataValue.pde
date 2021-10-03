class DataValue {
  
  
  
  
  
  int Type;
  
  long IntValue;
  double FloatValue;
  boolean BoolValue;
  String StringValue;
  ArrayList <DataValue> ArrayValue;
  
  
  
  
  
  public DataValue() {
    Type = DataValueTypes.T_Null;
  }
  
  public DataValue (long IntValue) {
    Type = DataValueTypes.T_Int;
    this.IntValue = IntValue;
  }
  
  public DataValue (double FloatValue) {
    Type = DataValueTypes.T_Float;
    this.FloatValue = FloatValue;
  }
  
  public DataValue (boolean BoolValue) {
    Type = DataValueTypes.T_Bool;
    this.BoolValue = BoolValue;
  }
  
  public DataValue (String StringValue) {
    Type = DataValueTypes.T_String;
    this.StringValue = StringValue;
  }
  
  public DataValue (ArrayList <DataValue> ArrayValue) {
    Type = DataValueTypes.T_Array;
    this.ArrayValue = ArrayValue;
  }
  
  
  
  
  
  String GetType() {
    return DataValueTypes.GetNameFromDataValue (this);
  }
  
  
  
  
  
}










DataValueTypes DataValueTypes = new DataValueTypes();

class DataValueTypes {
  
  int T_Null = 0;
  int T_Inf = 1;
  int T_NegInf = 2;
  int T_Int = 3;
  int T_Float = 4;
  int T_Bool = 5;
  int T_String = 6;
  int T_Array = 7;
  
  String[] Names = {
    "Null",
    "Inf",
    "-Inf",
    "Int",
    "Float",
    "Bool",
    "String",
    "Array"
  };
  
  String GetNameFromType (int Type) throws ArrayIndexOutOfBoundsException {
    return Names[Type];
  }
  
  String GetNameFromDataValue (DataValue DV) {
    return Names[DV.Type];
  }
  
}
