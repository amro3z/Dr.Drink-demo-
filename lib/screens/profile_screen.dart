import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_drink/screens/reminder_screen.dart';
import 'package:dr_drink/values/color.dart';
import 'package:dr_drink/widgets/soundWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../logic/user.dart';
import 'login_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

Future<void> _saveUserToSharedPrefs(MyUser user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('user', json.encode(user.toMap()));
}

Future<void> _saveUserToFirestore(MyUser user) async {
  try {
    final userCollection = FirebaseFirestore.instance.collection('users');
    String userId = FirebaseAuth.instance.currentUser?.uid ?? 'anonymous';

    await userCollection.doc(userId).set(user.toMap());

    log('User saved to Firestore successfully.');
  } catch (e) {
    log('Failed to save user to Firestore: $e');
  }
}

class _ProfilePageState extends State<ProfilePage> {
  // late VoidCallback toggleTheme;
  final MyUser _user = MyUser.instance;
  String selectedSound = 'Water drop 2';
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
                  accountDialog(context);
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xFF6690DE),
                      backgroundImage: NetworkImage(
                        _user.account.photoURL,
                      ),
                      child: _user.account.photoURL == ''
                          ? const Icon(Icons.person, color: MyColor.blue, size: 35)
                          : null, // Show the photo if it exists, otherwise show the icon
                    ),

                    const SizedBox(height:10 ,),
                    Row(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_user.account.email ?? 'No Email',style:const TextStyle(color:Colors.white ,  fontFamily: 'Poppins')),
                        const Icon(Icons.arrow_forward_ios_outlined,size:15,color:Colors.white),
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
                      child: Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.water_drop,color:Colors.white),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('${_user.profile.totalAmount}',style:TextStyle(color:Colors.white,fontSize:25, fontFamily: 'Poppins')),
                              Text(' ${_user.profile.unit}',style:TextStyle(color:Colors.white ,  fontFamily: 'Poppins')),
                            ],
                          ),
                          Text("Total amount drunk",style:TextStyle(color:Colors.white60 ,  fontFamily: 'Poppins')),
                        ],
                      ),
                    ),
                  ),),
                  Expanded(child:ClipRRect(borderRadius:BorderRadius.circular(50),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin:const EdgeInsets.all(10),
                      color:const Color(0xFF1D5ACE),
                      child: Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.calendar_today_rounded,color:Colors.white),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('${_user.profile.totalDays}',style:TextStyle(color:Colors.white,fontSize:25 , fontFamily: 'Poppins')),
                              Text(" days",style:TextStyle(color:Colors.white ,  fontFamily: 'Poppins')),

                            ],
                          ),
                          Text("Total achievement",style:TextStyle(color:Colors.white60 ,  fontFamily: 'Poppins')),
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
                          behavior: HitTestBehavior.opaque,
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
                            showSoundSettings( context);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: const Row(
                            children: [
                              Icon(Icons.volume_up_outlined,color:Colors.white),
                              Spacer(flex: 1,),
                              Text("Notifications Sound",style:TextStyle(color:Colors.white ,  fontFamily: 'Poppins')),
                              Spacer(flex:25,),
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
                          behavior: HitTestBehavior.opaque,
                          child: const Row(
                            children: [
                              Icon(Icons.brush_outlined,color:Colors.white),
                              Spacer(flex: 1,),
                              Text("Themes",style:TextStyle(color:Colors.white ,  fontFamily: 'Poppins')),
                              Spacer(flex:25,),
                              Icon(Icons.arrow_forward_ios_outlined,size:15,color:Colors.white),
                              // Spacer(),
                            ],
                          ),
                        ),
                        const SizedBox(height:25 ),
                        GestureDetector(
                          onTap: (){
                            showLanguageChanger(context);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: const Row(
                            children: [
                              Icon(Icons.language,color:Colors.white),
                              Spacer(flex: 1,),
                              Text("Language",style:TextStyle(color:Colors.white ,  fontFamily: 'Poppins')),
                              Spacer(flex:25,),
                              Icon(Icons.arrow_forward_ios_outlined,size:15,color:Colors.white),
                              // Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
                            dailyGoal_dialog(context);
                            // Profile.dailyGoal_dialog(context);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Row(
                            children: [
                              Icon(Icons.water_drop,color:Colors.white),
                              Spacer(flex: 1,),
                              Text("Daily goal",style:TextStyle(color:Colors.white ,  fontFamily: 'Poppins')),
                              Spacer(flex:25,),
                              Text('${_user.profile.unit == 'ml' ? _user.tracker.totalWaterGoal : _user.tracker.totalWaterGoal! / 1000}',style:TextStyle(color:Colors.white ,  fontFamily: 'Poppins')),
                              Text(' ${_user.profile.unit}',style:TextStyle(color:Colors.white ,  fontFamily: 'Poppins')),
                              Icon(Icons.arrow_forward_ios_outlined,size:15,color:Colors.white ),
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
                          behavior: HitTestBehavior.opaque,
                          child: const Row(
                            children: [
                              Icon(Icons.local_drink,color:Colors.white),
                              Spacer(flex: 1,),
                              Text("Units ",style:TextStyle(color:Colors.white ,  fontFamily: 'Poppins')),
                              Spacer(flex:25,),
                              Text("ml, L",style:TextStyle(color:Colors.white ,  fontFamily: 'Poppins')),
                              Icon(Icons.arrow_forward_ios_outlined,size:15,color:Colors.white),
                              // Spacer(),
                            ],
                          ),
                        ),
                        const SizedBox(height:25 ),
                        GestureDetector(
                          onTap: (){
                            gender_dialog(context);
                            //  Profile.gender_dialog(context);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: const Row(
                            children: [
                              Icon(Icons.person,color:Colors.white),
                              Spacer(flex: 1,),
                              Text("Gender",style:TextStyle(color:Colors.white ,  fontFamily: 'Poppins')),
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
                          behavior: HitTestBehavior.opaque,
                          child: const Row(
                            children: [
                              Icon(Icons.line_weight_sharp,color:Colors.white),
                              Spacer(flex: 1,),
                              Text("Weight",style:TextStyle(color:Colors.white ,  fontFamily: 'Poppins')),
                              Spacer(flex:25,),
                              Icon(Icons.arrow_forward_ios_outlined,size:15,color:Colors.white),
                              // Spacer(),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void accountDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context)
        {
          return AlertDialog(
            title: const Text('Account' ,  style: TextStyle( fontFamily: 'Poppins'),),
            content: SizedBox(
              width: 70,
              height: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Email Field
                  const Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins'
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextFormField(
                    initialValue: _user.account.email ?? 'No email',
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),


                  const SizedBox(height: 16),

                  // Username Field
                  const Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins'
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextFormField(
                    initialValue: _user.account.userName ?? 'No username',
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Change Password Link
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: _showChangePasswordDialog,
                      child: const Text(
                        'Change Password',
                        style: TextStyle(
                          color: MyColor.blue,
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                            fontFamily: 'Poppins'
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
                  Navigator.pop(context);
                },
                child: const Text('Cancel', style: TextStyle(color: MyColor.blue ,  fontFamily: 'Poppins')),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final googleSignIn = GoogleSignIn();
                    if (await googleSignIn.isSignedIn()) {
                      await googleSignIn.signOut(); // Sign out from Google
                    }
                  } catch (e) {
                    print("Error signing out from Google: $e");
                  }

                  await FirebaseAuth.instance.signOut();
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('isUserRegistered', false);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false,
                  );
                },
                child: const Text('Log Out', style: TextStyle(color: Colors.red ,  fontFamily: 'Poppins')),
              ),
            ],
          );

        }
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Password',style: TextStyle(color:MyColor.blue ,  fontFamily: 'Poppins')),
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
              child: const Text('Cancel',style: TextStyle(color:MyColor.blue ,  fontFamily: 'Poppins')),
            ),
            TextButton(
              onPressed: () {
                // منطق تغيير كلمة المرور هنا
                Navigator.of(context).pop();
              },
              child: const Text('Sumbit',style: TextStyle(color:MyColor.blue ,  fontFamily: 'Poppins'),),
            ),
          ],
        );
      },
    );
  }

  void showSoundSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return const SoundSettingsContent();
      },
    );
  }

  void showThemeChanger(BuildContext context) {
    const List<String> languages = ['Light Theme', 'Dark Theme'];
    const List<Icon> icons = [Icon(Icons.wb_sunny), Icon(Icons.nightlight_round)];

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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18 ,  fontFamily: 'Poppins'),
              ),
              // Loop through the available languages to create the list tiles
              ...languages.map((theme) {
                bool isSelected = _user.profile.theme == theme;

                return ListTile(
                  leading: icons[languages.indexOf(theme)],
                  iconColor: isSelected ? MyColor.blue : Colors.black,
                  title: Text(
                    theme,
                    style: TextStyle(
                      color: isSelected ? MyColor.blue : Colors.black,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontFamily: 'Poppins'
                    ),
                  ),
                  onTap: () {
                    // Update the selected language
                    _user.profile.theme = theme;
                    _saveUserToSharedPrefs(_user);
                    _saveUserToFirestore(_user);
                    Navigator.pop(context); // Close the dialog
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void showLanguageChanger(BuildContext context) {
    const List<String> languages = ['English', 'Arabic'];

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
                'Choose Language',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18 ,  fontFamily: 'Poppins'),
              ),
              // Loop through the available languages to create the list tiles
              ...languages.map((language) {
                bool isSelected = _user.profile.language == language;

                return ListTile(
                  leading: const Icon(Icons.language),
                  iconColor: isSelected ? MyColor.blue : Colors.black,
                  title: Text(
                    language,
                    style: TextStyle(
                      color: isSelected ? MyColor.blue : Colors.black,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,  fontFamily: 'Poppins'
                    ),
                  ),
                  onTap: () {
                    // Update the selected language
                    _user.profile.language = language;
                    _saveUserToSharedPrefs(_user);
                    _saveUserToFirestore(_user);
                    Navigator.pop(context); // Close the dialog
                  },
                );
              }),
            ],
          ),
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
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Accept only digits
                LengthLimitingTextInputFormatter(_user.profile.unit == 'ml'? 4 : 1),    // Limit to 4 digits
              ],
              decoration: InputDecoration(
                hintText: '${_user.profile.unit == 'ml' ? _user.tracker.totalWaterGoal : _user.tracker.totalWaterGoal! / 1000} ${_user.profile.unit}',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // إغلاق المربع
                },
                child: const Text('Cancel',style: TextStyle(color:MyColor.blue ,  fontFamily: 'Poppins')),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_user.profile.unit == 'ml') {
                    if (int.parse(_goalController.text) < 1000) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('The goal cannot be less than 1000 ml' , style: TextStyle( fontFamily: 'Poppins'),),
                        ),
                      );
                      return;
                    }
                  } else {
                    if (int.parse(_goalController.text) < 1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('The goal cannot be less than 1 L' , style: TextStyle( fontFamily: 'Poppins'), ),
                        ),
                      );
                      return;
                    }
                  }
                  // function of save data
                  setState(() {
                    _user.tracker.totalWaterGoal = int.parse(_goalController.text);
                  });
                  _saveUserToSharedPrefs(_user);
                  _saveUserToFirestore(_user);
                  Navigator.pop(context); // إغلاق المربع وحفظ القيمة
                },
                child: const Text('Save',style: TextStyle(color:MyColor.blue ,  fontFamily: 'Poppins'),),
              ),
            ],
          );
        }
    );

  }

  void units_dialog(BuildContext context) {
    // List of available units
    final units = ["ml", "L"];

    // Find the index of the current unit
    int initialIndex = units.indexOf(_user.profile.unit);

    // Create the controller with the initial item
    FixedExtentScrollController controller =
    FixedExtentScrollController(initialItem: initialIndex);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Units' , style: TextStyle( fontFamily: 'Poppins'),),
          content: SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 200,
                  child: ListWheelScrollView(
                    controller: controller,
                    itemExtent: 50,
                    perspective: 0.006,
                    diameterRatio: 0.4,
                    physics: const FixedExtentScrollPhysics(),
                    children: units
                        .map((unit) => Center(child: Text(unit)))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel', style: TextStyle(color: MyColor.blue ,  fontFamily: 'Poppins')),
            ),
            ElevatedButton(
              onPressed: () {
                // Get the current selected index from the controller
                int selectedIndex = controller.selectedItem;

                setState(() {
                  // Update the _user.profile.unit with the selected value
                  _user.profile.unit = units[selectedIndex];
                });

                _saveUserToSharedPrefs(_user);
                _saveUserToFirestore(_user);

                // Close the dialog
                Navigator.pop(context);
              },
              child: const Text('Save', style: TextStyle(color: MyColor.blue ,  fontFamily: 'Poppins')),
            ),
          ],
        );
      },
    );
  }

  void gender_dialog(BuildContext context) {
    // List of genders
    final genders = ["Male", "Female"];

    // Find the index of the current gender
    int initialIndex = genders.indexOf(_user.data.gender!);

    // Create the controller with the initial item
    FixedExtentScrollController controller =
    FixedExtentScrollController(initialItem: initialIndex);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Gender' , style: TextStyle( fontFamily: 'Poppins'),),
          content: SizedBox(
            width: 70,
            height: 200,
            child: ListWheelScrollView(
              controller: controller,
              itemExtent: 50,
              perspective: 0.006,
              diameterRatio: 0.4,
              physics: const FixedExtentScrollPhysics(),
              children: genders
                  .map((gender) => Center(child: Text(gender)))
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel', style: TextStyle(color: MyColor.blue ,  fontFamily: 'Poppins')),
            ),
            ElevatedButton(
              onPressed: () {
                // Get the current selected index from the controller
                int selectedIndex = controller.selectedItem;

                // Update _user.gender with the selected value
                _user.data.gender = genders[selectedIndex];

                log(_user.toMap().toString());

                _saveUserToSharedPrefs(_user);
                _saveUserToFirestore(_user);

                // Close the dialog
                Navigator.pop(context);
              },
              child: const Text('Save', style: TextStyle(color: MyColor.blue ,  fontFamily: 'Poppins')),
            ),
          ],
        );
      },
    );
  }

  void weight_dialog(BuildContext context) {
    // Initialize the range for weight (from 40 to 200)
    const int minWeight = 40;
    const int maxWeight = 200;

    // Calculate the initial index based on the current weight
    int initialIndex = _user.data.weight! - minWeight;

    // Create the controller with the initial index
    FixedExtentScrollController controller =
    FixedExtentScrollController(initialItem: initialIndex);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Weight' ,  style: TextStyle( fontFamily: 'Poppins'),),
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
                    controller: controller,
                    itemExtent: 50,
                    perspective: 0.005,
                    diameterRatio: 0.4,
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: maxWeight - minWeight + 1,
                      builder: (context, index) {
                        return Center(
                          child: Text(
                            (minWeight + index).toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 70,
                  height: 200,
                  child: Center(child: Text("kg", style: TextStyle(fontSize: 18 , fontFamily: 'Poppins'))),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel', style: TextStyle(color: MyColor.blue ,  fontFamily: 'Poppins')),
            ),
            ElevatedButton(
              onPressed: () {
                // Get the selected weight from the controller
                int selectedWeight = minWeight + controller.selectedItem;

                // Update _user.weight with the selected value
                _user.data.weight = selectedWeight;

                log(_user.toMap().toString());

                _saveUserToSharedPrefs(_user);
                _saveUserToFirestore(_user);

                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Save', style: TextStyle(color: MyColor.blue ,  fontFamily: 'Poppins')),
            ),
          ],
        );
      },
    );
  }

}