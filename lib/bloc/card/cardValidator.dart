import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utilitypoint/model/request/createCard.dart';
import 'package:utilitypoint/model/request/getProduct.dart';
import 'package:utilitypoint/model/request/topUpCard.dart';
import 'package:utilitypoint/model/request/unfreezeCard.dart';

import '../../model/response/listofVirtualCard.dart';
import '../../utils/customValidator.dart';
import '../../view/onboarding_screen/signIn/login_screen.dart';

class Cardvalidator {
  bool isAmountSelected = false;
  List<String> currencies = ["USD"];
  List<String> cardType = ["MASTERCARD", "VISA"];
  List<String> accountInfo = [
    // "Account Information",
    "Transaction History", "Virtual Card"
  ];
  TextEditingController amountController = TextEditingController();
  List<UserVirtualCards> userCards = [];

  String? _amountError;
  String cardId="";
  String startDate ="";
  String endDate ="";

  String? get amountError => _amountError;

  final _amountSubject = BehaviorSubject<String>();
  final _pinSubject = BehaviorSubject<String>();
  final _currenciesSubject = BehaviorSubject<String>();
  final _cardTypeSubject = BehaviorSubject<String>();

  Function(String) get setAmount => _amountSubject.sink.add;

  setCurrency(value) {
    _currenciesSubject.sink.add(value);
  }

  setPin(value){
    _pinSubject.sink.add(value);
  }

  setCardType(value) {
    _cardTypeSubject.sink.add(value);
  }

  Stream<String> get amount => _amountSubject.stream.transform(validatePrice);
  Stream<String> get currency => _currenciesSubject.stream.transform(validateFullName);
  Stream<String> get cardTypee => _cardTypeSubject.stream.transform(validateFullName);
  Stream<bool> get createCardFundComplete => Rx.combineLatest3(
      amount, currency,cardTypee, (amount, currency, cardTypee) => true);

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

  final validatePrice =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    RegExp res = RegExp(r'^[0-9,]*$');
    if (!value.contains(res)) {
      sink.addError("Price can only be digit");
    } else {
      String res = value.replaceAll(",", "");
      sink.add(res);
    }
  });

  CreateCardRequest createCardRequest() {

    return CreateCardRequest(
        userId: loginResponse!.id,
        currency: _currenciesSubject.value.trim(),
        brand: _cardTypeSubject.value.trim(),
        amount: _amountSubject.value.trim(),
        pin: _pinSubject.value.trim(),
        cardType: "virtual");
  }

  TopUpCardRequest topUpCardRequest() {
    return TopUpCardRequest(
        userId: loginResponse!.id,
        cardId: cardId!,
        amount: double.parse(_amountSubject.value));
  }

  GetProductRequest getCardTransactions(){
    return GetProductRequest(
      userId: loginResponse!.id,
      cardId: cardId,
      startDate: startDate,
      endDate: endDate,
    );
  }

  FreezeUnfreezeCard freezeUnfreezeCard(){
    return FreezeUnfreezeCard(userId: loginResponse!.id, cardId: cardId);
  }

}
