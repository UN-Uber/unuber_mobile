// Dart imports:
import 'dart:async';

// Package imports:
import 'package:intl/intl.dart';

/// The class validators is used to define the needed StreamTransformers to validate email and password correctness
class Validators {
  /// The method checkEmail is used to check if the given value is a valid email
  /// - @Param email is the string to be checked
  /// - return true if is a valid email, false other way.
  bool checkEmail(String email) {
    return email.length > 4 && _checkRegEx(email, isEmail: true);
  }

  /// The method checkPasswordSignup is used to check if the given value is a valid password for signup
  /// - @Param password is the string to be checked
  /// - return true if is a valid password, false other way.
  bool checkPasswordSignup(String password) {
    return password.length > 6 && !password.contains(' ');
  }

  /// The method checkPasswordLogin is used to check if the given value is a valid password for login
  /// - @Param password is the string to be checked
  /// - return true if is a valid password, false other way.
  bool checkPasswordLogin(String password) {
    return password.length > 3;
  }

  /// The method checkTelephone is used to check if the given value is a valid telephone number
  /// - @Param number is the string to be checked
  /// - return true if is a valid number, false other way.
  bool checkTelephone(String number) {
    return number.length > 4 && _checkRegEx(number);
  }

  /// Is used to check if the given value match the regular expression
  /// - @Param value is the string to be checked
  /// - @Param isEmail is a flag to check email or phone number
  /// - return true if match, false other way
  static bool _checkRegEx(String value, {bool isEmail = false}) {
    String pattern;

    // Select the pathern to use in the regex
    isEmail
        ? pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'
        : pattern =
            '^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}\$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  final validateCreditCardNumber = StreamTransformer<String, String>.fromHandlers(
    handleData: (creditCardNumber, sink) {
      _validateCardNumber(creditCardNumber) && creditCardNumber.length == 16
      ? sink.add(creditCardNumber) 
      : sink.addError('El número de la tarjeta no es válido.');
    }
  );

  final validateDueDate = StreamTransformer<String, String>.fromHandlers(
    handleData: (dueDate, sink){
      _validateDueDate(dueDate) && dueDate.length == 5
      ? sink.add(dueDate)
      : sink.addError('La tarjeta está vencida.');
    }
  );

  final validateCVV = StreamTransformer<String, String>.fromHandlers(
    handleData: (cvv, sink){
      _validateCVV(cvv)
      ? sink.add(cvv)
      : sink.addError('CVV no es válido.');
    }
  );


  ///   Lunh Algorithm 
  /// 
  ///   The _validateCardNumber function uses the Luhn Algorithm to check
  ///   if the input is a possible valid value for a Credit Card. Only accepts
  ///   the Visa and Mastercard cards which start with 4 and 5 respectively.

  static bool _validateCardNumber(String number){

    // First check if the number satisfies the Regex
    String pattern =  r'([4-5]{1}[0-9]{15})$';
    RegExp regExp = new RegExp(pattern);

    if(!regExp.hasMatch(number)) return false;

    // Takes every second digit starting form the right and
    // multiply it by two, and the add this value to the sum.
    // If the multiply give us a two digit number (is greather than 9) 
    // then subtract 9 from the number
    int sum = 0;
    for(var i = 0; i < number.length; i++){
      int digit = int.parse(number[number.length - i - 1]);

      if (i % 2 == 1){
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    // If the total sum is a multiple of 10, the credit card number is valid
    if (sum % 10 == 0) {
      return true;
    }

    return false;
  }


  ///   The _validateDueDate check if the credit card is expired or not

  static bool _validateDueDate(String date){

    if(date.length != 5) return false;
    
    // Get the current date in this format MM/YY
    final DateTime now = new DateTime.now();
    final DateFormat formatter = new DateFormat('MM/yy');
    final String currentDate = formatter.format(now);

    var currentDateParts = currentDate.split("/");
    var inputDateParts = date.split("/");

    // Compare by the year if the card is expired
    if(int.parse(currentDateParts[1]) > int.parse(inputDateParts[1])){
      return false;
    }

    // If the due date is in the current year then compare the current month with
    // the month in the due date and if the month has alredy passed then the card is expired.
    else if(int.parse(currentDateParts[1]) == int.parse(inputDateParts[1])){
      if(int.parse(currentDateParts[0]) > int.parse(inputDateParts[0])){
        return false;
      }
    }
    
    return true;
  }


  ///   The _validateCVV check by a regular expresion if the cvv is valid or not
  static bool _validateCVV(String cvv){
    String pattern = r'([0-9]{3})$';
    RegExp regExp = new RegExp(pattern);

    if(regExp.hasMatch(cvv)) return true;

    return false;
  }
}
