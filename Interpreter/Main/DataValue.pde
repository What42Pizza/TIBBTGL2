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
  
  
  
  
  
  void SetTo (DataValue OtherDV) {
    Type = OtherDV.Type;
    switch (Type) {
      
      case (DataValueTypes.T_Null):
        break;
      
      case (DataValueTypes.T_Int):
        IntValue = OtherDV.IntValue;
        break;
      
      case (DataValueTypes.T_Float):
        FloatValue = OtherDV.FloatValue;
        break;
      
      case (DataValueTypes.T_Bool):
        BoolValue = OtherDV.BoolValue;
        break;
      
      case (DataValueTypes.T_String):
        StringValue = OtherDV.StringValue;
        break;
      
      case (DataValueTypes.T_Array):
        ArrayValue = (ArrayList <DataValue>) OtherDV.ArrayValue.clone();
        break;
      
    }
  }
  
  
  
  
  
}










//DataValueTypes DataValueTypes = new DataValueTypes();

static class DataValueTypes {
  
  final static int T_Null = 0;
  final static int T_Int = 1;
  final static int T_Float = 2;
  final static int T_Bool = 3;
  final static int T_String = 4;
  final static int T_Array = 5;
  
  static String[] Names = {
    "Null",
    "Inf",
    "-Inf",
    "Int",
    "Float",
    "Bool",
    "String",
    "Array"
  };
  
  static String GetNameFromType (int Type) throws ArrayIndexOutOfBoundsException {
    return Names[Type];
  }
  
  static String GetNameFromDataValue (DataValue DV) {
    return Names[DV.Type];
  }
  
}
