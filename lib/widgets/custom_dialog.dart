import 'package:flutter/material.dart';
import 'package:mr_samy_elmalah/widgets/small_widgets.dart';

Future<void> displayTextInputDialog(
    {required BuildContext context,
    required final TextEditingController controller,
    required final void Function() btnOkOnPress,
    required final bool isLoading}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'ادخل الكود ',
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ge_ss',
                ),
          ),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            //obscureText: passwordVisible,
            enableSuggestions: false,

            cursorColor: const Color.fromARGB(255, 28, 113, 194),
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontFamily: 'roboto'),
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 28, 113, 194),
                  )),
              floatingLabelAlignment: FloatingLabelAlignment.start,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              labelText: 'الكود',
              labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey,
                    textBaseline: TextBaseline.alphabetic,
                  ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
                onPressed: btnOkOnPress,
                child: isLoading
                    ? SizedBox(
                        width: 30,
                        height: 30,
                        child: LottieLoader(),
                      )
                    : Text('OK')),
          ],
        );
      });
    },
  );
}
