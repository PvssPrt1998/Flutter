import 'package:atm/ATMBloc.dart';
import 'package:flutter/material.dart';
import 'AppBar.dart';
import 'ATMPageBody.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:atm/Model/ATM.dart';

class ATMPage extends StatefulWidget {
  const ATMPage({super.key});
  @override
  State<ATMPage> createState() => _ATMPageState();
}

class _ATMPageState extends State<ATMPage> {
  ATM atm = ATM();

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => ATMIssueBloc(atm)
          ),
          BlocProvider(
              create: (_) => ATMBalanceBloc(atm)
          ),
          BlocProvider(
              create: (_) => ATMIssueTextFieldBloc(atm)
          )
        ],
        child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(),
        body: Body(context: context)
        ),
    );
  }
}
