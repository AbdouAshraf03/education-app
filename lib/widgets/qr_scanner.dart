import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mr_samy_elmalah/widgets/small_widgets.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

Future<void> displayTextInputDialogForScanner(
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
            "ادخل الكود",
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ge_ss',
                ),
          ),
          content: TextField(
            enabled: false,
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
              child: Text('Scan'),
              onPressed: () async {
                final scannedResult = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => QRViewExample(),
                  ),
                );
                if (scannedResult != null) {
                  setState(() {
                    controller.text = scannedResult;
                  });
                }
              },
            ),
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

class QRViewExample extends StatefulWidget {
  const QRViewExample({super.key});

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Code: ${result!.code}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'cairo',
                            )),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context, result!.code);
                          },
                          child: Text(
                            'Use this code',
                          ),
                        ),
                      ],
                    )
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }
}
