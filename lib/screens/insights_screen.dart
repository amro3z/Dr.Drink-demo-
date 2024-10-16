import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // استيراد SystemChrome
import 'package:dr_drink/shares/card.dart';

class InsightsPage extends StatelessWidget {
  const InsightsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // تخلي شريط الحالة شفاف
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white, // شريط الحالة شفاف
        statusBarIconBrightness:
            Brightness.dark, // الأيقونات تبقى غامقة عشان الخلفية فاتحة
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(10), // تقدر تتحكم في الارتفاع هنا
        child: AppBar(
          backgroundColor: Colors.white, // الخلفية شفافة
          elevation: 0, // مفيش ظل ولا تأثير
        ),
      ),
      body: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: MyCard(), // الكارت بتاعك
          ),
        ],
      ),
    );
  }
}
