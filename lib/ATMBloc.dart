import 'package:flutter_bloc/flutter_bloc.dart';
import 'Model/ATM.dart';

abstract class ATMEvent {}

class IssueButtonPressed extends ATMEvent {}
class TextEdited extends ATMEvent {
  final String text;
  TextEdited(this.text);
}

class ATMBalanceBloc extends Bloc<ATMEvent, List<String>> {
  ATMBalanceBloc(ATM atm) : super(atm.billsPacksList()) {
    on<IssueButtonPressed>((event, emit) {
      return emit(atm.billsPacksList());
    });
  }
}

class ATMIssueBloc extends Bloc<ATMEvent, List<String>> {
  var text = '';

  ATMIssueBloc(ATM atm) : super([]) {
    on<IssueButtonPressed>((event, emit) {
      return emit(atm.issueBills());
    });
    on<TextEdited>((event, emit) {
      atm.text = event.text;
    });
  }
}

class ATMIssueTextFieldBloc extends Bloc<ATMEvent, bool> {
  var text = '';
  ATMIssueTextFieldBloc(ATM atm) : super(false) {
    on<TextEdited>((event, emit) {
      atm.text = event.text;
      return atm.text == '' ? emit(false) : emit(true);
    });
  }
}