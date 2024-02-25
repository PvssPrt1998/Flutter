import 'dart:developer' as developer;

import 'Bill.dart';

class ATM {

  String text = '';

  List<Bill> bills = [
    Bill(100,50),
    Bill(500,5),
    Bill(200,100),
    Bill(1000,5),
    Bill(2000,100),
    Bill(5000,10)
  ];

  List<String> billsPacksList() {
    return bills.map((bill) =>
    '${bill.amount.truncate()} X ${bill.denomination.truncate() } рублей').toList();
  }
  
  double sumOfBills() {
    return bills.map((bill) => (bill.denomination * bill.amount))
        .reduce((value, element) => value + element);
  }
  
  bool isEnoughMoneyInATM(double sumForIssuance) {
    return sumOfBills()>sumForIssuance;
  }

  double denominationByIndex(int index) {
    return bills[index].denomination;
  }

  int amountOfBillsByIndex(int index) {
    return bills[index].amount;
  }

  bool isATMEmpty() {
    return bills.isEmpty;
  }

  List<String> issueBills() {
    var sum = double.tryParse(text);
    if (sum != null) {

      if (!isEnoughMoneyInATM(sum)) {
        return [];
      } else {
        return issueBillsHelper(sum);
      }
    } else { return []; }
  }

  List<String> issueBillsHelper(double sum) {

    Map<double, int> billMap = {};
    List<double> denomenationSortedList = [];

    for (var element in bills) {
      billMap[element.denomination] = element.amount;
      denomenationSortedList.add(element.denomination);
    }

    denomenationSortedList.sort((a,b) => a.compareTo(b));

    var issueSum = sum;
    List<double> denominationForReturn = [];
    Map<double, int> mapDenominationAmount = {};

    while(issueSum > 0) {
      var billIndex = search(denomenationSortedList, issueSum, denomenationSortedList.length - 1);
      if (billIndex < 0) {
        return [];
      }
      var denomination = denomenationSortedList[billIndex];
      issueSum = issueSum - denomination;

      if (!denominationForReturn.contains(denomination)) {
        denominationForReturn.add(denomination);
        mapDenominationAmount[denomination] = 1;
      } else {
        var c = mapDenominationAmount[denomination];
        if (c != null) {
          c++;
          mapDenominationAmount[denomination] = c;
        }
      }

      var d = billMap[denomination];
      if (d != null) {
        d--;
        if (d != 0) {
          billMap[denomination] = d;
        } else {
          billMap.remove(denomination);
          denomenationSortedList.remove(denomination);
        }
      }
    }

    if (issueSum > 0) { return []; }

    List<String> listForReturn = [];

    for(var i = 0; i < denominationForReturn.length; i++) {
      var denomination = denominationForReturn[i];
      var amount = mapDenominationAmount[denominationForReturn[i]];
      if (amount != null) {
        var r = amount;
        listForReturn.add('${denomination.truncate()} X ${r}');
      }
    }

    for (var item in bills) {
      if (!denomenationSortedList.contains(item.denomination))  {
        bills.remove(item);
      } else {
        var amount = billMap[item.denomination];
        if (amount != null) {item.amount = amount; }
      }
    }

    return listForReturn;
  }

  int search(List<double> list, double sum, int end) {
    if (sum >= list[end]) {
      return end;
    } else {
      if (end == 0) {
        return -1;
      } else {
        return search(list, sum, end - 1);
      }
    }
  }

  int amountOfDenominations() {
    return bills.length;
  }
}