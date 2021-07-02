String validatePassword(String value) {
/* Pattern pattern =
     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
 RegExp regex = new RegExp(pattern);
 print(value);*/

  if (value.isEmpty) {
    return 'Please enter password';
  }
  else {
    if(value.length<6)
      return 'Value is greater than 6';
    else
      return null;
  }
}

String validatename(String value) {

  if (value.isEmpty) {
    return 'Please enter password';
  }
  else {
      return null;
  }
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  print(value);
  if (value.isEmpty) {
    return 'Please enter email';
  } else {
    if (!regex.hasMatch(value))
      return 'Enter valid email';
    else
      return null;
  }
}

String validatePrice(String value) {
  String patttern = r'(^(?:[+0]9)?[0-9]$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return 'Please enter Price';
  }
  return null;
}


String validateQty(String value) {
  String patttern = r'(^(?:[+0]9)?[0-9]$)';
  if (value.length == 0) {
    return 'Please enter Quantity';
  }

  return null;
}


