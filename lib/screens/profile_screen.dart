import 'dart:math' show Random;
import 'package:dr_drink/screens/reminder.dart';
import 'package:dr_drink/values/color.dart';
import 'package:dr_drink/widgets/soundWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';
// import 'function_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage> {
  // late VoidCallback toggleTheme;
  String selectedSound = 'Water drop 2';
  double volume = 0.5;
  bool vibrationEnabled = true;
  late TextEditingController _passwordController;
  final TextEditingController _goalController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return  SafeArea(
      child: Scaffold(
        backgroundColor:MyColor.blue,
        body:  Padding(
          padding: const EdgeInsets.only(top:18 ),
          child: ListView(
            children: [
              GestureDetector(
                onTap: (){
                  account_dialog(context);
                },
                child: const Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor:Color(0xFF6690DE),
                      child:Icon(Icons.person,color:MyColor.blue,size:35 ,),
                    ),
                    SizedBox(height:10 ,),
                    Row(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Data synchronization ",style:TextStyle(color:Colors.white)),
                        Icon(Icons.arrow_forward_ios_outlined,size:15,color:Colors.white),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25,),
              // ListView(children: [],)
              Row(
                children: [
                  Expanded(child:ClipRRect(
                    borderRadius:BorderRadius.circular(50),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin:const EdgeInsets.all(10),
                      color:const Color(0xFF1D5ACE),
                      child: const Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.water_drop,color:Colors.white),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("0.0 ",style:TextStyle(color:Colors.white,fontSize:25)),
                              Text("ml",style:TextStyle(color:Colors.white)),
                            ],
                          ),
                          Text("Total amount drunk",style:TextStyle(color:Colors.white60)),
                        ],
                      ),
                    ),
                  ),),
                  Expanded(child:ClipRRect(borderRadius:BorderRadius.circular(50),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin:const EdgeInsets.all(10),
                      color:const Color(0xFF1D5ACE),
                      child: const Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.calendar_today_rounded,color:Colors.white),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(" 0 ",style:TextStyle(color:Colors.white,fontSize:25)),
                              Text("days",style:TextStyle(color:Colors.white)),

                            ],
                          ),
                          Text("Total achievement",style:TextStyle(color:Colors.white60)),
                        ],
                      ),
                    ),
                  ),),
                ],
              ),
              Expanded(
                child:ClipRRect(borderRadius: BorderRadius.circular(50),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin:const EdgeInsets.all(10),
                    color:const Color(0xFF1D5ACE),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment:CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(builder:(context)=> const Reminder()));
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.notifications,color:Colors.white),
                              Spacer(flex: 1,),
                              Text("Reminders",style:TextStyle(color:Colors.white)),
                              Spacer(flex:25,),
                              Icon(Icons.arrow_forward_ios_outlined,size:15,color:Colors.white),
                              // Spacer(),
                            ],
                          ),
                        ),
                        const SizedBox(height:25 ),
                        GestureDetector(
                          onTap: (){
                            dailyGoal_dialog(context);
                            // Profile.dailyGoal_dialog(context);
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.water_drop,color:Colors.white),
                              Spacer(flex: 1,),
                              Text("Daily goal",style:TextStyle(color:Colors.white)),
                              Spacer(flex:25,),
                              Text("2301",style:TextStyle(color:Colors.white)),
                              Text("ml ",style:TextStyle(color:Colors.white)),
                              Icon(Icons.arrow_forward_ios_outlined,size:15,color:Colors.white),
                              // Spacer(),
                            ],
                          ),
                        ),
                        const SizedBox(height:25 ),
                        GestureDetector(
                          onTap: (){
                            showSoundSettings( context);
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.volume_up_outlined,color:Colors.white),
                              Spacer(flex: 1,),
                              Text("Sounds and vibrations",style:TextStyle(color:Colors.white)),
                              Spacer(flex:25,),
                              Icon(Icons.arrow_forward_ios_outlined,size:15,color:Colors.white),
                              // Spacer(),
                            ],
                          ),
                        ),
                        const SizedBox(height:25 ),
                        GestureDetector(
                          onTap: (){
                            units_dialog(context);
                            // Profile.units_dialog(context);
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.local_drink,color:Colors.white),
                              Spacer(flex: 1,),
                              Text("Units ",style:TextStyle(color:Colors.white)),
                              Spacer(flex:25,),
                              Text("ml,kg ",style:TextStyle(color:Colors.white)),
                              Icon(Icons.arrow_forward_ios_outlined,size:15,color:Colors.white),
                              // Spacer(),
                            ],
                          ),
                        ),
                        const SizedBox(height:25 ),
                        GestureDetector(
                          onTap: (){
                            showThemeChanger( context);
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.brush_outlined,color:Colors.white),
                              Spacer(flex: 1,),
                              Text("Themes",style:TextStyle(color:Colors.white)),
                              Spacer(flex:25,),
                              Icon(Icons.arrow_forward_ios_outlined,size:15,color:Colors.white),
                              // Spacer(),
                            ],
                          ),
                        ),
                      ],),),
                ),),
              Expanded(
                child:ClipRRect(borderRadius: BorderRadius.circular(50),
                  child:Container(
                    padding: const EdgeInsets.all(15),
                    margin:const EdgeInsets.all(10),
                    color:const Color(0xFF1D5ACE),
                    child:  Column(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment:CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                            gender_dialog(context);
                            //  Profile.gender_dialog(context);
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.person,color:Colors.white),
                              Spacer(flex: 1,),
                              Text("Gender",style:TextStyle(color:Colors.white)),
                              Spacer(flex:25,),
                              Icon(Icons.arrow_forward_ios_outlined,size:15,color:Colors.white),
                              // Spacer(),
                            ],
                          ),
                        ),
                        const SizedBox(height:25 ),

                        GestureDetector(
                          onTap: (){
                            weight_dialog(context);
                            //  Profile.weight_dialog(context);
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.line_weight_sharp,color:Colors.white),
                              Spacer(flex: 1,),
                              Text("Weight",style:TextStyle(color:Colors.white)),
                              Spacer(flex:25,),
                              Icon(Icons.arrow_forward_ios_outlined,size:15,color:Colors.white),
                              // Spacer(),
                            ],
                          ),
                        ),
                        const SizedBox(height:25 ),
                        GestureDetector(
                          onTap: (){
                            timer_dialog(context);
                            // Profile.timer_dialog(context);
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.timelapse_outlined,color:Colors.white),
                              Spacer(flex: 1,),
                              Text("Time Format",style:TextStyle(color:Colors.white)),
                              Spacer(flex:25,),
                              Text("Follow The System",style:TextStyle(color:Colors.white)),
                              Icon(Icons.arrow_forward_ios_outlined,size:15,color:Colors.white),
                              // Spacer(),
                            ],
                          ),
                        ),
                        const SizedBox(height:25 ),
                        GestureDetector(
                          onTap: (){
                            days_dialog(context);
                            // Profile.days_dialog(context);
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.calendar_month_rounded,color:Colors.white),
                              Spacer(flex: 1,),
                              Text("First day of the week",style:TextStyle(color:Colors.white)),
                              Spacer(flex:25,),
                              Text("Sunday",style:TextStyle(color:Colors.white)),
                              Icon(Icons.arrow_forward_ios_outlined,size:15,color:Colors.white),


                              // Spacer(),
                            ],
                          ),
                        ),
                        SizedBox(height:25 ),
                      ],),),),),
            ],
          ),
        ),
      ),
    );
  }


  void showThemeChanger(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Choose Theme',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                ListTile(
                  leading: const Icon(Icons.light_mode),
                  title: const Text('Light Theme'),
                  onTap: () {
                    Navigator.pop(context); // غلق النافذة
                    // toggleTheme(); // تفعيل الثيم الفاتح
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: const Text('Dark Theme'),
                  onTap: () {
                    Navigator.pop(context); // غلق النافذة
                    // toggleTheme(); // تفعيل الثيم الداكن
                  },
                ),
              ],
            ),
          );
        }
    );
  }

  void showSoundSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SoundSettingsContent();
      },
    );
  }

  // ignore: non_constant_identifier_names
  void account_dialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context)
        {
          return AlertDialog(
            title: const Text('Account'),
            content:SizedBox(
              width: 70,
              height: 200,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // حقل عرض كلمة المرور العشوائية
                  TextField(
                    controller: _passwordController,
                    readOnly: true,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // النص الخاص بتغيير كلمة المرور
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: _showChangePasswordDialog,
                      child: const Text(
                        'Change Password',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // إغلاق المربع
                },
                child: const Text('Cancel',style: TextStyle(color:Colors.blue)),
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false,
                  );
                },
                child: const Text('Log Out',style: TextStyle(color:Colors.red),),
              ),
            ],
          );
        }
    );
  }
  @override
  void initState() {
    super.initState();
    // إنشاء كلمة مرور عشوائية وضبطها في TextEditingController
    String randomPassword = generateRandomPassword(10);
    _passwordController = TextEditingController(text: randomPassword);
  }
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
  String generateRandomPassword(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(
      length,
          (_) => chars.codeUnitAt(random.nextInt(chars.length)),
    ));
  }
  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Password',style: TextStyle(color:Colors.blue)),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Old Password',
                ),
              ),
              SizedBox(height: 8),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                ),
              ),
              SizedBox(height: 8),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm the new password',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel',style: TextStyle(color:Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                // منطق تغيير كلمة المرور هنا
                Navigator.of(context).pop();
              },
              child: const Text('Sumbit',style: TextStyle(color:Colors.blue),),
            ),
          ],
        );
      },
    );
  }





  void dailyGoal_dialog(BuildContext context) {
    showDialog(

        context: context,
        builder: (context)
        {
          return AlertDialog(

            title: const Text('Daily Goal'),
            content: TextField(
              controller: _goalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: '90.0 Oz',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // إغلاق المربع
                },
                child: const Text('Cancel',style: TextStyle(color:Colors.blue)),
              ),
              ElevatedButton(
                onPressed: () {
                  // function of save data
                  Navigator.pop(context); // إغلاق المربع وحفظ القيمة
                },
                child: const Text('Save',style: TextStyle(color:Colors.blue),),
              ),
            ],
          );
        }
    );

  }

  void units_dialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context)
        {
          return AlertDialog(
            title: const Text('units'),
            content:SizedBox(
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70,
                    height: 200,
                    child: ListWheelScrollView(

                      // ignore: avoid_print
                      // onSelectedItemChanged: (value) => print(value),
                      itemExtent:50,
                      perspective: 0.006,
                      diameterRatio: 0.4,
                      physics: const FixedExtentScrollPhysics(),
                      children: const [
                        Center(child: Text("US Oz")),
                        Center(child: Text("UK Oz")),
                        Center(child: Text("ml")),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: ListWheelScrollView(

                      // ignore: avoid_print
                      // onSelectedItemChanged: (value) => print(value),
                      itemExtent:50,
                      perspective: 0.005,
                      diameterRatio: 0.4,
                      physics: const FixedExtentScrollPhysics(),
                      children: const [
                        Center(child: Text("lbs")),
                        Center(child: Text("kg")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // إغلاق المربع
                },
                child: const Text('Cancel',style: TextStyle(color:Colors.blue)),
              ),
              ElevatedButton(
                onPressed: () {
                  // function of save data
                  Navigator.pop(context); // إغلاق المربع وحفظ القيمة
                },
                child: const Text('Save',style: TextStyle(color:Colors.blue),),
              ),
            ],
          );
        }
    );
  }

  // ignore: non_constant_identifier_names
  void gender_dialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context)
        {
          return AlertDialog(
            title: const Text('Gender'),
            content:SizedBox(
              width: 70,
              height: 200,
              child: ListWheelScrollView(
                // ignore: avoid_print
                //   onSelectedItemChanged: (value) => print(value),
                itemExtent:50,
                perspective: 0.006,
                diameterRatio: 0.4,
                physics: const FixedExtentScrollPhysics(),
                children:
                const [
                  Center(child: Text("Male")),
                  Center(child: Text("Female")),
                  Center(child: Text("Others")),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // إغلاق المربع
                },
                child: const Text('Cancel',style: TextStyle(color:Colors.blue)),
              ),
              ElevatedButton(
                onPressed: () {
                  // function of save data
                  Navigator.pop(context); // إغلاق المربع وحفظ القيمة
                },
                child: const Text('Save',style: TextStyle(color:Colors.blue),),
              ),
            ],
          );
        }
    );
  }

