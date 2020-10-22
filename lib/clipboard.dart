import 'package:flutter/material.dart';
//import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';

class MyApp2 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter clipboard manager example app'),
        ),
        body: Builder(
          builder: (context) {
            return Center(
              child: Column(
                children: <Widget>[
                  Text('Your coupon is: Clipboard content!'),
                  RaisedButton(
                    child: Text('Copy to Clipboard'),
                    onPressed: () {
                      final snackBar = SnackBar(
                        content: Text('Copied to Clipboard'),
                        action: SnackBarAction(
                          label: 'Okey',
                          onPressed: () {},
                        ),
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                      // FlutterClipboardManager.copyToClipBoard(
                      //         "Clipboard content!")
                      //     .then((result) {
                      //   final snackBar = SnackBar(
                      //     content: Text('Copied to Clipboard'),
                      //     action: SnackBarAction(
                      //       label: 'Okey',
                      //       onPressed: () {},
                      //     ),
                      //   );
                      //   Scaffold.of(context).showSnackBar(snackBar);
                      // });
                    },
                  ),
                  RaisedButton(
                    child: Text('Copy from Clipboard'),
                    onPressed: () {
                      final snackBar = SnackBar(
                        content: Text('Clipboard data: Clipboard content!'),
                        action: SnackBarAction(
                          label: 'Okey',
                          onPressed: () {},
                        ),
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                      // FlutterClipboardManager.copyFromClipBoard()
                      //     .then((result) {
                      //   final snackBar = SnackBar(
                      //     content: Text('Clipboard data: $result'),
                      //     action: SnackBarAction(
                      //       label: 'Okey',
                      //       onPressed: () {},
                      //     ),
                      //   );
                      //   Scaffold.of(context).showSnackBar(snackBar);
                      // });
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
