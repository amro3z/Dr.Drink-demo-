import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';

class InsightsCard extends StatelessWidget {
  const InsightsCard(
      {super.key,
      required this.backcolor,
      required this.cardcolor,
      required this.text,
      required this.path});
  final Color backcolor;
  final Color cardcolor;
  final String text;
  final String path;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior:
          Clip.none, // يسمح للمستطيل الصغير بالخروج خارج حدود المستطيل الكبير
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backcolor,
          ),
          height: 200,
          width: 150,
        ),
        // وضع الصورة في منتصف المستطيل الكبير
        Positioned(
          top: 0, // الصورة تبدأ من أعلى البطاقة
          left: 0,
          bottom: 65, // ترك مساحة للنص أسفل الصورة
          right: 0,
          child: Image(
            image: AssetImage(path),
            width: 50,
            height: 50,
            fit: BoxFit.contain, // لضمان أن الصورة مناسبة للحجم
          ),
        ),
        // المستطيل الصغير موضوع تحت المستطيل الكبير بالكامل
        Positioned(
          bottom: 35, // هنا نتحكم في ظهور جزء من المستطيل أسفل المستطيل الكبير
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: cardcolor,
            ),
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class ListCard extends StatefulWidget {
  const ListCard({super.key, required this.categoryCard});
  final List<InsightsCard> categoryCard;

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // الاتجاه الأفقي
        itemCount: widget.categoryCard.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0), // مسافة بسيطة بين الكروت
            child: widget.categoryCard[index],
          );
        },
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 15, left: 10),
          child: Text(
            'Water Drinking',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: "Poppins"),
          ),
        ),
        ListCard(
          categoryCard: [
            InsightsCard(
              backcolor: MyColor.frow,
              cardcolor: MyColor.fcrow,
              path: "assets/image/skincare.png",
              text: 'Best Times To Drink Water',
            ),
            InsightsCard(
              backcolor: MyColor.frow,
              cardcolor: MyColor.fcrow,
              path: "assets/image/skincare.png",
              text: 'Replacing Beverages with Water for Health',
            ),
            InsightsCard(
              backcolor: MyColor.frow,
              cardcolor: MyColor.fcrow,
              path: "assets/image/skincare.png",
              text: 'Drink Water on an Empty Stomach?',
            ),
            InsightsCard(
              backcolor: MyColor.frow,
              cardcolor: MyColor.fcrow,
              path: "assets/image/skincare.png",
              text: 'Avoid These Water Drinking Mistakes',
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15, top: 5, left: 10),
          child: Text(
            'Self-care',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: "Poppins"),
          ),
        ),
        ListCard(
          categoryCard: [
            InsightsCard(
              backcolor: MyColor.srow,
              cardcolor: MyColor.scrow,
              path: "assets/image/skincare.png",
              text: 'Benefits of Drinking Water for Skin',
            ),
            InsightsCard(
              backcolor: MyColor.srow,
              cardcolor: MyColor.scrow,
              path: "assets/image/skincare.png",
              text: 'Drinking Schedule for Wrinkle-Free Skin',
            ),
            InsightsCard(
              backcolor: MyColor.srow,
              cardcolor: MyColor.scrow,
              path: "assets/image/skincare.png",
              text: 'Miracle Juices for Glowing Skin',
            ),
            InsightsCard(
              backcolor: MyColor.srow,
              cardcolor: MyColor.scrow,
              path: "assets/image/skincare.png",
              text: 'Hot and Cold Water Benefits for Skin',
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15, top: 5, left: 10),
          child: Text(
            'Beauty & Skincare',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: "Poppins"),
          ),
        ),
        ListCard(
          categoryCard: [
            InsightsCard(
              backcolor: MyColor.trow,
              cardcolor: MyColor.tcrow,
              path: "assets/image/skincare.png",
              text: 'Herbal Teas for Better Mental Health',
            ),
            InsightsCard(
              backcolor: MyColor.trow,
              cardcolor: MyColor.tcrow,
              path: "assets/image/skincare.png",
              text: 'Miracle Juices for Glowing Skin',
            ),
            InsightsCard(
              backcolor: MyColor.trow,
              cardcolor: MyColor.tcrow,
              path: "assets/image/skincare.png",
              text: 'Benfits of Hydration for Exercise',
            ),
            InsightsCard(
              backcolor: MyColor.trow,
              cardcolor: MyColor.tcrow,
              path: "assets/image/skincare.png",
              text: 'Hot Water Benefits for skin',
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15, top: 5, left: 10),
          child: Text(
            'Water Drinking',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: "Poppins"),
          ),
        ),
        ListCard(
          categoryCard: [
            InsightsCard(
              backcolor: MyColor.forow,
              cardcolor: MyColor.focrow,
              path: "assets/image/skincare.png",
              text: 'Drink Milk Before Bed to Relieve Stress',
            ),
            InsightsCard(
              backcolor: MyColor.forow,
              cardcolor: MyColor.focrow,
              path: "assets/image/skincare.png",
              text: 'Stop Anxiety by Drinking Water',
            ),
            InsightsCard(
              backcolor: MyColor.forow,
              cardcolor: MyColor.focrow,
              path: "assets/image/skincare.png",
              text: 'Replacing Beverages with Water for Health',
            ),
            InsightsCard(
              backcolor: MyColor.forow,
              cardcolor: MyColor.focrow,
              path: "assets/image/skincare.png",
              text: 'Drink Water on an Empty Stomach?',
            ),
          ],
        ),
      ],
    );
  }
}
