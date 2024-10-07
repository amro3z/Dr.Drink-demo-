import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecordCard extends StatefulWidget {
  double quantity;
  String time;

  RecordCard({this.quantity = 0.34, this.time = '10:00 AM'});

  @override
  State<RecordCard> createState() => _RecordCardState();
}

class _RecordCardState extends State<RecordCard> {
  String amount = '';
  String? time;

  @override
  void initState() {
    amount = '${widget.quantity} L';
    time = widget.time;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedtime = DateFormat.jm().format(now);
    return Container(
      height: 140,
      width: 90,
      decoration: BoxDecoration(
          color: MyColor.lightblue,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: MyColor.blue.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 1),
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          Image.asset(
            'assets/icons/cup_record.png',
            width: 50,
          ),
          SizedBox(
            height: 10,
          ),
          Opacity(
            opacity: 0.5,
            child: Text(
              amount,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                color: MyColor.blue,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Opacity(
            opacity: 0.3,
            child: Text(
              formattedtime,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: MyColor.blue,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
