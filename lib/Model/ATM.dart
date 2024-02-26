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

    List<Bill> forReturn = [];
    List<Bill> moneyList = [];
    for (var element in bills) {
      moneyList.add(Bill(element.denomination, element.amount));
    }

    moneyList.sort((a,b) => a.denomination.compareTo(b.denomination));

    var issueSum = sum;

    while(issueSum > 0) {
      var billIndex = search(moneyList, issueSum, moneyList.length - 1);
      if (billIndex < 0) {
        return [];
      }
      var denomination = moneyList[billIndex].denomination;
      issueSum = issueSum - denomination;
      bool isH = false;
      var index = -1;
      for (var i=0; i<forReturn.length; i++) {
        if (forReturn[i].denomination == denomination) {
          isH = true;
          index = i;
        }
      }

      if(!isH) {
        forReturn.add(Bill(denomination,1));
      } else {
        forReturn[index].amount++;
      }

      moneyList.firstWhere((element) => element.denomination == denomination)
          .amount--;
      bills.firstWhere((element) => element.denomination == denomination)
          .amount--;
      if (moneyList.firstWhere((element) => element.denomination == denomination)
          .amount == 0) {
        var a = moneyList.firstWhere((element) =>
        element.denomination == denomination);
        moneyList.remove(a);
        var b = bills.firstWhere((element) =>
        element.denomination == denomination);
        bills.remove(b);
      }
    }

    if (issueSum > 0) { return []; }

    return forReturn.map((e) => '${e.denomination.truncate()} X ${ e.amount.truncate() }').toList();
  }

  int search(List<Bill> list, double sum, int end) {
    if (sum >= list[end].denomination) {
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