// ignore: non_constant_identifier_names
  void weight_dialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context)
        {
          return AlertDialog(
            title: const Text('Weight'),
            content: SizedBox(
              width: 50,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70,
                    height: 200,
                    child: ListWheelScrollView.useDelegate(
                      itemExtent:50,
                      perspective: 0.005,
                      diameterRatio: 0.4,
                      childDelegate: ListWheelChildBuilderDelegate(
                          childCount: 60,
                          builder: (context,index){
                            return Text((50+index).toString());
                          }),
                      // ignore: avoid_print
                      //   onSelectedItemChanged: (value) => print(value),
                      physics: const FixedExtentScrollPhysics(),

                    ),
                  ),
                  SizedBox(
                    width: 70,
                    height: 200,
                    child: ListWheelScrollView(

                      // ignore: avoid_print
                      // onSelectedItemChanged: (value) => print(value),
                      itemExtent:50,
                      perspective: 0.006,
                      diameterRatio: 0.4,
                      physics: const FixedExtentScrollPhysics(),
                      children: const [

                        Center(child: Text("kg")),
                        Center(child: Text("lbs")),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // إغلاق المربع
                },
                child: const Text('Cancel',style: TextStyle(color:Colors.blue)),
              ),
              ElevatedButton(
                onPressed: () {
                  // function of save data
                  Navigator.pop(context); // إغلاق المربع وحفظ القيمة
                },
                child: const Text('Save',style: TextStyle(color:Colors.blue),),
              ),
            ],
          );
        }
    );
  }
  // ignore: non_constant_identifier_names
  void timer_dialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context)
        {
          return AlertDialog(
            title: const Text('Gender'),
            content:SizedBox(
              width: 70,
              height: 150,
              child: ListWheelScrollView(
                // ignore: avoid_print
                //   onSelectedItemChanged: (value) => print(value),
                itemExtent:50,
                perspective: 0.006,
                diameterRatio: 0.4,
                physics: const FixedExtentScrollPhysics(),
                children:
                const [
                  Center(child: Text("Follow The System")),
                  Center(child: Text("24_hours")),
                  Center(child: Text("12_hours")),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // إغلاق المربع
                },
                child: const Text('Cancel',style: TextStyle(color:Colors.blue)),
              ),
              ElevatedButton(
                onPressed: () {
                  // function of save data
                  Navigator.pop(context); // إغلاق المربع وحفظ القيمة
                },
                child: const Text('Save',style: TextStyle(color:Colors.blue),),
              ),
            ],
          );
        }
    );
  }

