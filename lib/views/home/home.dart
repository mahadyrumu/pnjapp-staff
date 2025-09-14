import 'package:flutter/material.dart';
import 'package:jetdispatch/services/api_service.dart';
import 'package:jetdispatch/services/dispatch_service.dart';
import 'package:jetdispatch/uri/api_urls.dart';
import 'package:jetdispatch/uri/api_urls_for_live_reservation.dart';
import 'package:jetdispatch/uri/api_urls_for_reservations.dart';
import 'package:jetdispatch/views/auth/sign_in.dart';
import 'package:jetdispatch/views/checkin/checkin.dart';
import 'package:jetdispatch/views/checkout/checkout.dart';
import 'package:jetdispatch/views/dispatchinfo/dispatch_info.dart';
import 'package:jetdispatch/views/dropoffs/dropoffs.dart';
import 'package:jetdispatch/views/live_reservation/reservations.dart';
import 'package:jetdispatch/views/pickups/pickups.dart';
import 'package:jetdispatch/views/home/dashboard.dart';
import 'package:jetdispatch/views/home/drawer_header.dart';
import 'package:jetdispatch/views/history/history.dart';
import 'package:jetdispatch/views/quick_move/quick_move.dart';
import 'package:jetdispatch/views/request_for_pickup/request_for_pickup.dart';
import 'package:jetdispatch/views/reservations/reservation_history.dart';
import 'package:jetdispatch/views/user/active_user_list.dart';
import 'package:jetdispatch/views/home/user_guide.dart';
import 'package:jetdispatch/views/tracking/van_tracking.dart';
import 'package:jetdispatch/views/user/user_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.dashboard;
  var _title = "Dashboard";
  final List<String> list = <String>[
    'Lot1',
    'Lot2',
  ];
  final List<String> list1 = <String>['Lot1', 'Lot2', 'ADMINS'];
  final List<String> list2 = <String>[
    'Lot1',
    'Lot2',
  ];
  var dropdownValue = "Lot1";
  var dropdownValue2 = "Lot1";
  var dropdownValue1 = "Lot1";
  List<User> filteredUsers = users;
  bool switchValue = false;

  late Future<List<dynamic>> futureLiveReservation =
      fetchReservations(ApiUrlsLiveReservations.liveReservationUrls[0]);

  late Future<List<dynamic>> futureDispatchInfo =
      fetchReservations(ApiUrls.apiUrls[0]);

  late Future<List<dynamic>> futureReservation =
      fetchReservations(ApiUrlsReservations.reservationUrls[0]);

  //late final List<ReservationDataModel> reservations;

  Future<void> _refreshDataLiveReservation() async {
    setState(() {
      if (dropdownValue == 'Lot1') {
        futureLiveReservation =
            fetchReservations(ApiUrlsLiveReservations.liveReservationsForLot1);
      } else if (dropdownValue == 'Lot2') {
        futureLiveReservation =
            fetchReservations(ApiUrlsLiveReservations.liveReservationsForLot2);
      }
    });
  }

  Future<void> _refreshDataReservation() async {
    setState(() {
      if (dropdownValue == 'Lot1') {
        futureLiveReservation =
            fetchReservations(ApiUrlsReservations.reservationsForLot1);
      } else if (dropdownValue == 'Lot2') {
        futureLiveReservation =
            fetchReservations(ApiUrlsReservations.reservationsForLot2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var container;

    if (currentPage == DrawerSections.dashboard) {
      container = const DashboardPage();
    } else if (currentPage == DrawerSections.pickups) {
      container = const Pickups();
    } else if (currentPage == DrawerSections.dropoffs) {
      container = const Dropoffs();
    } else if (currentPage == DrawerSections.liveReservation) {
      container = Reservation(
        futureReservation: futureLiveReservation,
        refreshData: _refreshDataLiveReservation,
      );
    } else if (currentPage == DrawerSections.reservation) {
      container = ReservationHistory(
        futureReservation: futureReservation,
        refreshDataReservation: _refreshDataReservation,
      );
    } else if (currentPage == DrawerSections.quickMove) {
      container = const QuickMove();
    } else if (currentPage == DrawerSections.history) {
      container = const History();
    } else if (currentPage == DrawerSections.inp) {
      container = const CheckIn();
    } else if (currentPage == DrawerSections.outp) {
      container = const CheckOut();
    } else if (currentPage == DrawerSections.requestforpickup) {
      container = const RequestForPickup();
    } else if (currentPage == DrawerSections.activeuserlist) {
      container = ActiveUserList(filteredUsers: filteredUsers);
    } else if (currentPage == DrawerSections.vantracking) {
      container = const VanTracking();
    } else if (currentPage == DrawerSections.userguide) {
      container = const UserGuide();
    } else if (currentPage == DrawerSections.dispatchinfo) {
      container = DispatchInfoScreen(futureDispatchInfo: futureDispatchInfo);
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.red[700],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19.5,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          _title == 'Active User'
              ? DropdownButton<String>(
                  value: dropdownValue1,

                  icon: const Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Colors.white,
                  ),

                  // style: const TextStyle(color: Colors.deepPurple),
                  selectedItemBuilder: (BuildContext context) {
                    return list1.map((String value) {
                      return Align(
                        alignment: Alignment.center,
                        child: Text(
                          dropdownValue1,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      );
                    }).toList();
                  },
                  underline: const SizedBox(
                    height: 2,
                  ),

                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    dropdownValue1 = value!;
                    setState(() {
                      dropdownValue1 = value;
                    });
                  },
                  items: list1.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                )
              : const SizedBox(
                  width: 0,
                  height: 0,
                ),
          _title == 'Live Reservation'
              ? RefreshIndicator(
                  onRefresh: _refreshDataLiveReservation,
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.white,
                    ),
                    selectedItemBuilder: (BuildContext context) {
                      return list.map((String value) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            dropdownValue,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        );
                      }).toList();
                    },
                    underline: const SizedBox(
                      height: 2,
                    ),
                    onChanged: (String? value) async {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                        if (dropdownValue == 'Lot1') {
                          futureLiveReservation = fetchReservations(
                              ApiUrlsLiveReservations.liveReservationsForLot1);
                        } else if (dropdownValue == 'Lot2') {
                          futureLiveReservation = fetchReservations(
                              ApiUrlsLiveReservations.liveReservationsForLot2);
                        }
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                        ),
                      );
                    }).toList(),
                  ),
                )
              : const SizedBox(
                  width: 30,
                  height: 0,
                ),
          _title == 'Quick Move'
              ? DropdownButton<String>(
                  value: dropdownValue,

                  icon: const Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Colors.white,
                  ),
                  // elevation: 16,
                  // style: const TextStyle(color: Colors.deepPurple),
                  selectedItemBuilder: (BuildContext context) {
                    return list.map((String value) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          dropdownValue,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      );
                    }).toList();
                  },

                  underline: const SizedBox(
                    height: 2,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    dropdownValue = value!;
                    setState(() {
                      dropdownValue = value;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                )
              : const SizedBox(
                  width: 20,
                  height: 0,
                ),
          _title == 'Reservations'
              ? RefreshIndicator(
                  onRefresh: _refreshDataReservation,
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.white,
                    ),
                    selectedItemBuilder: (BuildContext context) {
                      return list.map((String value) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            dropdownValue,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        );
                      }).toList();
                    },
                    underline: const SizedBox(
                      height: 2,
                    ),
                    onChanged: (String? value) async {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                        if (dropdownValue == 'Lot1') {
                          futureReservation = fetchReservations(
                              ApiUrlsReservations.reservationsForLot1);
                        } else if (dropdownValue == 'Lot2') {
                          futureReservation = fetchReservations(
                              ApiUrlsReservations.reservationsForLot2);
                        }
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                        ),
                      );
                    }).toList(),
                  ),
                )
              : const SizedBox(
                  width: 30,
                  height: 0,
                ),
          // ? Container(
          //     child: DropdownButton<String>(
          //       value: dropdownValue,

          //       icon: const Icon(
          //         Icons.arrow_drop_down_outlined,
          //         color: Colors.white,
          //       ),
          //       // elevation: 16,
          //       // style: const TextStyle(color: Colors.deepPurple),
          //       selectedItemBuilder: (BuildContext context) {
          //         return list.map((String value) {
          //           return Align(
          //             alignment: Alignment.centerLeft,
          //             child: Text(
          //               dropdownValue,
          //               style: const TextStyle(
          //                   color: Colors.white, fontSize: 18),
          //             ),
          //           );
          //         }).toList();
          //       },

          //       underline: const SizedBox(
          //         height: 2,
          //       ),
          //       onChanged: (String? value) {
          //         // This is called when the user selects an item.
          //         dropdownValue = value!;
          //         setState(() {
          //           dropdownValue = value;
          //         });
          //       },
          //       items: list.map<DropdownMenuItem<String>>((String value) {
          //         return DropdownMenuItem<String>(
          //           value: value,
          //           child: Text(
          //             value,
          //           ),
          //         );
          //       }).toList(),
          //     ),
          //   )
          // : const SizedBox(
          //     width: 20,
          //     height: 0,
          //   ),
          _title == 'Dispatch Info'
              ? DropdownButton<String>(
                  value: dropdownValue2,

                  icon: const Icon(Icons.arrow_drop_down_outlined),
                  elevation: 16,
                  // style: const TextStyle(color: Colors.deepPurple),
                  selectedItemBuilder: (BuildContext context) {
                    return list2.map((String value) {
                      return Align(
                        alignment: Alignment.center,
                        child: Text(
                          dropdownValue2,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      );
                    }).toList();
                  },

                  underline: const SizedBox(
                    height: 2,
                  ),

                  onChanged: (String? value) async {
                    // This is called when the user selects an item.
                    dropdownValue2 = value.toString();
                    setState(() {
                      if (dropdownValue2 == 'Lot1') {
                        futureDispatchInfo =
                            fetchDispatchInfo(ApiUrls.dispatchInfoLotOne);
                      } else if (dropdownValue2 == 'Lot2') {
                        futureDispatchInfo =
                            fetchDispatchInfo(ApiUrls.dispatchInfoLotTwo);
                      }
                    });
                  },
                  items: list2.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                )
              : const SizedBox(
                  width: 0,
                  height: 0,
                ),
        ],
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyHeaderDrawer(),
              MyDrawerList(),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Pickups", Icons.arrow_upward,
              currentPage == DrawerSections.pickups ? true : false),
          menuItem(3, "Dropoffs", Icons.arrow_downward,
              currentPage == DrawerSections.dropoffs ? true : false),

          menuItem(4, "Live Reservation", Icons.home_repair_service,
              currentPage == DrawerSections.liveReservation ? true : false),
          menuItem(5, "Reservations", Icons.book_online,
              currentPage == DrawerSections.reservation ? true : false),
          menuItem(6, "Quick Move", Icons.car_rental,
              currentPage == DrawerSections.quickMove ? true : false),

          menuItem(7, "History", Icons.access_time,
              currentPage == DrawerSections.history ? true : false),
          menuItem(8, "IN-p", Icons.download,
              currentPage == DrawerSections.inp ? true : false),
          menuItem(9, "OUT-p", Icons.logout,
              currentPage == DrawerSections.outp ? true : false),
          // const Divider(),
          menuItem(10, "Request For Pickup", Icons.add,
              currentPage == DrawerSections.requestforpickup ? true : false),
          menuItem(11, "Active User", Icons.group,
              currentPage == DrawerSections.activeuserlist ? true : false),
          menuItem(12, "Van Tracking", Icons.pin_drop,
              currentPage == DrawerSections.vantracking ? true : false),
          menuItem(13, "User Guide", Icons.school,
              currentPage == DrawerSections.userguide ? true : false),
          menuItem(14, "Dispatch Info", Icons.info,
              currentPage == DrawerSections.dispatchinfo ? true : false),
          // menuItem(11, "Log Out", Icons.school,
          //     currentPage == DrawerSections.logout ? true : false),
          Container(
            padding: const EdgeInsets.fromLTRB(40, 10, 0, 10),
            child: const Align(
              alignment: AlignmentDirectional.centerStart,
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Icon(Icons.fingerprint),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Quick sign in",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(40, 10, 0, 10),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Icon(Icons.mark_email_unread_sharp),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Notifications",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const Spacer(),
                  Transform.scale(
                    scale: 0.6,
                    child: Switch.adaptive(
                      value: switchValue,
                      onChanged: (newValue) {
                        setState(() {
                          switchValue = newValue;
                        });
                      },
                      activeColor: Colors.red,
                      inactiveTrackColor: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(40, 10, 0, 10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const SignIn()));
              },
              child: const Align(
                alignment: AlignmentDirectional.centerStart,
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Icon(Icons.logout),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Sign Out",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(40, 10, 0, 10),
            child: const Align(
              alignment: AlignmentDirectional.centerStart,
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Icon(Icons.info_outline_rounded),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Version : Prod.1.3.3 Beta",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              _title = title;
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              _title = title;
              currentPage = DrawerSections.pickups;
            } else if (id == 3) {
              _title = title;
              currentPage = DrawerSections.dropoffs;
            } else if (id == 4) {
              _title = title;
              currentPage = DrawerSections.liveReservation;
            } else if (id == 5) {
              _title = title;
              currentPage = DrawerSections.reservation;
            } else if (id == 6) {
              _title = title;
              currentPage = DrawerSections.quickMove;
            } else if (id == 7) {
              _title = title;
              currentPage = DrawerSections.history;
            } else if (id == 8) {
              _title = title;
              currentPage = DrawerSections.inp;
            } else if (id == 9) {
              _title = title;
              currentPage = DrawerSections.outp;
            } else if (id == 10) {
              _title = "Pickup Entry";
              currentPage = DrawerSections.requestforpickup;
            } else if (id == 11) {
              _title = title;
              currentPage = DrawerSections.activeuserlist;
            } else if (id == 12) {
              _title = title;
              currentPage = DrawerSections.vantracking;
            } else if (id == 13) {
              _title = title;
              currentPage = DrawerSections.userguide;
            } else if (id == 14) {
              _title = title;
              currentPage = DrawerSections.dispatchinfo;
            }
            // else if (id == 11) {
            //   Navigator.pushReplacement(context,
            //       MaterialPageRoute(builder: (context) => const SignInP()));
            // }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  pickups,
  dropoffs,
  liveReservation,
  reservation,
  quickMove,
  history,
  inp,
  outp,
  requestforpickup,
  activeuserlist,
  vantracking,
  userguide,
  dispatchinfo,
  // logout,
}
