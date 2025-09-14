import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jetdispatch/views/reservations/includes/close_button.dart';
import 'package:jetdispatch/views/reservations/includes/save_button.dart';

class VehicleInputForm extends StatelessWidget {
  const VehicleInputForm({super.key});

  @override
  Widget build(context) //__
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Make'),
        const Gap(5),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.95,
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
              filled: true,
              fillColor: Colors.grey[200],
              hintText: '2023',
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
        const Text('Model'),
        const Gap(5),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.95,
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
              filled: true,
              fillColor: Colors.grey[100],
              hintText: 'CRV HYBRID',
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
        const Text('Plate'),
        const Gap(5),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.95,
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
              filled: true,
              fillColor: Colors.grey[100],
              hintText: 'CHK823',
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
        const Text('Size'),
        const Gap(5),
        SizedBox(
          height: 35,
          width: 360,
          child: TextField(
            // enabled: true,
            // obscureText: true,
            // cursorColor: Colors.black,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
              hintText: 'Standard',
              suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              filled: true,
              fillColor: const Color(0x80F9F9F9),
              labelStyle:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
            ),
          ),
        ),
        const Gap(5),
        const Text('License State'),
        const Gap(5),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.95,
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
              filled: true,
              fillColor: Colors.grey[100],
              hintText: 'WA',
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
