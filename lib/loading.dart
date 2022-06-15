import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderDialog {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    var wid = MediaQuery.of(context).size.width / 2;
    var high = MediaQuery.of(context).size.height * 0.10;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(left: 130, right: 130),
          child: Dialog(
            key: key,
            backgroundColor: Colors.white,
            child: Container(
              width: wid * 1.6,
              height: high,
              child: Column(children: [
                SizedBox(height: 20),
                SpinKitDoubleBounce(color: Colors.amber, size: 30.0),
                SizedBox(height: 5),
                Text("Loding...."),
                SizedBox(height: 10),
              ]),
            ),
          ),
        );
      },
    );
  }
}
