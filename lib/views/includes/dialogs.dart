import 'package:flutter/material.dart';

enum DialogAction { yes, abort }

class Dialogs {
  static Future<DialogAction> yesAbortDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(title, textAlign: TextAlign.center),
          content: Text(body, textAlign: TextAlign.center),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.abort),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffdc6460)),
              // color: const Color(0xffdc6460),
              onPressed: () => Navigator.of(context).pop(DialogAction.yes),
              child: const Text(
                'Yes, delete it!',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}
