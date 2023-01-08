import 'dart:async';

import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:willmod3/configs/constant.dart';
import 'package:willmod3/configs/myapp.dart';
import 'package:willmod3/configs/mydio.dart';
import 'package:willmod3/custom_widgets/numeric_formatter.dart';
import 'package:willmod3/globals/globalwidget.dart';
// import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class WiljosInputDialog {
  static Future<dynamic?> showInputDialog(BuildContext context, double width,
      double height, String title, String prompt, dynamic initialValue,
      {isNumericInput = false, isObscure = false, double fontSize = 18}) async {
    late TextEditingController textEditingController;

    // if (isNumericInput) {
    //   double newInitial = 0;
    //   if (initialValue is String) {
    //     newInitial = initialValue.toDouble();
    //   } else {
    //     newInitial = initialValue;
    //   }
    //   // textEditingController = MoneyMaskedTextController(
    //   //     decimalSeparator: ",",
    //   //     thousandSeparator: ".",
    //   //     initialValue: newInitial,
    //   //     precision: 1);
    // } else {

    textEditingController = TextEditingController();
    textEditingController.text = initialValue;

    if (isNumericInput) {
      bool isNumeric = false;
      double doubleInitialValue = 0;
      try {
        doubleInitialValue = double.parse(initialValue);
        isNumeric = true;
      } catch (_) {}
      if (isNumeric) {
        String newInitialValue = MyApp.NUMBER_FORMAT.format(doubleInitialValue);
        textEditingController.text = newInitialValue;
      }
    }

    // }

    // var maskFormatter = new MaskTextInputFormatter(
    //     mask: '+# (###) ###-##-##',
    //     filter: {"#": RegExp(r'[0-9]')},
    //     type: MaskAutoCompletionType.lazy);

    WiljosConstant constant = Get.put(WiljosConstant());

    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 10,
            backgroundColor: Colors.white,
            child: SizedBox(
              width: width * 0.9,
              height: height,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: constant.colorTextLight,
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 35),
                    child: Text(
                      prompt,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: constant.colorTextLight,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: width * 0.7,
                    child: TextFormField(
                      inputFormatters:
                          isNumericInput ? [ThousandsFormatter()] : null,
                      // inputFormatters: [maskFormatter],
                      textAlign:
                          isNumericInput ? TextAlign.center : TextAlign.start,
                      controller: textEditingController,
                      keyboardType: isNumericInput
                          ? TextInputType.number
                          : TextInputType.name,
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      obscureText: isObscure,
                      style: TextStyle(
                          fontSize: fontSize,
                          color: constant.colorText,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5),
                    ),
                  ),
                  45.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context, null);
                        },
                        splashColor: Colors.black12,
                        child: SizedBox(
                          width: 110,
                          height: 40,
                          child: Center(
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: constant.colorTextLight,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      15.width,
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: constant.colorPrimary),
                        child: const SizedBox(
                          width: 70,
                          height: 40,
                          child: Center(
                            child: Text(
                              "Okay",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context, textEditingController.text);
                        },
                      ),
                      30.width,
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
