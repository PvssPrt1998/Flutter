import 'package:atm/atmPage/mainpagecolumns/widgetFactory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../ATMBloc.dart';

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
      //bloc: bloc,
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

Widget atmBillList(List<String> stateString, String descriptionTitle) {
  return Container(
    height: 128,
    width: double.infinity,
    color: Colors.white,
    child: buildATMBillList(stateString, descriptionTitle),
  );
}

Widget buildATMBillList(List<String> stateString, String descriptionTitle) {
  return Padding(
    padding: EdgeInsets.fromLTRB(21, 14, 21, 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        billsTableDescriptionTitle(descriptionTitle), //'Баланс банкомата'
        billsTable(stateString)
      ],
    ),
  );
}

Widget billsTableDescriptionTitle(String title) {
  return Text(title,
      style: TextStyle(
        height: 1.2,
        color: Color.fromRGBO(163, 162, 172, 1), //rgba(163, 162, 172, 1)
        fontSize: 13,
        fontWeight: FontWeight.w400,
        fontFamily: 'SF-Pro',
      )
  );
}

Widget billsTable(List<String> stateString) {
  List<TableRow> rowList = [];

  List<List<String>> a = [];
  for (var i = 0; i < stateString.length; i++) {
    List<String> item = [];
    if(i%2==0) {
      a.add(item);
    }
    a[i~/2].add(stateString[i]);
  }

  if (stateString.length%2 != 0) {
    a[stateString.length~/2].add('');
  }

  for (var element in a) {
    rowList.add(buildRow(element));
  }

  return Table(
      children: rowList
  );
}

TableRow buildRow(List<String> cells) => TableRow(
  children: cells.map((cell) {
    final style = TextStyle(
      height: 1.2,
      color: Color.fromRGBO(56, 39, 180, 1), //rgba(56, 39, 180, 1)
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: 'SF-Pro',
    );

    return Padding(
      padding: EdgeInsets.only(top: 6),
      child: Text(cell, style: style),
    );
  }).toList()
);