// ignore: non_constant_identifier_names
  void days_dialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context)
        {
          return AlertDialog(
            title: const Text('Gender'),
            content: DatePickerDialog(firstDate:DateTime(2000), lastDate:DateTime(2024),),



            // final DateTime? picked = await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2101)),
            // content:showDatePicker(context: context, firstDate: firstDate, lastDate: lastDate) ,

            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // إغلاق المربع
                },
                child: const Text('Cancel',style: TextStyle(color:Colors.blue)),
              ),
              ElevatedButton(
                onPressed: () {
                  // function of save data
                  Navigator.pop(context); // إغلاق المربع وحفظ القيمة
                },
                child: const Text('Save',style: TextStyle(color:Colors.blue),),
              ),
            ],
          );
        }
    );
  }


}



















// Stack(
//                                children: [
//                                  TextField(
//                   controller: _passwordController,
//                   obscureText: _obscureText,
//                   decoration: InputDecoration(
//                     labelText: 'كلمة المرور',
//                     border: OutlineInputBorder(),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscureText ? Icons.visibility : Icons.visibility_off,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscureText = !_obscureText;
//                         });
//                       },
//                     ),
//                   ),
//                                  ),
//                                  // SizedBox(height: 5,),
//                                  // النص الصغير في الأسفل على اليمين
//                                  Positioned(
//                   right: 1,
//                   bottom: -10,
//                   child: Text(
//                     'يجب أن تكون 6 أحرف على الأقل',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                                  ),
//                                ],
//                              ),

