import 'package:flutter/material.dart';

// class ScrollableHeaderView extends StatelessWidget {
//   final ScrollController scrollController;
//   final List text;

//   const ScrollableHeaderView(
//       {Key? key, required this.scrollController, required this.text})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 120,
//       child: ListView.builder(
//           controller: scrollController,
//           scrollDirection: Axis.horizontal,
//           shrinkWrap: true,
//           itemCount: text.length,
//           itemBuilder: (context, index) {
//             return Container(
//               margin: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               child: ClipRRect(
//                   borderRadius: BorderRadius.circular(25),
//                   child: Text('${text[index]}')),
//             );
//           }),
//     );
//   }
// }

class ScrollableHeaderView extends StatelessWidget {
  const ScrollableHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          height: 200,
          child: ListView(
            // This next line does the trick.
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                width: 160,
                color: Colors.red,
              ),
              Container(
                width: 160,
                color: Colors.blue,
              ),
              Container(
                width: 160,
                color: Colors.green,
              ),
              Container(
                width: 160,
                color: Colors.yellow,
              ),
              Container(
                width: 160,
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
