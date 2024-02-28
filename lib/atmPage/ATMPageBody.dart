import 'package:atm/ATMBloc.dart';
import 'package:flutter/material.dart';
import 'package:atm/atmPage/mainpagecolumns/atmbillslist/atmbillslist.dart';
import 'package:atm/atmPage/mainpagecolumns/ATMIssue/atmissue.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'mainpagecolumns/bottom.dart';
import 'package:atm/atmPage/mainpagecolumns/widgetFactory.dart';

class Body extends StatelessWidget {
  const Body({super.key, required BuildContext context});
  @override
  Widget build(BuildContext context) {
    ATMBalanceBloc bloc = BlocProvider.of(context);
    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      child: buildMainBackgroundContainer(context, bloc)
    );
  }
}

Widget buildMainBackgroundContainer(BuildContext context, ATMBalanceBloc bloc) {
  return Container(
      color: const Color.fromRGBO(56, 39, 180, 0.06),
      child: atmCustomScrollView(context, bloc)
  );
}



Widget atmCustomScrollView(BuildContext context, ATMBalanceBloc bloc) {

  return CustomScrollView(
    physics: const ClampingScrollPhysics(),
    slivers: [
      sliverList(buildATMIssue(context), context),
      sliverList(SizedBox(height: 10), context),
      sliverList(billIssuedWidget(), context),
      sliverList(SizedBox(height: 10), context),
      sliverList(billBalanceWidget(), context),
      sliverList(SizedBox(height: 10), context),
      SliverFillRemaining(
        hasScrollBody: false,
        child: bottom(),
      )
    ],
  );
}

SliverList sliverList(Widget widget, BuildContext context) {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return Container(
              child: widget
          );
        },
        childCount: 1
    ),
  );
}