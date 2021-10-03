static class Misc {
  
  
  
  static String[] ArrayListToArray_String (ArrayList <String> In) {
    String[] Out = new String [In.size()];
    for (int i = 0; i < Out.length; i ++) {
      Out[i] = In.get(i);
    }
    return Out;
  }
  
  static Statement[] ArrayListToArray_Statement (ArrayList <Statement> In) {
    Statement[] Out = new Statement [In.size()];
    for (int i = 0; i < Out.length; i ++) {
      Out[i] = In.get(i);
    }
    return Out;
  }
  
  
  
  static String CombineStrings (String[] In, String Seperator) {
    if (In.length == 0) return "";
    String Out = In[0];
    for (int i = 1; i < In.length; i ++) {
      Out += Seperator + In[i];
    }
    return Out;
  }
  
  
  
}
