class Validation {

  String? validateUserName(value){
    if(value!.isEmpty){
      return "Required Field";
    }else{
      return null;
    }
  }

  String? validatePassword(value){
    if(value!.isEmpty){
      return "Required Field";
    }else if(value.toString().length<8){
      return "Password must be 8 characters";
    }else{
      return null;
    }
  }



}