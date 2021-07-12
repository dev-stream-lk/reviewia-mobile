import 'package:reviewia/screens/register_page.dart';

class Validation {

  String? validateUserName(value){
    if(value!.isEmpty){
      return "A Required Field";
    }else{
      return null;
    }
  }

  String? validatePassword(value){
    if(value!.isEmpty){
      return "A Required Field";
    }else if(value.toString().length<8){
      return "Password must be 8 characters";
    }else{
      return null;
    }
  }

  String? validateName(value){
    // print((value.toString().contains(new RegExp(r'[^a-zA-Z]')).toString()));
    if(value!.isEmpty){
      return "A Required Field";
    }else if(value.toString().contains(new RegExp(r'[0-9]'))){
      return "Cannot contain Numbers";
    }else if((value.toString().contains(new RegExp(r'[^a-zA-Z]')))){
      return "Cannot include Special Characters";
    }else{
      return null;
    }
  }

  String? validateEmail(value){
    // print((value.toString().contains(new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))).toString());
    if(value!.isEmpty){
      return "A Required Field";
    }else if(!(value.toString().contains(new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")))){
      return "Not a valid type of Email";
    }else{
      return null;
    }
  }

  String? validPasswordReg(value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    String upperCase = r'(?=.*[A-Z])';
    String lowerCase = r'(?=.*[a-z])';
    String number = r'(?=.*?[0-9])';
    String sc = r'(?=.*?[!@#\$&*~])';
    print(value.toString().contains(new RegExp(pattern)).toString());
    if(value!.isEmpty){
      return "A Required Field";
    }else if(!(value.toString().contains(new RegExp(upperCase)))){
      return "Should include Minimum 1 upper case";
    }else if(!(value.toString().contains(new RegExp(lowerCase)))){
      return "Should include Minimum 1 lower case";
    }else if(!(value.toString().contains(new RegExp(number)))){
      return "Should include Minimum 1 Number";
    }else if(!(value.toString().contains(new RegExp(sc)))){
      return "Should include Minimum 1 special character";
    }
    else if(value.toString().length<8){
      return "Minimum length must be 8";
    }else{
      return null;
    }
  }





}