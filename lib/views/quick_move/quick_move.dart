import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickMove extends StatefulWidget {
  const QuickMove({super.key});

  @override
  State<QuickMove> createState() => _QuickMoveState();
}

class _QuickMoveState extends State<QuickMove> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14.0),
      padding: const EdgeInsets.all(1.5),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text(
                    'Claim ID',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 45,
                  width: 360,
                  child: TextField(
                    enabled: true,
                    obscureText: true,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: const Color(0x80F9F9F9),
                        labelText: 'Enter User ID',
                        labelStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300)),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Card(
                  color: Colors.grey.shade100,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  elevation: 1.5,
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Location',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Text('Row'),
                            ),
                            SizedBox(
                              height: 35,
                              width: 290,
                              child: TextField(
                                enabled: true,
                                obscureText: true,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 0.5),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Color(0x80F9F9F9),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Text('Stall'),
                            ),
                            SizedBox(
                              height: 35,
                              width: 290,
                              child: TextField(
                                enabled: true,
                                obscureText: true,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 0.5),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Color(0x80F9F9F9),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.grey.shade100,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  elevation: 1.5,
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New Location',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Text('Row'),
                            ),
                            SizedBox(
                              height: 35,
                              width: 290,
                              child: TextField(
                                enabled: true,
                                obscureText: true,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0.5),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Color(0x80F9F9F9),
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Text('Stall'),
                            ),
                            SizedBox(
                              height: 35,
                              width: 290,
                              child: TextField(
                                enabled: true,
                                obscureText: true,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0.5),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Color(0x80F9F9F9),
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Moved By:',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 35,
                  width: 360,
                  child: TextField(
                    enabled: true,
                    obscureText: true,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      suffixIcon:
                          const Icon(Icons.keyboard_arrow_down_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: const Color(0x80F9F9F9),
                      labelStyle: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 130,
                ),
                SizedBox(
                  width: 500,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                      'Update details',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
