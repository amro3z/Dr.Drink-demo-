import 'package:dr_drink/widgets/weightWidget.dart';
import 'package:flutter/material.dart';

class Wakewidget extends StatefulWidget {
  const Wakewidget({super.key});

  @override
  State<Wakewidget> createState() => _WakewidgetState();
}

class _WakewidgetState extends State<Wakewidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Text("${Weightwidget.selectedWeight}")));
  }
}
