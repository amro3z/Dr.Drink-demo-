import 'package:dr_drink/screens/reminder.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

String ?value1="";
String ?value2="";

  TextEditingController _goalController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return  SafeArea(
      child: Scaffold(
        backgroundColor:const Color(0xFF0247C8),
        body:  Padding(
          padding: const EdgeInsets.only(top:18 ),
          child: ListView(
            children: [
              const CircleAvatar(
                backgroundColor:Color(0xFF6690DE),
                child:Icon(Icons.person,color:Color(0xFF0247C8),),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Data synchronization ",style:TextStyle(color:Colors.white)),
                  Icon(Icons.arrow_forward_ios_outlined,size:15,color:Colors.white),
                ],
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
                        const Row(
                          children: [
                            Icon(Icons.volume_up_outlined,color:Colors.white),
                            Spacer(flex: 1,),
                            Text("Sounds and vibrations",style:TextStyle(color:Colors.white)),
                            Spacer(flex:25,),
                            Icon(Icons.arrow_forward_ios_outlined,size:15,color:Colors.white),
                            // Spacer(),
                          ],
                        ),
       const SizedBox(height:25 ),
                        GestureDetector(
                          onTap: (){
                           units_dialog(context);
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
  // ignore: non_constant_identifier_names
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
 
  // ignore: non_constant_identifier_names
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
                  