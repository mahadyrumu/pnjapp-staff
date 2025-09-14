class ApiUrlsLiveReservations {
//for live reservation
  static const String liveReservationsForLot1 =
      'http://prodlot1.parknjetseatac.com:9000/reservations/today';
  static const String liveReservationsForLot2 =
      'http://prodlot2.parknjetseatac.com:9000/reservations/today';

  static List<String> liveReservationUrls = [
    liveReservationsForLot1,
    liveReservationsForLot2,
  ];
}



















// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:jetdispatch/views/reservations/reservation_details.dart';

// class ReservationHistory extends StatefulWidget {
//   const ReservationHistory({super.key});

//   @override
//   State<StatefulWidget> createState() => _ReservationHistoryState();
// }

// class _ReservationHistoryState extends State<ReservationHistory> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFeeedf2),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(8, 25, 8, 0),
//         child: ListView(
//           children: [
//             const Text('Last Refresh: 12:21 pm'),
//             const Gap(10),
//             Container(
//               height: 40,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: const Color(0xFFF4F6FD)),
//               child: TextField(
//                 enabled: true,
//                 obscureText: true,
//                 cursorColor: Colors.black,
//                 decoration: InputDecoration(
//                     prefixIcon: const Icon(
//                       Icons.search,
//                       color: Colors.amber,
//                       size: 25.0,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     filled: true,
//                     fillColor: const Color(0x80F9F9F9),
//                     labelText: 'Plate No',
//                     labelStyle: const TextStyle(
//                         fontSize: 15, fontWeight: FontWeight.w300)),
//               ),
//             ),
//             const Gap(10),
//             Card(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   GestureDetector(
//                     // onTap: () => const SingleReservationDetails(),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                                 const SingleReservationDetails()),
//                       );
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(color: Colors.grey.shade300),
//                       padding: const EdgeInsets.all(9),
//                       height: 140,
//                       width: 85,
//                       child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text('12345',
//                                 style: GoogleFonts.roboto(
//                                   textStyle: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500,
//                                       letterSpacing: 2.5,
//                                       decoration: TextDecoration.underline),
//                                 )),
//                             Text(
//                               'PNJ',
//                               style: GoogleFonts.roboto(
//                                   letterSpacing: 2.5,
//                                   textStyle: const TextStyle(
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 16)),
//                             ),
//                             Text(
//                               'AEV7623',
//                               style: GoogleFonts.roboto(
//                                   textStyle: const TextStyle(fontSize: 15)),
//                             ),
//                           ]),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const Gap(5),
//                         Container(
//                           padding: const EdgeInsets.all(5),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     'Mar 11th | 6:30AM',
//                                     style: GoogleFonts.roboto(
//                                       textStyle: const TextStyle(
//                                         letterSpacing: 1.0,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w300,
//                                       ),
//                                     ),
//                                   ),
//                                   const Gap(8),
//                                   Text(
//                                     'Mar 11th | 6:30AM',
//                                     style: GoogleFonts.roboto(
//                                       textStyle: const TextStyle(
//                                         letterSpacing: 1.0,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w300,
//                                       ),
//                                     ),
//                                   ),
//                                   const Gap(10),
//                                   Text(
//                                     'Chad Bender',
//                                     style: GoogleFonts.roboto(
//                                         textStyle: const TextStyle(
//                                             fontSize: 16,
//                                             letterSpacing: 1.5,
//                                             fontWeight: FontWeight.w500)),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           width: 200,
//                           padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 15),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'V',
//                                 style: GoogleFonts.roboto(
//                                   textStyle: const TextStyle(
//                                     letterSpacing: 1.0,
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w300,
//                                   ),
//                                 ),
//                               ),
//                               Text(
//                                 'E',
//                                 style: GoogleFonts.roboto(
//                                   textStyle: const TextStyle(
//                                     letterSpacing: 1.0,
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w300,
//                                   ),
//                                 ),
//                               ),
//                               Row(
//                                 children: [
//                                   Container(
//                                     margin:
//                                         const EdgeInsets.fromLTRB(5, 0, 0, 0),
//                                     height: 15,
//                                     width: 15,
//                                     decoration: const BoxDecoration(
//                                         color: Colors.red,
//                                         shape: BoxShape.circle),
//                                   ),
//                                   const Gap(10),
//                                   Text(
//                                     'Non paid',
//                                     style: GoogleFonts.roboto(
//                                         textStyle:
//                                             const TextStyle(fontSize: 15)),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Gap(10),
//             Card(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(color: Colors.grey.shade300),
//                     padding: const EdgeInsets.all(9),
//                     height: 140,
//                     width: 85,
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text('12345',
//                               style: GoogleFonts.roboto(
//                                 textStyle: const TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w500,
//                                     letterSpacing: 2.5,
//                                     decoration: TextDecoration.underline),
//                               )),
//                           Text(
//                             'PNJ',
//                             style: GoogleFonts.roboto(
//                                 letterSpacing: 2.5,
//                                 textStyle: const TextStyle(
//                                     fontWeight: FontWeight.w400, fontSize: 16)),
//                           ),
//                           Text(
//                             'AEV7623',
//                             style: GoogleFonts.roboto(
//                                 textStyle: const TextStyle(fontSize: 15)),
//                           ),
//                         ]),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const Gap(5),
//                         Container(
//                           padding: const EdgeInsets.all(5),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     'Mar 11th | 6:30AM',
//                                     style: GoogleFonts.roboto(
//                                       textStyle: const TextStyle(
//                                         letterSpacing: 1.0,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w300,
//                                       ),
//                                     ),
//                                   ),
//                                   const Gap(8),
//                                   Text(
//                                     'Mar 11th | 6:30AM',
//                                     style: GoogleFonts.roboto(
//                                       textStyle: const TextStyle(
//                                         letterSpacing: 1.0,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w300,
//                                       ),
//                                     ),
//                                   ),
//                                   const Gap(10),
//                                   Text(
//                                     'Chad Bender',
//                                     style: GoogleFonts.roboto(
//                                         textStyle: const TextStyle(
//                                             fontSize: 16,
//                                             letterSpacing: 1.5,
//                                             fontWeight: FontWeight.w500)),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           width: 200,
//                           padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 15),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'V',
//                                 style: GoogleFonts.roboto(
//                                   textStyle: const TextStyle(
//                                     letterSpacing: 1.0,
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w300,
//                                   ),
//                                 ),
//                               ),
//                               Text(
//                                 'E',
//                                 style: GoogleFonts.roboto(
//                                   textStyle: const TextStyle(
//                                     letterSpacing: 1.0,
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w300,
//                                   ),
//                                 ),
//                               ),
//                               Row(
//                                 children: [
//                                   Container(
//                                     margin:
//                                         const EdgeInsets.fromLTRB(5, 0, 0, 0),
//                                     height: 15,
//                                     width: 15,
//                                     decoration: const BoxDecoration(
//                                         color: Colors.green,
//                                         shape: BoxShape.circle),
//                                   ),
//                                   const Gap(10),
//                                   Text(
//                                     'paid',
//                                     style: GoogleFonts.roboto(
//                                         textStyle:
//                                             const TextStyle(fontSize: 15)),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Gap(10),
//             Card(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(color: Colors.grey.shade300),
//                     padding: const EdgeInsets.all(9),
//                     height: 140,
//                     width: 85,
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text('12345',
//                               style: GoogleFonts.roboto(
//                                 textStyle: const TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w500,
//                                     letterSpacing: 2.5,
//                                     decoration: TextDecoration.underline),
//                               )),
//                           Text(
//                             'PNJ',
//                             style: GoogleFonts.roboto(
//                                 letterSpacing: 2.5,
//                                 textStyle: const TextStyle(
//                                     fontWeight: FontWeight.w400, fontSize: 16)),
//                           ),
//                           Text(
//                             'AEV7623',
//                             style: GoogleFonts.roboto(
//                                 textStyle: const TextStyle(fontSize: 15)),
//                           ),
//                         ]),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const Gap(5),
//                         Container(
//                           padding: const EdgeInsets.all(5),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     'Mar 11th | 6:30AM',
//                                     style: GoogleFonts.roboto(
//                                       textStyle: const TextStyle(
//                                         letterSpacing: 1.0,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w300,
//                                       ),
//                                     ),
//                                   ),
//                                   const Gap(8),
//                                   Text(
//                                     'Mar 11th | 6:30AM',
//                                     style: GoogleFonts.roboto(
//                                       textStyle: const TextStyle(
//                                         letterSpacing: 1.0,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w300,
//                                       ),
//                                     ),
//                                   ),
//                                   const Gap(10),
//                                   Text(
//                                     'Chad Bender',
//                                     style: GoogleFonts.roboto(
//                                         textStyle: const TextStyle(
//                                             fontSize: 16,
//                                             letterSpacing: 1.5,
//                                             fontWeight: FontWeight.w500)),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           width: 200,
//                           padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 15),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'V',
//                                 style: GoogleFonts.roboto(
//                                   textStyle: const TextStyle(
//                                     letterSpacing: 1.0,
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w300,
//                                   ),
//                                 ),
//                               ),
//                               Text(
//                                 'E',
//                                 style: GoogleFonts.roboto(
//                                   textStyle: const TextStyle(
//                                     letterSpacing: 1.0,
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w300,
//                                   ),
//                                 ),
//                               ),
//                               Row(
//                                 children: [
//                                   Container(
//                                     margin:
//                                         const EdgeInsets.fromLTRB(5, 0, 0, 0),
//                                     height: 15,
//                                     width: 15,
//                                     decoration: const BoxDecoration(
//                                         color: Colors.green,
//                                         shape: BoxShape.circle),
//                                   ),
//                                   const Gap(10),
//                                   Text(
//                                     'paid',
//                                     style: GoogleFonts.roboto(
//                                         textStyle:
//                                             const TextStyle(fontSize: 15)),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Gap(10),
//             Card(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(color: Colors.grey.shade300),
//                     padding: const EdgeInsets.all(9),
//                     height: 140,
//                     width: 85,
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text('12345',
//                               style: GoogleFonts.roboto(
//                                 textStyle: const TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w500,
//                                     letterSpacing: 2.5,
//                                     decoration: TextDecoration.underline),
//                               )),
//                           Text(
//                             'PNJ',
//                             style: GoogleFonts.roboto(
//                                 letterSpacing: 2.5,
//                                 textStyle: const TextStyle(
//                                     fontWeight: FontWeight.w400, fontSize: 16)),
//                           ),
//                           Text(
//                             'AEV7623',
//                             style: GoogleFonts.roboto(
//                                 textStyle: const TextStyle(fontSize: 15)),
//                           ),
//                         ]),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const Gap(5),
//                         Container(
//                           padding: const EdgeInsets.all(5),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     'Mar 11th | 6:30AM',
//                                     style: GoogleFonts.roboto(
//                                       textStyle: const TextStyle(
//                                         letterSpacing: 1.0,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w300,
//                                       ),
//                                     ),
//                                   ),
//                                   const Gap(8),
//                                   Text(
//                                     'Mar 11th | 6:30AM',
//                                     style: GoogleFonts.roboto(
//                                       textStyle: const TextStyle(
//                                         letterSpacing: 1.0,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w300,
//                                       ),
//                                     ),
//                                   ),
//                                   const Gap(10),
//                                   Text(
//                                     'Chad Bender',
//                                     style: GoogleFonts.roboto(
//                                         textStyle: const TextStyle(
//                                             fontSize: 16,
//                                             letterSpacing: 1.5,
//                                             fontWeight: FontWeight.w500)),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           width: 200,
//                           padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 15),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'V',
//                                 style: GoogleFonts.roboto(
//                                   textStyle: const TextStyle(
//                                     letterSpacing: 1.0,
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w300,
//                                   ),
//                                 ),
//                               ),
//                               Text(
//                                 'E',
//                                 style: GoogleFonts.roboto(
//                                   textStyle: const TextStyle(
//                                     letterSpacing: 1.0,
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w300,
//                                   ),
//                                 ),
//                               ),
//                               Row(
//                                 children: [
//                                   Container(
//                                     margin:
//                                         const EdgeInsets.fromLTRB(5, 0, 0, 0),
//                                     height: 15,
//                                     width: 15,
//                                     decoration: const BoxDecoration(
//                                         color: Colors.red,
//                                         shape: BoxShape.circle),
//                                   ),
//                                   const Gap(10),
//                                   Text(
//                                     'paid',
//                                     style: GoogleFonts.roboto(
//                                         textStyle:
//                                             const TextStyle(fontSize: 15)),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
