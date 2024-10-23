import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecordCard extends StatefulWidget {
  final int quantity;
  final String time;
  final String unit;

  const RecordCard({super.key,this.quantity = 34, this.time = '10:00 AM', this.unit = 'ml'});

  @override
  State<RecordCard> createState() => _RecordCardState();
}

class _RecordCardState extends State<RecordCard> {
  String amount = '';
  String? time;

  @override
  void initState() {
    amount = widget.unit == 'ml' ? '${widget.quantity} ml' : '${widget.quantity/1000} L';
    time = widget.time;
  }

  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    // String formattedtime = DateFormat.jm().format(now);
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
              offset: const Offset(0, 1),
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            'assets/icons/cup_record.png',
            width: 50,
          ),
          const SizedBox(
            height: 10,
          ),
          Opacity(
            opacity: 0.5,
            child: Text(
              amount,
              style: const TextStyle(
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
              time!,
              style: const TextStyle(
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