//  Column(
//   mainAxisSize: MainAxisSize.min,
//   crossAxisAlignment: CrossAxisAlignment.start,
//  children: [
//   Text("choose .... ",style: TextStyle(fontSize: 20),),

//    RadioListTile(
//      activeColor: Colors.blue,
//        title: Text("Us Oz"),
//        value: "Us Oz",
//       groupValue: value1 ,
//        onChanged: (val){
//         setState((){
//          value1=val.toString();
//         });
//        }),

//        RadioListTile(
//          activeColor: Colors.blue,
//        title: Text("Uk Oz"),
//        value: "Uk Oz",
//       groupValue: value1 ,
//        onChanged: (val){
//          setState((){
//          value1=val.toString();
//         });
//        }),

//    RadioListTile(
//      activeColor: Colors.blue,
//            title: Text("ml"),
//            value: "ml",
//           groupValue: value1 ,
//            onChanged: (val){
//              setState((){
//          value1=val.toString();
//         });
//            }),

//     Text("choose ....222 ",style: TextStyle(fontSize: 20),),

//          RadioListTile(
//      activeColor: Colors.blue,
//        title: Text("kg"),
//        value: "kg",
//       groupValue: value2 ,
//        onChanged: (val){
//          setState((){
//          value2=val.toString();
//         });
//        }),

//        RadioListTile(
//          activeColor: Colors.blue,
//        title: Text("ibs"),
//        value: "ibs",
//       groupValue: value2 ,
//        onChanged: (val){
//          setState((){
//          value2=val.toString();
//         });
//        }
//        ),

//  ],
//               ),
