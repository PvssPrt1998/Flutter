import 'package:atm/atmPage/mainpagecolumns/errorMessageForUserItem.dart';
import 'package:flutter/material.dart';
import 'package:atm/atmPage/mainpagecolumns/atmbillslist/atmbillslist.dart';
import '../../../ATMBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class WidgetFactory {
  ErrorMessageType createErrorMessageProduct();
  NormalType createNormalAbstractProduct();
}

//concreteFactory
class BillBalanceFactory extends WidgetFactory {
  @override
  ErrorMessageType createErrorMessageProduct() {
    return ErrorMessageATMBalance();
  }

  @override
  NormalType createNormalAbstractProduct() {
    return ATMBalance();
  }
}

class IssuedBillsFactory extends WidgetFactory {
  @override
  ErrorMessageType createErrorMessageProduct() {
    return ErrorMessageBillIssue();
  }

  @override
  NormalType createNormalAbstractProduct() {
    return IssuedBills();
  }
}
//ConcreteFactory

abstract class ErrorMessageType {
  Widget createErrorMessageWidget();
}

class ErrorMessageATMBalance extends ErrorMessageType {
  @override
  Widget createErrorMessageWidget() {
    return errorMessageForUserItem('Банкомат пуст');
  }
}

class ErrorMessageBillIssue extends ErrorMessageType {
  @override
  Widget createErrorMessageWidget() {
    return errorMessageForUserItem('Банкомат не может выдать запрашиваемую сумму');
  }
}

abstract class NormalType {
  Widget createWidget(List<String> list);
}

class ATMBalance extends NormalType {
  @override
  Widget createWidget(List<String> list) {
    return atmBillList(list, 'Баланс банкомата');
  }
}

class IssuedBills extends NormalType {
  @override
  Widget createWidget(List<String> list) {
    return atmBillList(list, 'Банкомат выдал следующие купюры');
  }
}

Widget billBalanceWidget() {
  return BlocBuilder<ATMBalanceBloc, List<String>>(
    //bloc: bloc,
      builder: (context, stateString) {
        if (stateString.isEmpty) {
          return BillBalanceFactory()
              .createErrorMessageProduct()
              .createErrorMessageWidget();
        } else {
          return BillBalanceFactory()
              .createNormalAbstractProduct()
              .createWidget(stateString);
        }
      }
  );
}

Widget billIssuedWidget() {
  return BlocBuilder<ATMIssueBloc, List<String>>(
      builder: (context, stateString) {
        if (stateString.isEmpty) {
          return IssuedBillsFactory()
              .createErrorMessageProduct()
              .createErrorMessageWidget();
        } else {
          return IssuedBillsFactory()
              .createNormalAbstractProduct()
              .createWidget(stateString);
        }
      }
  );
}