import 'package:flutter/material.dart';

class CustomAlertDialog {
  final BuildContext context;
  final String message;

  CustomAlertDialog({this.context, this.message});

  show() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                message,
                style: TextStyle(
                  color: Theme.of(context).textTheme.title.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
