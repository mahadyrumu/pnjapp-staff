import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jetdispatch/services/api_service.dart';
import 'package:jetdispatch/services/supabase_service.dart';
import 'package:jetdispatch/uri/api_urls_for_reservations.dart';
import 'package:jetdispatch/services/data_model.dart';
import 'package:jetdispatch/views/reservations/reservation_details.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReservationHistory extends StatefulWidget {
  Future<List<dynamic>> futureReservation =
      fetchReservations(ApiUrlsReservations.reservationUrls[0]);

  final Future<void> Function() refreshDataReservation;
  ReservationHistory(
      {required this.futureReservation,
      required this.refreshDataReservation,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReservationHistoryState();
}

class _ReservationHistoryState extends State<ReservationHistory> {
  final TextEditingController _searchController = TextEditingController();
  late RealtimeChannel _channel;

  void updateData() {
    Future<List<dynamic>> futureReservation =
        fetchReservations(ApiUrlsReservations.reservationUrls[0]);
    setState(() {
      widget.futureReservation = futureReservation;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _channel = SupabaseService().liveUpdate([
        'LOT_1_RESERVATION_CREATED',
        'LOT_1_RESERVATION_UPDATED',
        'LOT_2_RESERVATION_CREATED',
        'LOT_2_RESERVATION_CREATED'
      ], updateData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFeeedf2),
      body: RefreshIndicator(
        onRefresh: widget.refreshDataReservation,
        child: Column(
          children: [
            SizedBox(
              height: 90,
              child: FutureBuilder<List<dynamic>>(
                future: widget.futureReservation,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    List<dynamic> data = snapshot.data!;
                    List<LiveReservationDataModel> reservations = data
                        .map((e) => LiveReservationDataModel.fromJson(e))
                        .toList();

                    DateTime lastRefreshTime = DateTime.now();
                    int hour12 = lastRefreshTime.hour > 12
                        ? lastRefreshTime.hour - 12
                        : lastRefreshTime.hour;
                    hour12 = hour12 == 00 ? 12 : hour12;

                    return Container(
                      color: const Color(0xFFeeedf2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                            //padding: const EdgeInsets.all(0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                //'Last Refresh:'
                                'Last Refresh: $hour12:${lastRefreshTime.minute} ${lastRefreshTime.hour >= 12 ? 'pm' : 'am'}',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFF4F6FD),
                              ),
                              child: TextField(
                                enabled: true,
                                controller: _searchController,
                                onChanged: (_) => setState(() {}),

                                //obscureText: true,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.amber,
                                    size: 25.0,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: const Color(0x80F9F9F9),
                                  labelText: 'Plate No',
                                  labelStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: widget.futureReservation,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    List<dynamic> data = snapshot.data!;
                    List<LiveReservationDataModel> reservations = data
                        .map((e) => LiveReservationDataModel.fromJson(e))
                        .toList();

                    // Filter reservations based on claimId
                    String claimId = _searchController.text.trim();
                    if (claimId.isNotEmpty) {
                      reservations = reservations
                          .where((reservation) => reservation.plate
                              .toLowerCase()
                              .contains(claimId.toLowerCase()))
                          .toList();
                    }

                    return ListView.builder(
                      itemCount: reservations.length,
                      itemBuilder: (context, index) {
                        return item(context, reservations[index]);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    SupabaseService().removeSupabaseChannel(_channel);
    super.dispose();
  }
}

Widget item(BuildContext context, LiveReservationDataModel reservation) {
  Color shapeColor = Colors.red;
  String paymentStatus = 'Non paid';
  if (reservation.paymentType.trim().toUpperCase() == "NONPAID") {
    shapeColor = Colors.red;
    paymentStatus = 'Non paid';
  } else if (reservation.paymentType.trim().toUpperCase() == "STRIPE") {
    shapeColor = Colors.green;
    paymentStatus = 'Paid';
  }

  return GestureDetector(
    onTap: () {
      // Navigate to SingleReservationDetails page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SingleReservationDetails(),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        child: Column(
          children: [
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.grey.shade300),
                    padding: const EdgeInsets.all(9),
                    height: 140,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          //'12345',
                          '${reservation.rsvnId}',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 2.5,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        Text(
                          //'PNJ',
                          reservation.sourceRsvn,
                          style: GoogleFonts.roboto(
                            letterSpacing: 2.5,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Text(
                          //'AEV7623',
                          reservation.plate,
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Gap(5),
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    //'Mar 11th | 6:30AM',
                                    reservation.checkInDateTime,
                                    style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(
                                        letterSpacing: 1.0,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  const Gap(8),
                                  Text(
                                    //'Mar 11th | 6:30AM',
                                    reservation.checkOutDateTime,
                                    style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(
                                        letterSpacing: 1.0,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  const Gap(10),
                                  Text(
                                    //'Chad Bender',
                                    '${reservation.firstName} ${reservation.lastName}',
                                    style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 200,
                          padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'V',
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    letterSpacing: 1.0,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              Text(
                                'E',
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    letterSpacing: 1.0,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: shapeColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const Gap(10),
                                  Text(
                                    paymentStatus,
                                    style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    ),
  );
}


// Filter reservations based on search query
//                     List<LiveReservationDataModel> filteredReservations =
//                         searchQuery.isEmpty
//                             ? reservations
//                             : reservations.where((reservation) {
//                                 return reservation.firstName
//                                     .toLowerCase()
//                                     .contains(searchQuery.toLowerCase());
//                               }).toList();

//                     return ListView.builder(
//                       itemCount: filteredReservations.length,
//                       itemBuilder: (context, index) {
//                         return item(context, filteredReservations[index]);
//                       },
//                     );

















// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:jetdispatch/services/api_service.dart';
// import 'package:jetdispatch/uri/api_urls_for_reservations.dart';
// import 'package:jetdispatch/services/data_model.dart';
// import 'package:jetdispatch/views/reservations/reservation_details.dart';

// class ReservationHistory extends StatefulWidget {
//   Future<List<dynamic>> futureReservation =
//       fetchReservations(ApiUrlsReservations.reservationUrls[0]);

//   final Future<void> Function() refreshDataReservation;
//   ReservationHistory(
//       {required this.futureReservation,
//       required this.refreshDataReservation,
//       Key? key})
//       : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _ReservationHistoryState();
// }

// class _ReservationHistoryState extends State<ReservationHistory> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFeeedf2),
//       body: RefreshIndicator(
//         onRefresh: widget.refreshDataReservation,
//         child: Column(
//           children: [
//             SizedBox(
//               height: 90,
//               child: FutureBuilder<List<dynamic>>(
//                 future: widget.futureReservation,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   } else if (snapshot.hasError) {
//                     return Center(
//                       child: Text('${snapshot.error}'),
//                     );
//                   } else if (snapshot.hasData) {
//                     List<dynamic> data = snapshot.data!;
//                     List<LiveReservationDataModel> reservations = data
//                         .map((e) => LiveReservationDataModel.fromJson(e))
//                         .toList();

//                     DateTime lastRefreshTime = DateTime.now();
//                     int hour12 = lastRefreshTime.hour > 12
//                         ? lastRefreshTime.hour - 12
//                         : lastRefreshTime.hour;
//                     hour12 = hour12 == 00 ? 12 : hour12;

//                     return Container(
//                       color: const Color(0xFFeeedf2),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
//                             //padding: const EdgeInsets.all(0),
//                             child: Align(
//                               alignment: Alignment.topLeft,
//                               child: Text(
//                                 //'Last Refresh:'
//                                 'Last Refresh: $hour12:${lastRefreshTime.minute} ${lastRefreshTime.hour >= 12 ? 'pm' : 'am'}',
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
//                             child: Container(
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: const Color(0xFFF4F6FD),
//                               ),
//                               child: TextField(
//                                 enabled: true,
//                                 //obscureText: true,
//                                 cursorColor: Colors.black,
//                                 decoration: InputDecoration(
//                                   prefixIcon: const Icon(
//                                     Icons.search,
//                                     color: Colors.amber,
//                                     size: 25.0,
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8.0),
//                                   ),
//                                   filled: true,
//                                   fillColor: const Color(0x80F9F9F9),
//                                   labelText: 'Plate No',
//                                   labelStyle: const TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w300,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   }

//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Expanded(
//               child: FutureBuilder<List<dynamic>>(
//                 future: widget.futureReservation,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   } else if (snapshot.hasData) {
//                     List<dynamic> data = snapshot.data!;
//                     List<LiveReservationDataModel> reservations = data
//                         .map((e) => LiveReservationDataModel.fromJson(e))
//                         .toList();

//                     return ListView.builder(
//                       itemCount: reservations.length,
//                       itemBuilder: (context, index) {
//                         return item(context, reservations[index]);
//                       },
//                     );
//                   } else if (snapshot.hasError) {
//                     return Center(
//                       child: Text('${snapshot.error}'),
//                     );
//                   }
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget item(BuildContext context, LiveReservationDataModel reservation) {
//   Color shapeColor = Colors.red;
//   String paymentStatus = 'Non paid';
//   if (reservation.paymentType.trim().toUpperCase() == "NONPAID") {
//     shapeColor = Colors.red;
//     paymentStatus = 'Non paid';
//   } else if (reservation.paymentType.trim().toUpperCase() == "STRIPE") {
//     shapeColor = Colors.green;
//     paymentStatus = 'Paid';
//   }

//   return GestureDetector(
//     onTap: () {
//       // Navigate to SingleReservationDetails page
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => SingleReservationDetails(),
//         ),
//       );
//     },
//     child: Padding(
//       padding: EdgeInsets.symmetric(horizontal: 10),
//       child: Material(
//         child: Column(
//           children: [
//             Card(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(color: Colors.grey.shade300),
//                     padding: const EdgeInsets.all(9),
//                     height: 140,
//                     width: 100,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           //'12345',
//                           '${reservation.rsvnId}',
//                           style: GoogleFonts.roboto(
//                             textStyle: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w500,
//                                 letterSpacing: 2.5,
//                                 decoration: TextDecoration.underline),
//                           ),
//                         ),
//                         Text(
//                           //'PNJ',
//                           '${reservation.sourceRsvn}',
//                           style: GoogleFonts.roboto(
//                             letterSpacing: 2.5,
//                             textStyle: const TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                         Text(
//                           //'AEV7623',
//                           '${reservation.plate}',
//                           style: GoogleFonts.roboto(
//                             textStyle: const TextStyle(fontSize: 15),
//                           ),
//                         ),
//                       ],
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
//                                     //'Mar 11th | 6:30AM',
//                                     '${reservation.checkInDateTime}',
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
//                                     //'Mar 11th | 6:30AM',
//                                     '${reservation.checkOutDateTime}',
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
//                                     //'Chad Bender',
//                                     '${reservation.firstName} ${reservation.lastName}',
//                                     style: GoogleFonts.roboto(
//                                       textStyle: const TextStyle(
//                                         fontSize: 16,
//                                         letterSpacing: 1.5,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
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
//                                     decoration: BoxDecoration(
//                                       color: shapeColor,
//                                       shape: BoxShape.circle,
//                                     ),
//                                   ),
//                                   const Gap(10),
//                                   Text(
//                                     paymentStatus,
//                                     style: GoogleFonts.roboto(
//                                       textStyle: const TextStyle(fontSize: 15),
//                                     ),
//                                   ),
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
//           ],
//         ),
//       ),
//     ),
//   );
// }


// Filter reservations based on search query
//                     List<LiveReservationDataModel> filteredReservations =
//                         searchQuery.isEmpty
//                             ? reservations
//                             : reservations.where((reservation) {
//                                 return reservation.firstName
//                                     .toLowerCase()
//                                     .contains(searchQuery.toLowerCase());
//                               }).toList();

//                     return ListView.builder(
//                       itemCount: filteredReservations.length,
//                       itemBuilder: (context, index) {
//                         return item(context, filteredReservations[index]);
//                       },
//                     );