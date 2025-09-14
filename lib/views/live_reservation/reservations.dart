import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jetdispatch/services/api_service.dart';
import 'package:jetdispatch/services/supabase_service.dart';
import 'package:jetdispatch/uri/api_urls_for_live_reservation.dart';

import 'package:jetdispatch/services/data_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Reservation extends StatefulWidget {
  Future<List<dynamic>> futureReservation =
      fetchReservations(ApiUrlsLiveReservations.liveReservationUrls[0]);

  final Future<void> Function() refreshData;
  Reservation(
      {required this.futureReservation, required this.refreshData, Key? key})
      : super(key: key);

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  late RealtimeChannel _channel;

  late List<String> users = [
    "PNJ",
    "APR",
    "WAY",
    "CAP",
    "AAP",
    "GAP",
    "TPR",
    "L",
    "TOTAL",
  ];

  void updateData() {
    Future<List<dynamic>> futureReservation =
        fetchReservations(ApiUrlsLiveReservations.liveReservationUrls[0]);
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
      body: RefreshIndicator(
        onRefresh: widget.refreshData,
        child: Column(
          children: [
            SizedBox(
              height: 80,
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

                    Map<String, int> userCounts = {};
                    for (var reservation in reservations) {
                      userCounts[reservation.sourceRsvn] =
                          (userCounts[reservation.sourceRsvn] ?? 0) + 1;
                    }
                    //calculate total count
                    int totalCount = 0;
                    for (var count in userCounts.values) {
                      totalCount += count;
                    }
                    userCounts["TOTAL"] = totalCount;

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        int count = userCounts[users[index]] ?? 0;
                        return Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(8),
                          color: Colors.orange.shade200,
                          width: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                users[index],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '$count',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
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

                    return ListView.builder(
                      itemCount: reservations.length,
                      itemBuilder: (context, index) {
                        return item(reservations[index]);
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

Widget item(LiveReservationDataModel reservation) {
  double averageRate = reservation.totalPrice / reservation.stayInDays;

  Color shapeColor = Colors.red; // Default color
  // Determine shape color based on paymentType
  if (reservation.paymentType.trim().toUpperCase() == "NONPAID") {
    shapeColor = Colors.red;
  } else if (reservation.paymentType.trim().toUpperCase() == "STRIPE") {
    shapeColor = Colors.green;
  }

  return Material(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment,
                    children: [
                      Text(
                        '${reservation.rsvnId}',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              //letterSpacing: 2.5,
                              fontSize: 23,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Text(
                        reservation.returnAirLine,
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              //letterSpacing: 1.0,
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${reservation.firstName} ${reservation.lastName}',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              //letterSpacing: 1.5,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Text(
                        reservation.checkInDateTime,
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            //letterSpacing: 2.5,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'VEHICLE',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            //letterSpacing: 2.0,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Text(
                        'VISITS',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            //letterSpacing: 2.0,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${reservation.make} ${reservation.model} | ${reservation.plate}',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            //letterSpacing: 1.0,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Text(
                        '${reservation.visitTimes}',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              //letterSpacing: 1.0,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment,
                    children: [
                      Text('DO',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              //letterSpacing: 1.0,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          )),
                      Text(
                        "PU",
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            //letterSpacing: 1.0,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment,
                    children: [
                      Text(
                        reservation.pickupDateTime,
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            //letterSpacing: 1.0,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Text(
                        reservation.checkOutDateTime,
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            //letterSpacing: 1.0,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Average rate ',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                //letterSpacing: 1.0,
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          //${reservation.totalPrice}\$

                          Text('${averageRate.toStringAsFixed(2)}\$',
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    //letterSpacing: 1.5,
                                    fontSize: 15),
                              )),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('PAYMENT',
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  //letterSpacing: 1.0,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              )),
                          Row(
                            children: [
                              Text(
                                '${reservation.totalPrice}',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                    color: shapeColor, shape: BoxShape.circle),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
