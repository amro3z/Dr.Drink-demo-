import 'package:flutter/material.dart';

class TipDisplay {
  // دالة لعرض النصيحة في BottomSheet
  static void showTipBottomSheet(BuildContext context, String tip) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // عشان يسمح للنصوص الكبيرة بالتمرير
      builder: (context) {
        return GestureDetector(
          onVerticalDragEnd: (_) => Navigator.pop(context),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/image/bot 1.png', width: 50, height: 50),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          tip,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
      isDismissible: true,
    );
  }
}
