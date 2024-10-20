//   // ignore: non_constant_identifier_names, unused_import
//   import 'package:dr_drink/screens/profile_screen.dart';
// import 'package:flutter/material.dart';


// abstract class Profile extends State<ProfilePage> {
 

//  static void dailyGoal_dialog(BuildContext context) {
//     showDialog(
      
//       context: context, 
//       builder: (context)
//     {
//        return AlertDialog(
        
//           title: const Text('Daily Goal'),
//           content: TextField(
//             controller: _goalController,
//             keyboardType: TextInputType.number,
//             decoration: const InputDecoration(
//               hintText: '90.0 Oz', 
//             ),
//           ),
//          actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // إغلاق المربع
//               },
//               child: const Text('Cancel',style: TextStyle(color:Colors.blue)),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                // function of save data 
//                 Navigator.pop(context); // إغلاق المربع وحفظ القيمة
//               },
//               child: const Text('Save',style: TextStyle(color:Colors.blue),),
//             ),
//           ],
//         );
//       }
//     );
                              
//   }
// // ignore: non_constant_identifier_names
// static  void units_dialog(BuildContext context) {
//     showDialog(
//       context: context, 
//       builder: (context)
//     {
//        return AlertDialog(
//           title: const Text('units'),
//           content:SizedBox(
//             height: 150,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                SizedBox(
//                   width: 70,
//                  height: 200,
//                   child: ListWheelScrollView(
                   
//                     // ignore: avoid_print
//                     // onSelectedItemChanged: (value) => print(value),
//                     itemExtent:50,
//                     perspective: 0.006,
//                     diameterRatio: 0.4,
//                     physics: const FixedExtentScrollPhysics(),
//                     children: const [
//                       Center(child: Text("US Oz")),
//                         Center(child: Text("UK Oz")),
//                         Center(child: Text("ml")),
//                     ],
//                  ),
//                 ),
//                 SizedBox(
//                   width: 70,
//                   child: ListWheelScrollView(
                  
//                     // ignore: avoid_print
//                     // onSelectedItemChanged: (value) => print(value),
//                     itemExtent:50,
//                     perspective: 0.005,
//                     diameterRatio: 0.4,
//                     physics: const FixedExtentScrollPhysics(),
//                     children: const [
//                       Center(child: Text("lbs")),
//                         Center(child: Text("kg")),
//                     ],
//                        ),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // إغلاق المربع
//               },
//               child: const Text('Cancel',style: TextStyle(color:Colors.blue)),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                // function of save data 
//                 Navigator.pop(context); // إغلاق المربع وحفظ القيمة
//               },
//               child: const Text('Save',style: TextStyle(color:Colors.blue),),
//             ),
//           ],
//         );
//       }
//     );
//   }
 
//  // ignore: non_constant_identifier_names
//  static void gender_dialog(BuildContext context) {
//     showDialog(
//       context: context, 
//       builder: (context)
//     {
//        return AlertDialog(
//           title: const Text('Gender'),
//           content:SizedBox(
//              width: 70,
//              height: 200,
//              child: ListWheelScrollView(
//                // ignore: avoid_print
//             //   onSelectedItemChanged: (value) => print(value),
//                itemExtent:50,
//                     perspective: 0.006,
//                     diameterRatio: 0.4,
//                physics: const FixedExtentScrollPhysics(),
//                children: 
//                const [
//                  Center(child: Text("Male")),
//                    Center(child: Text("Female")),
//                    Center(child: Text("Others")),
//                ],
//             ),
//            ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // إغلاق المربع
//               },
//               child: const Text('Cancel',style: TextStyle(color:Colors.blue)),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                // function of save data 
//                 Navigator.pop(context); // إغلاق المربع وحفظ القيمة
//               },
//               child: const Text('Save',style: TextStyle(color:Colors.blue),),
//             ),
//           ],
//         );
//       }
//     );
//   }
 
// // ignore: non_constant_identifier_names
// static void weight_dialog(BuildContext context) {
//     showDialog(
//       context: context, 
//       builder: (context)
//     {
//        return AlertDialog(
//           title: const Text('Weight'),
//           content: SizedBox(
//             width: 50,
//             height: 100,
//             child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(
//                width: 70,
//               height: 200,
//                child: ListWheelScrollView.useDelegate(
//                  itemExtent:50,
//                     perspective: 0.005,
//                     diameterRatio: 0.4,
//                 childDelegate: ListWheelChildBuilderDelegate(
//                   childCount: 60,
//                   builder: (context,index){
//                      return Text((50+index).toString());
//                 }),
//                  // ignore: avoid_print
//               //   onSelectedItemChanged: (value) => print(value),
//                  physics: const FixedExtentScrollPhysics(),
              
//               ),
//              ),
//              SizedBox(
//                    width: 70,
//                  height: 200,
//                     child: ListWheelScrollView(
                    
//                       // ignore: avoid_print
//                       // onSelectedItemChanged: (value) => print(value),
//                       itemExtent:50,
//                     perspective: 0.006,
//                     diameterRatio: 0.4,
//                       physics: const FixedExtentScrollPhysics(),
//                       children: const [
                        
//                           Center(child: Text("kg")),
//                           Center(child: Text("lbs")),
//                       ],
//                          ),
//                   ),

//               ],           
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // إغلاق المربع
//               },
//               child: const Text('Cancel',style: TextStyle(color:Colors.blue)),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                // function of save data 
//                 Navigator.pop(context); // إغلاق المربع وحفظ القيمة
//               },
//               child: const Text('Save',style: TextStyle(color:Colors.blue),),
//             ),
//           ],
//         );
//       }
//     );
//   }
//  // ignore: non_constant_identifier_names
//  static void timer_dialog(BuildContext context) {
//     showDialog(
//       context: context, 
//       builder: (context)
//     {
//        return AlertDialog(
//           title: const Text('Gender'),
//           content:SizedBox(
//              width: 70,
//              height: 150,
//              child: ListWheelScrollView(
//                // ignore: avoid_print
//             //   onSelectedItemChanged: (value) => print(value),
//                itemExtent:50,
//                     perspective: 0.006,
//                     diameterRatio: 0.4,
//                physics: const FixedExtentScrollPhysics(),
//                children: 
//                const [
//                  Center(child: Text("Follow The System")),
//                    Center(child: Text("24_hours")),
//                    Center(child: Text("12_hours")),
//                ],
//             ),
//            ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // إغلاق المربع
//               },
//               child: const Text('Cancel',style: TextStyle(color:Colors.blue)),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                // function of save data 
//                 Navigator.pop(context); // إغلاق المربع وحفظ القيمة
//               },
//               child: const Text('Save',style: TextStyle(color:Colors.blue),),
//             ),
//           ],
//         );
//       }
//     );
//   }
 
// // ignore: non_constant_identifier_names
//  static void days_dialog(BuildContext context) {
//     showDialog(
//       context: context, 
//       builder: (context)
//     {
//        return AlertDialog(
//           title: const Text('Gender'),
//           content: DatePickerDialog(firstDate:DateTime(2000), lastDate:DateTime(2024),),
          


//           // final DateTime? picked = await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2101)),
//           // content:showDatePicker(context: context, firstDate: firstDate, lastDate: lastDate) ,

//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // إغلاق المربع
//               },
//               child: const Text('Cancel',style: TextStyle(color:Colors.blue)),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                // function of save data 
//                 Navigator.pop(context); // إغلاق المربع وحفظ القيمة
//               },
//               child: const Text('Save',style: TextStyle(color:Colors.blue),),
//             ),
//           ],
//         );
//       }
//     );
//   }


// }
  