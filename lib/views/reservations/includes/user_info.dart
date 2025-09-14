import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jetdispatch/views/reservations/includes/close_button.dart';
import 'package:jetdispatch/views/reservations/includes/save_button.dart';

class UserInputForm extends StatelessWidget {
  const UserInputForm({super.key});

  @override
  Widget build(context) //__
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Last Name'),
        const Gap(5),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.95,
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
              filled: true,
              fillColor: Colors.grey[200],
              hintText: 'Kumar',
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
        const Text('First Name'),
        const Gap(5),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.95,
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
              filled: true,
              fillColor: Colors.grey[100],
              hintText: 'Anurag',
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
        const Text('Phone Number'),
        const Gap(5),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.95,
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
              filled: true,
              fillColor: Colors.grey[100],
              hintText: '12345',
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
        const Text('Email-ID'),
        const Gap(5),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.95,
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
              filled: true,
              fillColor: Colors.grey[100],
              hintText: 'kumar@gmail.com',
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
