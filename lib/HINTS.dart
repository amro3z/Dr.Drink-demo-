

// class CustomCard extends StatefulWidget {
//   const CustomCard(
//       {super.key,
//       required this.path,
//       required this.text,
//       required this.destination});
//   final String path;
//   final String text;
//   final Widget destination;
//   @override
//   State<CustomCard> createState() => _CustomCardState();
// }

// class _CustomCardState extends State<CustomCard> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           height: 100,
//           width: 150,
//           decoration: BoxDecoration(
//             color: const Color(0xff062659),
//             shape: BoxShape.rectangle,
//             borderRadius: BorderRadius.circular(15),
//             image: DecorationImage(
//                 image: AssetImage(widget.path), fit: BoxFit.contain),
//           ),
//           child: Center(
//             child: Text(
//               widget.text,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontFamily: 'RadioCanadaBig',
//               ),
//             ),
//           ),
//         ),
//       ),
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => widget.destination,
//             ));
//       },
//     );
//   }
// }

// class ListCard extends StatefulWidget {
//   const ListCard({super.key});

//   @override
//   State<ListCard> createState() => _ListCardState();
// }

// class _ListCardState extends State<ListCard> {
//   List<CustomCard> categoryCard = [
//     const CustomCard(
//       path: 'assets/images/sports.png',
//       text: "Sports",
//       destination: Sport(),
//     ),
//     const CustomCard(
//       path: 'assets/images/tec.png',
//       text: "Technology",
//       destination: Technology(),
//     ),
//     const CustomCard(
//       path: 'assets/images/Sience.png',
//       text: "Science",
//       destination: Science(),
//     ),
//     const CustomCard(
//       path: 'assets/images/health.png',
//       text: "Health",
//       destination: Health(),
//     ),
//     const CustomCard(
//       path: 'assets/images/entert.png',
//       text: "Entertainment",
//       destination: Entertainment(),
//     ),
//     const CustomCard(
//       path: 'assets/images/busines.png',
//       text: "Business",
//       destination: Business(),
//     )
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 100,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal, // الاتجاه الأفقي
//         itemCount: categoryCard.length,
//         itemBuilder: (context, index) {
//           return categoryCard[index];
//         },
//       ),
//     );
//   }
// }
