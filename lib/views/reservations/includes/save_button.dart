import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          foregroundColor: Colors.green,
          textStyle: const TextStyle(
            fontSize: 15,
          ),
          side: const BorderSide(color: Colors.green),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
      onPressed: () {},
      child: const Padding(
        padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
        child: Text('Save'),
      ),
    );
  }
}
