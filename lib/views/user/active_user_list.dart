import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jetdispatch/views/includes/dialogs.dart';
import 'package:jetdispatch/views/user/user_list.dart';

class ActiveUserList extends StatefulWidget {
  List<User> filteredUsers = users;
  ActiveUserList({Key? key, required this.filteredUsers}) : super(key: key);

  @override
  State<ActiveUserList> createState() => _ActiveUserListState();
}

class _ActiveUserListState extends State<ActiveUserList> {
  List<User> filteredUsers = users;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: widget.filteredUsers.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                // child: Slidable(
                //   actionPane: const SlidableDrawerActionPane(),
                //   actionExtentRatio: 0.15,
                //   actions: [
                //     IconSlideAction(
                //       icon: Icons.delete,
                //       onTap: () async {
                //         final action = await Dialogs.yesAbortDialog(
                //             context,
                //             'Are you sure?',
                //             'You will not be able to recover this user!');
                //         if (action == DialogAction.yes) {
                //           print("Yes");
                //         } else {
                //           print("No");
                //         }
                //       },
                //       color: const Color(0xfff0f2f3),
                //       foregroundColor: Colors.red,
                //     ),
                //   ],
                //   secondaryActions: [
                //     IconSlideAction(
                //       icon: Icons.edit,
                //       onTap: () {
                //         print("Taped on a edit icon");
                //       },
                //       color: const Color(0xfff0f2f3),
                //       foregroundColor: Colors.orange,
                //     ),
                //   ],
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(15),
                //       color: Colors.white,
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           const Icon(Icons.phone_android),
                //           Padding(
                //             padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 Text(
                //                   widget.filteredUsers[index].name,
                //                   style: GoogleFonts.roboto(
                //                     textStyle: const TextStyle(
                //                         fontSize: 18.5,
                //                         fontWeight: FontWeight.bold),
                //                   ),
                //                 ),
                //                 Padding(
                //                   padding:
                //                       const EdgeInsets.fromLTRB(0, 5, 0, 0),
                //                   child: Text(
                //                     widget.filteredUsers[index].location,
                //                     style: GoogleFonts.roboto(
                //                       textStyle: const TextStyle(
                //                           fontSize: 17,
                //                           fontWeight: FontWeight.w400),
                //                     ),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                //             child: Column(
                //               children: [
                //                 Container(
                //                     decoration: BoxDecoration(
                //                       color: Colors.amber.shade200,
                //                     ),
                //                     padding: const EdgeInsets.all(4),
                //                     child: Text(
                //                       'Office',
                //                       style: GoogleFonts.roboto(
                //                         textStyle: const TextStyle(
                //                             fontSize: 16,
                //                             fontWeight: FontWeight.w500),
                //                       ),
                //                     )),
                //                 Padding(
                //                   padding:
                //                       const EdgeInsets.fromLTRB(0, 5, 0, 0),
                //                   child: Text(
                //                     widget.filteredUsers[index].time,
                //                     style: GoogleFonts.roboto(
                //                         textStyle:
                //                             const TextStyle(fontSize: 15)),
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //           SizedBox(
                //             height: 40,
                //             width: 40,
                //             child: Container(
                //               decoration: const BoxDecoration(
                //                 color: Colors.red,
                //               ),
                //               child: const Icon(
                //                 Icons.logout,
                //                 color: Colors.white,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     // child: ListTile(
                //     //   leading: const Icon(Icons.phone_android),
                //     //   title: Padding(
                //     //     padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                //     //     child: Row(
                //     //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     //       crossAxisAlignment: CrossAxisAlignment.center,
                //     //       children: [
                //     //         Text(
                //     //           // users[index],
                //     //           'Imran',
                //     //           style: TextStyle(fontWeight: FontWeight.bold),
                //     //         ),
                //     //         Container(
                //     //             decoration: BoxDecoration(
                //     //               color: Colors.amber.shade200,
                //     //             ),
                //     //             padding: const EdgeInsets.all(4),
                //     //             child: const Text(
                //     //               'Office',
                //     //               style: TextStyle(fontWeight: FontWeight.w400),
                //     //             ))
                //     //       ],
                //     //     ),
                //     //   ),
                //     //   trailing: SizedBox(
                //     //     height: 40,
                //     //     width: 40,
                //     //     child: Container(
                //     //       decoration: const BoxDecoration(
                //     //         color: Colors.red,
                //     //       ),
                //     //       child: const Icon(
                //     //         Icons.logout,
                //     //         color: Colors.white,
                //     //       ),
                //     //     ),
                //     //     // child: IconButton(
                //     //     //     onPressed: () {},
                //     //     //     style: IconButton.styleFrom(
                //     //     //         backgroundColor: Colors.red
                //     //     //         // backgroundColor: users[index] == "User Three" ||
                //     //     //         //         users[index] == "User Six" ||
                //     //     //         //         users[index] == "User Eight"
                //     //     //         //     ? Colors.red
                //     //     //         //     : Colors.green,
                //     //     //         ),
                //     //     //     icon: const Icon(
                //     //     //       Icons.logout,
                //     //     //       color: Colors.white,
                //     //     //     )),
                //     //   ),
                //     //   subtitle: Text(
                //     //     "Lot1",
                //     //     style: GoogleFonts.roboto(
                //     //       textStyle: const TextStyle(
                //     //           fontSize: 16, fontWeight: FontWeight.w500),
                //     //     ),
                //     //   ),
                //     //   onTap: () {
                //     //     print("Taped on a list item");
                //     //   },
                //     // ),
                //   ),
                // ),
              );
            },
          ),
        ),
      ),
    );
  }
}
