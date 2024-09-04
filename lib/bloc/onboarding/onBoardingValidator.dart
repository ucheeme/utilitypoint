import 'dart:async';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'as gett;
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utilitypoint/utils/app_util.dart';
import 'package:utilitypoint/utils/customValidator.dart';

import '../../utils/pages.dart';
import '../../view/onboarding_screen/signUp/accountCreated.dart';
import '../../view/onboarding_screen/signUp/verifyemail.dart';
String tempPassword='';
class OnboardingFormValidation{
  TextEditingController passwordController = TextEditingController();
  bool isEmailSelected = false;
  bool isFirstNameSelected = false;
  bool isLastNameSelected = false;
  bool isUserNameSelected = false;
  bool isPhoneNumberSelected = false;
  bool isReferralCodeSelected = false;
  bool isPasswordSelected = false;
  bool isConfirmPasswordSelected = false;
  bool isPasswordVisible=false;
  bool isConfirmPasswordVisible=false;
  bool isEightCharacterMinimumChecked = false;
  bool isContainsNumChecked = false;
  bool isContainsSymbolChecked = false;
  bool isPasswordMatch = false;
  String tempPassword="";
  // String confirmPassword="";
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  String? _nameError;
  String? get emailError =>_emailError;

  String? get phoneError => _phoneError;

  String? get nameError => _nameError;
  String? get passwordError => _passwordError;

  final _emailSubject = BehaviorSubject<String>();
  final _passwordSubject = BehaviorSubject<String>();
  final _confirmPasswordSubject = BehaviorSubject<String>();
  final _phoneSubject = BehaviorSubject<String>();
  final _firstNameSubject = BehaviorSubject<String>();
  final _lastNameSubject = BehaviorSubject<String>();
  final _userNameSubject = BehaviorSubject<String>();
  final _otpValueSubject = BehaviorSubject<String>();

  Function(String) get setEmail=> _emailSubject.sink.add;
  Function(String) get setConfirmPassword =>_confirmPasswordSubject.sink.add;
  Function(String) get setPassword=> _passwordSubject.sink.add;
  Function(String) get setPhoneNumber=> _phoneSubject.sink.add;
  Function(String) get setFirstName=> _firstNameSubject.sink.add;
  Function(String) get setLastName=> _lastNameSubject.sink.add;
  Function(String) get setUserName=> _userNameSubject.sink.add;
  Function(String) get setOtpValue => _otpValueSubject.sink.add;

  Stream<String> get email => _emailSubject.stream.transform(validateEmail);
  Stream<String> get lastName => _lastNameSubject.stream.transform(validateFullName);
  Stream<String> get userName => _userNameSubject.stream.transform(validateFullName);
  Stream<String> get phoneNumber => _phoneSubject.stream.transform(validatePhoneNumber);
  Stream<String> get firstName => _firstNameSubject.stream.transform(validateFullName);
  Stream<String> get password => _passwordSubject.stream.transform(validatePassword);
  Stream<String> get confirmPassword => _confirmPasswordSubject.stream.transform(validateConfirmPassword);
  Stream<bool> get completeRegistrationFormValidation => Rx.combineLatest2(email, confirmPassword, (email, confirmPassword,) => true);
  Stream<bool> get completePersonalInformationFormValidation => Rx.combineLatest4(
      firstName, lastName,userName,phoneNumber, ( firstName, lastName,userName,phoneNumber,) => true);
  Stream<String> get otpValue =>
      _otpValueSubject.stream.transform(validateOtpValue);
  setEmailError(String? value) {
    _emailError = value;
  }

   setPasswordError(String? value) {
    _passwordError = value;
  }

  setNameError(String? value) {
    _nameError = value;
  }
  setTempPassword(String? value) {
    tempPassword= value!;
  }
  final validateFullName = StreamTransformer<String, String>.fromHandlers(
      handleData: (firstName, sink) {
        CustomValidator customValidator = CustomValidator();
        if (customValidator.validatename(firstName)!=null) {
          customValidator.validatename(firstName);
          sink.addError(customValidator.validatename(firstName)!);
        } else {

          sink.add(firstName);
        }
      }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        String password="";
        CustomValidator customValidator = CustomValidator();
        if (customValidator.validatePassword(value)!=null) {
          sink.addError(customValidator.validatePassword(value)!);
        } else {
          print("this is pasd");
          password = value;
          sink.add(value);
        }
      }
  );

  final validateConfirmPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        CustomValidator customValidator = CustomValidator();
        if (customValidator.validateConfirmPassword(value,)!=null) {
          sink.addError(customValidator.validateConfirmPassword(value)!);
        } else {
          sink.add(value);
        }
      }
  );

  final validatePhoneNumber = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        CustomValidator customValidator = CustomValidator();
        if (customValidator.validateMobile(value)!=null) {
          sink.addError(customValidator.validateMobile(value)!);
        } else {
          sink.add(value);
        }
      }
  );


  final validateOtpValue = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        if (!value.isNumericOnly) {
          sink.addError('Enter only number');
        } else {
          sink.add(value);
        }
      }
  );

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        CustomValidator customValidator = CustomValidator();
        if (customValidator.validateEmail(value)!=null) {
          sink.addError(customValidator.validateEmail(value)!);
        } else {
          sink.add(value);
        }
      }
  );

  setFirstNameTemp(){
    firstNameTemp =_firstNameSubject.value;
  }

  validateUserPassword(bool response, BuildContext context){
    if(response){
      gett.Get.toNamed(Pages.otpVerification,);
    }else{
      AppUtils.showInfoSnackFromBottom("Please accept privacy policy to proceed", context);
    }
  }

  bool validatePasswords(){
    if(passwordController.text==_confirmPasswordSubject.value ){
      isPasswordMatch = true;
      return true;
    }else{
      isPasswordMatch = false;
      return false;
    }
  }

  bool isValidString(String input) {
    final symbolPattern = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    final numberPattern = RegExp(r'\d');

    bool containsSymbol = symbolPattern.hasMatch(input);

    bool containsNumber = numberPattern.hasMatch(input);
    bool hasValidLength = input.length > 7;

    return containsSymbol && containsNumber && hasValidLength;
  }
}