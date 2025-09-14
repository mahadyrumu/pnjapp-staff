import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:jetdispatch/views/reservations/includes/duration_info.dart';
import 'package:jetdispatch/views/reservations/includes/parking_info.dart';
import 'package:jetdispatch/views/reservations/includes/user_info.dart';
import 'package:jetdispatch/views/reservations/includes/vehicle_info.dart';

class SingleReservationDetails extends StatelessWidget {
  //final List<LiveReservationDataModel> reservations;
  const SingleReservationDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.red[700],
        // titleTextStyle: TextStyle(color: Colors.white),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Reservation Details',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 19.5,
                  fontWeight: FontWeight.w400),
            ),
            Row(
              children: [
                Text(
                  'Print',
                  style: TextStyle(color: Colors.white),
                ),
                Gap(10),
                Icon(
                  Icons.print_rounded,
                  color: Colors.white,
                )
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(15),
                  Text(
                    'Claim ID',
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(fontSize: 16),
                        letterSpacing: 1.5),
                  ),
                  const Gap(12),
                  SizedBox(
                    height: 45,
                    width: 360,
                    child: TextFormField(
                      textAlign: TextAlign.justify,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: '12345',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            gapPadding: 4.0),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Accordion(
                  maxOpenSections: 1,
                  openAndCloseAnimation: false,

                  rightIcon: const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.black,
                  ),
                  // headerBorderColor: Colors.blueGrey,
                  // headerBorderColorOpened: Colors.transparent,
                  headerBorderRadius: 0.5,

                  headerBorderWidth: 1,
                  headerBackgroundColor: Colors.white70,
                  // headerBackgroundColorOpened: Colors.green,
                  contentBackgroundColor: Colors.grey[200],

                  // contentBorderColor: Colors.green,
                  contentBorderWidth: 0,
                  // contentHorizontalPadding: 10,
                  scaleWhenAnimating: true,

                  headerPadding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                  sectionClosingHapticFeedback: SectionHapticFeedback.light,
                  children: [
                    AccordionSection(
                      isOpen: false,
                      // leftIcon: const Icon(Icons.input, color: Colors.white),
                      header: const Text(
                        'User Info : Anurag Kumar',
                      ),

                      content: const UserInputForm(),
                    ),
                    AccordionSection(
                      isOpen: false,
                      header: const Text(
                        'Vehicle Info: TOY, venza',
                      ),
                      // contentHorizontalPadding: 40,
                      // contentVerticalPadding: 20,
                      content: const VehicleInputForm(),
                    ),
                    AccordionSection(
                      isOpen: false,
                      header: const Text(
                        'Parking Info: PNJ, 986435',
                      ),
                      // contentHorizontalPadding: 40,
                      // contentVerticalPadding: 20,
                      content: const ParkingInputForm(),
                    ),
                    AccordionSection(
                      isOpen: false,
                      header: const Text(
                        'Duration Info',
                      ),
                      // contentHorizontalPadding: 40,
                      // contentVerticalPadding: 20,
                      content: const DurationInputForm(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 130,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 170, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                          side: const BorderSide(color: Colors.red, width: 2),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                        child: Text('Pre-checkin'),
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          side: const BorderSide(color: Colors.red),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                        child: Text('Checkin'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
