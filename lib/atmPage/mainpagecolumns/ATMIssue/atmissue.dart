import 'package:atm/ATMBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildATMIssue(BuildContext context) {
  return Container(
    height: 266,
    width: double.infinity,
    color: Colors.white,
    child: atmIssueColumn(context)
  );
}

Widget atmIssueColumn(BuildContext context) {
  return Column(
    children: [
      SizedBox(
        height: 180,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
            children: [
              issueBackground(),
              SizedBox(
                height: 68,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      enterSumTitleText(context),
                      sumTextField(context)
                    ]
                ),
              ),
            ]
        ),
      ),
      issuanceButton(context),
      //const SizedBox(height: 26)
    ],
  );
}

Widget issueBackground() {
  return SizedBox(
      height: double.infinity,
      width: double.infinity,
        child: SvgPicture.asset('assets/Background.svg', fit: BoxFit.fill,)
  );
}

Widget enterSumTitleText(BuildContext context) {
  return const Text('Введите сумму',
    textAlign: TextAlign.center,
    style: TextStyle(
      height: 1.2,
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.w400,
      fontFamily: 'SF-Pro',
    ),
  );
}

Widget suffixForSumTextField(bool state) {
  return state == true
    ? const Text('руб', style: TextStyle(color: Colors.white))
    : const Text('');
}

Widget sumTextField(BuildContext context) {
  return SizedBox(
    width: 200,
    child: BlocBuilder<ATMIssueTextFieldBloc, bool>(
      builder: (context, suffixState) {
        return  TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (value) {
            context.read<ATMIssueTextFieldBloc>().add(TextEdited(value));
          },
          cursorWidth: 0,
          decoration: InputDecoration(
              suffix: suffixForSumTextField(suffixState),
              contentPadding: EdgeInsets.all(0),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.4)),
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.4))
              )
          ),
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.2,
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w500,
            fontFamily: 'SF-Pro',
          ),
        );
      }
    )
    /*
    TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      onChanged: (value) {
        context.read<ATMIssueBloc>().add(TextEdited(value));
      },
      cursorWidth: 0,
      decoration: const InputDecoration(
        suffix: Text('руб', style: TextStyle(color: Colors.white)),
        contentPadding: EdgeInsets.all(0),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.4)),
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.4))
          )
      ),
      textAlign: TextAlign.center,
      style: TextStyle(
        height: 1.2,
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w500,
        fontFamily: 'SF-Pro',
      ),
    ),
  */
  );
}

Widget issuanceButton(BuildContext context) {
  return SizedBox(
      height: 60,
      width: 200,
      child: TextButton(
        onPressed: () {
          context.read<ATMIssueBloc>().add(IssueButtonPressed());
          context.read<ATMBalanceBloc>().add(IssueButtonPressed());
        },
        style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromRGBO(230, 30, 173, 1)
        ),
        child: const Text('Выдать сумму'),
      )
  );
}