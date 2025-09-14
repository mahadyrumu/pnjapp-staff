import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jetdispatch/views/reservations/includes/close_button.dart';
import 'package:jetdispatch/views/reservations/includes/save_button.dart';

class DurationInputForm extends StatelessWidget {
  const DurationInputForm({super.key});

  @override
  Widget build(context) //__
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Drop Off Date'),
        const Gap(5),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.95,
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(15, 5, 0, 0),
              filled: true,
              fillColor: Colors.grey[200],
              hintText: 'Apr 1,2024 10:30:00 PM',
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                gapPadding: 3.0,
              ),
            ),
          ),
        ),
        const Gap(5),
        const Text('Pickup Date'),
        const Gap(5),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.95,
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(15, 5, 0, 0),
              filled: true,
              fillColor: Colors.grey[100],
              hintText: 'Apr 1,2024 10:30:00 PM',
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                gapPadding: 3.0,
              ),
            ),
          ),
        ),
        const Gap(5),
        const Text('Duration'),
        const Gap(5),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.95,
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(15, 5, 0, 0),
              filled: true,
              fillColor: Colors.grey[100],
              hintText: '3.5',
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                gapPadding: 3.0,
              ),
            ),
          ),
        ),
        const Gap(10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [SaveButton(), CloseButtonCustom()],
        ),
      ],
    );
  }
}
