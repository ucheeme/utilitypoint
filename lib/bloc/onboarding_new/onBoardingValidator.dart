import 'dart:async';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as gett;
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utilitypoint/model/request/loginRequest.dart';
import 'package:utilitypoint/model/request/setTransactionPin.dart';
import 'package:utilitypoint/model/request/verifyEmailRequest.dart';
import 'package:utilitypoint/utils/app_util.dart';
import 'package:utilitypoint/utils/constant.dart';
import 'package:utilitypoint/utils/customValidator.dart';
import 'package:utilitypoint/utils/globalData.dart';

import '../../model/request/accountCreation.dart';
import '../../model/request/changePin.dart';
import '../../model/request/twoFactorAuthenticationRequest.dart';
import '../../model/request/updateUserInfo.dart';
import '../../utils/device_util.dart';
import '../../utils/pages.dart';
import '../../view/onboarding_screen/signUp/accountCreated.dart';
import '../../view/onboarding_screen/signUp/verifyemail.dart';

String tempPassword = '';
String? userId = "";

class OnboardingFormValidation {
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController transactionPinController = TextEditingController();
  TextEditingController twoFactorController = TextEditingController();
  List<Map<String, String>> moreOptionTitle = [
    {"title": "My Cards", "icon": "myAccount_icon"},
    {"title": "Profile", "icon": "profile_icon"},
    {"title": "Transaction History", "icon": "transaction_history"},
    {"title": "Notifications", "icon": "notification_icon"},
    {"title": "Contact Us", "icon": "contactUs_icon"},
    {"title": "Settings", "icon": "setting_icon"},
    {"title": "Log Out", "icon": "logout_icon"}
  ];
  bool isEmailSelected = false;
  bool isFirstNameSelected = false;
  bool isLastNameSelected = false;
  bool isUserNameSelected = false;
  bool isWrongOTP = false;
  bool isCompleteOTP = false;
  bool isLoginUserNameSelected = false;
  bool isLoginPasswordSelected = false;
  bool isPhoneNumberSelected = false;
  bool isReferralCodeSelected = false;
  bool isPasswordSelected = false;
  bool isConfirmPasswordSelected = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isEightCharacterMinimumChecked = false;
  bool isContainsNumChecked = false;
  bool isContainsSymbolChecked = false;
  bool isPasswordMatch = false;
  String tempPassword = "";

  // String confirmPassword="";
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  String? _nameError;

  String? get emailError => _emailError;

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
  final _referralCodeSubject = BehaviorSubject<String>();
  final _loginUserNameSubject = BehaviorSubject<String>();
  final _loginPasswordSubject = BehaviorSubject<String>();
  final _forgotPasswordSubject = BehaviorSubject<String>();
  final _forgotConfirmPasswordSubject = BehaviorSubject<String>();

  Function(String) get setEmail => _emailSubject.sink.add;

  Function(String) get setConfirmPassword => _confirmPasswordSubject.sink.add;

  Function(String) get setPassword => _passwordSubject.sink.add;

  Function(String) get setPhoneNumber => _phoneSubject.sink.add;

  Function(String) get setFirstName => _firstNameSubject.sink.add;

  Function(String) get setLastName => _lastNameSubject.sink.add;

  Function(String) get setUserName => _userNameSubject.sink.add;

  Function(String) get setOtpValue => _otpValueSubject.sink.add;

  Function(String) get setReferralValue => _referralCodeSubject.sink.add;

  Function(String) get setLoginUserName => _loginUserNameSubject.sink.add;

  Function(String) get setLoginPassword => _loginPasswordSubject.sink.add;

  Function(String) get setForgetPassword => _forgotPasswordSubject.sink.add;

  Function(String) get setForgetConfirmPassword =>
      _forgotConfirmPasswordSubject.sink.add;

  Stream<String> get email => _emailSubject.stream.transform(validateEmail);

  Stream<String> get lastName =>
      _lastNameSubject.stream.transform(validateFullName);

  Stream<String> get userName =>
      _userNameSubject.stream.transform(validateUserName);

  Stream<String> get loginUserName =>
      _loginUserNameSubject.stream.transform(validateUserName);

  Stream<String> get phoneNumber =>
      _phoneSubject.stream.transform(validatePhoneNumber);

  Stream<String> get firstName =>
      _firstNameSubject.stream.transform(validateFullName);

  Stream<String> get password =>
      _passwordSubject.stream.transform(validatePassword);

  Stream<String> get loginPassword =>
      _loginPasswordSubject.stream.transform(validatePassword);

  Stream<String> get forgotPassword =>
      _forgotPasswordSubject.stream.transform(validatePassword);

  Stream<String> get referralCode =>
      _referralCodeSubject.stream.transform(validateUserName);

  Stream<String> get confirmPassword =>
      _confirmPasswordSubject.stream.transform(validateConfirmPassword);

  Stream<bool> get completeRegistrationFormValidation => Rx.combineLatest2(
      email,
      confirmPassword,
      (
        email,
        confirmPassword,
      ) =>
          true);

  Stream<bool> get loginCompleteRegistrationFormValidation => Rx.combineLatest2(
      loginUserName,
      loginPassword,
      (
        loginUserName,
        loginPassword,
      ) =>
          true);

  Stream<bool> get completePersonalInformationFormValidation =>
      Rx.combineLatest4(
          firstName,
          lastName,
          userName,
          phoneNumber,
          (
            firstName,
            lastName,
            userName,
            phoneNumber,
          ) =>
              true);

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
    tempPassword = value!;
  }

  final validateFullName = StreamTransformer<String, String>.fromHandlers(
      handleData: (firstName, sink) {
    CustomValidator customValidator = CustomValidator();
    if (customValidator.validatename(firstName) != null) {
      customValidator.validatename(firstName);
      sink.addError(customValidator.validatename(firstName)!);
    } else {
      sink.add(firstName);
    }
  });

  final validateUserName = StreamTransformer<String, String>.fromHandlers(
      handleData: (firstName, sink) {
    CustomValidator customValidator = CustomValidator();
    if (customValidator.validateusername(firstName) != null) {
      customValidator.validateusername(firstName);
      sink.addError(customValidator.validatename(firstName)!);
    } else {
      sink.add(firstName);
    }
  });

  final validatePassword =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    CustomValidator customValidator = CustomValidator();
    if (customValidator.validatePassword(value) != null) {
      sink.addError(customValidator.validatePassword(value)!);
    } else {
      print("this is pasd");
      sink.add(value);
    }
  });

  final validateConfirmPassword =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    CustomValidator customValidator = CustomValidator();
    if (customValidator.validateConfirmPassword(
          value,
        ) !=
        null) {
      sink.addError(customValidator.validateConfirmPassword(value)!);
    } else {
      sink.add(value);
    }
  });

  final validatePhoneNumber =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    CustomValidator customValidator = CustomValidator();
    if (customValidator.validateMobile(value) != null) {
      sink.addError(customValidator.validateMobile(value)!);
    } else {
      sink.add(value);
    }
  });

  final validateOtpValue =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (!value.isNumericOnly) {
      sink.addError('Enter only number');
    } else if (value.isNumericOnly && value.length == 4) {
      sink.add(value);
    }
  });

  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    CustomValidator customValidator = CustomValidator();
    if (customValidator.validateEmail(value) != null) {
      sink.addError(customValidator.validateEmail(value)!);
    } else {
      sink.add(value);
    }
  });

  setFirstNameTemp() {
    firstNameTemp = _firstNameSubject.value;
  }

  bool validatePasswords() {
    if (passwordController.text == _confirmPasswordSubject.value) {
      isPasswordMatch = true;
      return true;
    } else {
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

  CreateAccountRequest createAccountRequest() {
    return CreateAccountRequest(
        email: _emailSubject.value.toLowerCase(),
        password: passwordController.text.trim(),
        passwordConfirmation: _confirmPasswordSubject.value.trim());
  }

  VerifiedEmailRequest verifiedEmailRequest() {
    return VerifiedEmailRequest(userId: userId, otp: otpController.text);
  }

  VerifiedEmailRequest resendVerifiedEmailRequest() {
    return VerifiedEmailRequest(
      userId: userId,
    );
  }

  UpdateUser userInfo() {
    return UpdateUser(
        userId: userId!,
        firstName: _firstNameSubject.value.trim(),
        lastName: _lastNameSubject.value.trim(),
        otherNames: "",
        userName: _userNameSubject.value.trim(),
        phoneNumber: _phoneSubject.value.trim());
  }

  SetTransactionPinRequest setTransactionPinRequest() {
    return SetTransactionPinRequest(
        userId: userId!,
        pin: transactionPinController.text,
        confirmPin: transactionPinController.text);
  }

  LoginUserRequest loginUserRequest() {
    return LoginUserRequest(
        userName: _loginUserNameSubject.value,
        password: _loginPasswordSubject.value,
        deviceName: deviceName);
  }

  TwoFactorAuthenticationRequest twoFactorAuthenticationRequest() {
    return TwoFactorAuthenticationRequest(
        userId: userId!, twoFactorCode: twoFactorController.text);
  }

  ChangePinRequest changePinRequest() {
    return ChangePinRequest(
      userId: userId!,
      currentPin: '1234',
      newPin: transactionPinController.text,
      confirmNewPin: transactionPinController.text,
    );
  }
}
