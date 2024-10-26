import 'package:dr_drink/screens/insights_data.dart';
import 'package:dr_drink/values/color.dart';
import 'package:flutter/material.dart';

class InsightsCard extends StatelessWidget {
  InsightsCard({
    super.key,
    required this.backcolor,
    required this.cardcolor,
    required this.text,
    required this.path,
    required this.textcolor,
    required this.description,
    required this.description_1,
    required this.description_2,
    required this.description_3,
    required this.description_4,
    required this.description_5,
    required this.description_6,
    required this.title_1,
    required this.title_2,
    required this.title_3,
    required this.title_4,
    required this.title_5,
    required this.title_6,
    required this.title_7,
    required this.description_7,
    this.width = 50,
    this.height = 50,
    this.bottom = 75,
    this.left = 0,
    this.right = 0,
    this.top = 0,
  });
  final Color backcolor;
  final Color cardcolor;
  final Color textcolor;
  final String text;
  final String title_1;
  final String title_2;
  final String title_3;
  final String title_4;
  final String title_5;
  final String title_6;
  final String title_7;
  final String description;
  final String description_1;
  final String description_2;
  final String description_3;
  final String description_4;
  final String description_5;
  final String description_6;
  final String description_7;
  final String path;
  double width;
  double height;
  double top;
  double bottom;
  double left;
  double right;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SingleVisibleItemList(
            title: text,
            backgroundColor: cardcolor,
            textColor: textcolor,
            notactivedotcolor: backcolor,
            description: description,
            description_1: description_1,
            description_2: description_2,
            description_3: description_3,
            description_4: description_4,
            description_5: description_5,
            description_6: description_6,
            description_7: description_7,
            title_1: title_1,
            title_2: title_2,
            title_3: title_3,
            title_4: title_4,
            title_5: title_5,
            title_6: title_6,
            title_7: title_7,
          ),
        ));
      },
      child: Stack(
        clipBehavior:
            Clip.none, // يسمح للمستطيل الصغير بالخروج خارج حدود المستطيل الكبير
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: backcolor,
            ),
            height: screenHeight * 0.45,
            width: screenWidth * 0.43,
          ),

          Positioned(
            top: top, // الصورة تبدأ من أعلى البطاقة
            left: left,
            bottom: bottom, // ترك مساحة للنص أسفل الصورة
            right: right,
            child: Image(
              image: AssetImage(path),
              width: screenWidth * 0.1,
              height: screenHeight * 0.2,
              fit: BoxFit.contain, // لضمان أن الصورة مناسبة للحجم
            ),
          ),
          // المستطيل الصغير موضوع تحت المستطيل الكبير بالكامل
          Positioned(
            bottom: 0, // هنا نتحكم في ظهور جزء من المستطيل أسفل المستطيل الكبير
            left: 0,
            right: 0,
            child: Container(
              padding:  EdgeInsets.only( left :screenHeight *0.01 ),
              height: screenHeight * 0.08, // تحديد ارتفاع ثابت للمستطيل الصغير
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: cardcolor,
              ),
              child: Center(
                child: Text(
                  text,
                  maxLines: 3, // تحديد أقصى عدد للأسطر
                  overflow: TextOverflow
                      .ellipsis, // إضافة نقاط في حالة تجاوز النص المساحة
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: textcolor,
                    fontSize: screenWidth * 0.038,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.3,
      width: screenWidth,
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
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        titleBuiled(text: 'Water Drinking', context),
        ListCard(
          categoryCard: [
            InsightsCard(
              bottom: screenHeight * 0.032,
              backcolor: MyColor.frow,
              cardcolor: MyColor.fcrow,
              path: "assets/image/avoid_mistake.png",
              text: 'Avoid These Water Drinking Mistakes',
              textcolor: MyColor.fnrow,
              description:
                  "Did you know that even when you drink water, you can make some mistakes to affect your health? \n \nLet's explore the most common water-drinking mistakes and how you can avoid them.",
              title_1: "Not Drinking Enough Water",
              description_1:
                  "Dehydration can lead to a range of health problems, including headaches, fatigue, and constipation. \n \nYour specific water needs may vary depending on many factors. Therefore, you can use our app to get your personal daily intake target and reminders to help you stay hydrated.",
              title_2: "Drink Too Much Water",
              description_2:
                  "Over-hydration can lead to hyponatremia, a condition where your body has too much water and not enough sodium. This is dangerous for athletes and people with heart or kidney problems. \n \nSymptoms of hyponatremia include nausea, headache, confusion, seizures, and even coma in severe cases",
              title_3: "Not Drinking Clean Water",
              description_3:
                  "Make sure that the water you're drinking is clean and free from harmful contaminants. If you're unsure about the quality of your tap water, consider using a water filter or purchasing bottled water.",
              title_4: "Drink Too Quickly",
              description_4:
                  "When you drink water too quickly, it can lead to bloating, discomfort, and even nausea. Also, your body doesn't have enough time to absorb the water properly, so you may find yourself having to use the restroom frequently.",
              title_5: "Drink Cold Water",
              description_5:
                  "Cold water can cause blood vessels to constrict, which can slow down digestion and reduce blood flow to organs. Additionally, drinking very cold water may cause headaches or migraines in some people.",
              title_6: "Skip Water Before Bed",
              description_6:
                  "Your body is still performing important functions such as repairing tissues and removing toxins. \n \nBesides, not drinking enough water before bed can lead to dehydration, which can cause headaches, dry mouth, and even impact your quality of sleep.",
              title_7: "Conclusion",
              description_7:
                  "In conclusion, drinking water is an important part of a healthy lifestyle, but it is important to avoid common water drinking mistakes. \n \nBy paying attention to the right amount, timing, and quality of your water, you can ensure that you are staying hydrated and protecting your health.",
            ),
            InsightsCard(
              bottom: screenHeight * 0.0001,
              top: screenHeight * 0.0015,
              backcolor: MyColor.frow,
              cardcolor: MyColor.fcrow,
              path: "assets/image/drinking_water.png",
              text: 'Best Times to Drink Water',
              textcolor: MyColor.fnrow,
              description:
                  "We all know that drinking enough water is important, but did you know that timing can be just as important as the amount? \n \nHere are some optimal times to drink water throughout the day.",
              title_1: "After Waking Up",
              description_1:
                  "Drinking water in the morning can help kickstart your metabolism, hydrate your body after a night of sleep, and flush out toxins. \n \nAim for a glass of water before eating or drinking anything else in the morning.2",
              title_2: 'Before Meals',
              description_2:
                  "Drinking water before meals can help you feel fuller and prevent overeating. It can also aid in digestion by preparing your stomach for food. \n \nIt is recommended to drink water 30 minutes before each meal.",
              title_3: "After Meals",
              description_3:
                  "Drinking water after meals can help with digestion and prevent constipation. \n \nHowever, it's important to wait at least 30 minutes after eating before drinking water to allow your stomach to properly digest the food.",
              title_4: 'Before and During Exercise',
              description_4:
                  "Drinking water before and during exercise can help prevent dehydration, which can lead to fatigue and muscle cramps. \n \nAim for drinking enough water 2 to 3 hours before exercising and every 10 to 20 minutes during exercise.",
              title_5: 'Before Bed',
              description_5:
                  "Drinking water before bed can help with overall hydration, but it's important to drink in moderation to prevent frequent trips to the bathroom during the night. \n \nAim for a small glass of water an hour or so before bed.",
              title_6: "General Time",
              description_6:
                  "Drinking water at specific times throughout the day can help with digestion, metabolism, hydration, and overall health. \n \nMake sure to drink enough water each day to meet your body's needs and always listen to your body's signals for thirst.",
              title_7: "Conclusion",
              description_7:
                  "Drinking water at the right times improves health by aiding digestion, boosting metabolism, and maintaining hydration. Start the day with water to rehydrate after sleep. Drinking before meals helps with fullness and digestion. Hydrating during exercise prevents fatigue. A small glass before bed ensures hydration without disrupting sleep.",
            ),
            InsightsCard(
              bottom: screenHeight * 0.001,
              top: screenHeight * 0.025,
              backcolor: MyColor.frow,
              cardcolor: MyColor.fcrow,
              path: "assets/image/replacing.png",
              text: 'Replacing Beverages with Water for Health',
              textcolor: MyColor.fnrow,
              description:
                  "It's time to stop indulging in those sugary drinks and start drinking water. \n \nGet ready for the 7 benefits of drinking water instead of sugary beverages below.",
              title_1: "Weight Loss",
              description_1:
                  "Water has zero calories. Stop drinking sugary or high-calorie beverages like soda or sweetened drinks can significantly reduce your calorie intake. \n \nThis can help create a calorie deficit, which is necessary for weight loss, and can also help prevent weight gain.",
              title_2: "Improved Digestion and Nutrient Absorption",
              description_2:
                  "Water is useful to keep the lining of the digestive tract healthy and promotes regular bowel movements, preventing constipation. \n \nAlso, drinking water with meals can dilute stomach acids and make it easier for the body to break down and absorb nutrients from food.",
              title_3: "Better Skin Health",
              description_3:
                  "When you are dehydrated, your skin can become dry and flaky, and it can contribute to skin issues like acne and eczema. \n \nReplacing sugary beverages with water can flush out toxins from the body that can contribute to skin issues, and maintain the elasticity and suppleness of your skin.",
              title_4: "Improved Brain Function",
              description_4:
                  "Dehydration can lead to fatigue, mood changes, and difficulty concentrating, all of which can have a negative impact on cognitive function. \n \nStaying hydrated with water can help prevent dehydration and improve overall cognitive function.",
              title_5: "Improved Kidney Function",
              description_5:
                  "When you drink water, it helps your kidney to flush out waste products through your urine. \n \nBy replacing sugary drinks or other beverages with water, you can help your body better regulate its natural detoxification process, promoting overall health and wellbeing.",
              title_6: "Improved Heart Function",
              description_6:
                  "Drinking more water instead of sugary beverages is associated with a lower risk of heart disease and a reduction in blood pressure. \n \nIt may also improve blood flow and increase the elasticity of blood vessels, both of which are important for heart health.",
              title_7: "Conclusion",
              description_7:
                  "In conclusion, replacing sugary or high-calorie beverages with water is a simple but powerful way to improve your overall health and well-being. By doing so, you can enjoy numerous benefits.",
            ),
            InsightsCard(
              bottom: screenHeight * 0.001,
              top: screenHeight * 0.03,
              backcolor: MyColor.frow,
              cardcolor: MyColor.fcrow,
              path: "assets/image/rb_13254.png",
              text: 'Drink Water on an Empty Stomach ?',
              textcolor: MyColor.fnrow,
              description:
                  "Have you ever wondered if there are any benefits to drinking water on an empty stomach? \n \nNo worries. The benefits and drawbacks of doing that and tips for optimal hydration are all included here. Let's check them out.",
              title_1: "Aid Digestion",
              description_1:
                  "By stimulating digestive enzymes, drinking water on an empty stomach improves digestion and nutrient absorption. This can also help alleviate constipation.",
              title_2: "Boost Metabolism",
              description_2:
                  "It can boost metabolism by increasing the body's energy expenditure, bettering your weight loss and overall health.",
              title_3: "Improve Skin Health",
              description_3:
                  "Doing it helps flush out toxins and impurities from the body, which brings you clearer, brighter skin.",
              title_4: "Enhance Brain Function",
              description_4:
                  "Drinking water on an empty stomach can help ensure that the brain is well hydrated and enhance cognitive performance.",
              title_5: "Note the Drawbacks!",
              description_5:
                  "However, drinking water on an empty stomach can cause symptoms like bloating and nausea. \n \nDoing it can also interfere with the medications you are taking.",
              title_6: "Conclusion",
              description_6:
                  "Drinking water on an empty stomach is beneficial, like promoting hydration, boosting metabolism, etc. However, it also has some drawbacks to consider.",
              title_7: "Advise",
              description_7:
                  "If you have any concerns or questions about drinking water on an empty stomach, it's always best to check with your doctor.",
            ),
          ],
        ),
        titleBuiled(text: 'Beauty & Skincare', context),
        ListCard(
          categoryCard: [
            InsightsCard(
              bottom: screenHeight * 0.02,
              backcolor: MyColor.srow,
              cardcolor: MyColor.scrow,
              path: "assets/image/drinking water-cuate.png",
              text: 'Benefits of Drinking \nWater for Skin',
              textcolor: MyColor.snrow,
              description:
                  "Our skin is the largest organ in our body and is mostly made up of water, so it's no surprise that staying hydrated has a significant impact on skin health. \n \nRead on to know some benefits of drinking water for healthy skin.",
              title_1: 'Hydrate the Skin',
              description_1:
                  "Drinking water helps to keep your skin hydrated and moisturized, which can make it look plump and healthy.",
              title_2: 'Improve Skin Elasticity',
              description_2:
                  "Water helps to improve the elasticity of your skin, which can reduce the appearance of fine lines and wrinkles.",
              title_3: 'Reduce Acne and Blemishes',
              description_3:
                  "Dehydration can cause our body to produce more oil, which can lead to acne and other skin blemishes. \n \nDrinking enough water helps to flush out toxins and reduce inflammation, leading to clearer and healthier skin.",
              title_4: 'Promote Even Skin Tone',
              description_4:
                  "Drinking water helps to flush out toxins and impurities from the skin, which can lead to a more even skin tone and texture.",
              title_5: 'Promote Skin Cell Regeneration',
              description_5:
                  "Water is essential for the process of cell regeneration, which can help to keep your skin looking youthful and healthy.",
              title_6: 'Reduce Puffins',
              description_6:
                  "Staying hydrated helps to reduce water retention and reduce puffiness and swelling around the eyes and other areas of the face.",
              title_7: 'Conclusion',
              description_7:
                  'In addition to drinking water, you can also hydrate your skin by using a moisturizer and eating a healthy diet. Fruits and vegetables are rich in vitamins and minerals that can help to nourish your skin.',
            ),
            InsightsCard(
              bottom: screenHeight * 0.05,
              backcolor: MyColor.srow,
              cardcolor: MyColor.scrow,
              path: "assets/image/drinking water-amico.png",
              text: 'Drinking Schedule for Wrinkle-Free Skin',
              textcolor: MyColor.snrow,
              description:
                  "To maximize the benefits of drinking water for your skin, it is essential to follow a proper drinking schedule. \n \nHere are some tips to help you get started:",
              title_1: 'Start Your Day With a Glass of Water',
              description_1:
                  "Before eating breakfast, start your day with a glass of water. This will help to hydrate your body and get your skin off to a good start for the day.",
              title_2: 'Drink Water Before and After Meals',
              description_2:
                  "Drinking water before a meal can keep you full and prevent overeating. It also helps improve digestion, which is important for skin health. \n \nDrinking water after meals helps you flush out toxins and keep your skin hydrated. Aim to drink at least one glass of water after each meal.",
              title_3: 'Drink Water During and After Exercise',
              description_3:
                  "When you exercise, your body loses water through sweat, and it's important to replenish these fluids to keep your skin hydrated and prevent wrinkles.",
              title_4: 'Drink Water Throughout the Day',
              description_4:
                  "It's important to listen to your body and drink water whenever you feel thirsty to maintain optimal hydration levels. Keep a water bottle with you at all times to help you stay on track.",
              title_5: 'Drink Water Before Bed',
              description_5:
                  "It helps you to hydrate your body while you sleep. This is important for skin health, as skin cells regenerate and repair themselves while you sleep.",
              title_6:
                  'Limit Your Intake of Beverages \nThat Can Dehydrate Your Skin',
              description_6:
                  "Certain drinks, such as alcohol and caffeinated beverages, can dehydrate your skin and lead to the development of wrinkles. Limit your intake of these beverages and make sure to drink water in between.",
              title_7: 'Conclusion',
              description_7:
                  'Drinking water is essential for achieving wrinkle-free skin. By following a consistent drinking water schedule, you can help your skin stay hydrated, supple, and youthful-looking.',
            ),
            InsightsCard(
              bottom: screenHeight * 0.05,
              backcolor: MyColor.srow,
              cardcolor: MyColor.scrow,
              path: "assets/image/cherry drink-amico.png",
              text: 'Miracle Juices for Glowing Skin',
              textcolor: MyColor.snrow,
              description:
                  "Juices are a great way to pack in nutrients that help enhance skin health and promote a natural glow. \n \nHere are some of the best juices for healthy, radiant, and glowing skin:",
              description_1:
                  "Carrots are loaded with vitamin A, which is essential for skin health. Vitamin A helps to reduce inflammation, promote skin cell turnover, and improve skin texture. \n \nCarrot juice also contains antioxidants that can protect the skin from environmental damage.",
              description_2:
                  "Beetroot is a great source of antioxidants, vitamins, and minerals, including vitamin C, which is important for collagen production. Collagen is a protein that gives skin its elasticity and helps to prevent wrinkles and sagging.",
              description_3:
                  "Pomegranate is rich in antioxidants, including Vitamin C and polyphenols, that help protect the skin from UV damage, pollution, and other environmental stressors. \n \nPomegranate juice also contains ellagic acid, which helps prevent collagen breakdown and slows down the aging process.",
              description_4:
                  "Aloe vera is well-known for its skin-healing properties. Aloe vera juice contains vitamins, minerals, and antioxidants that can help to soothe inflammation, promote skin repair, and improve skin elasticity.",
              description_5:
                  "Lemons are a rich source of Vitamin C, a potent antioxidant that helps promote collagen production, brighten the skin, and even out skin tone. \n \nLemon juice also has astringent properties that help tighten pores, reduce excess oil production, and prevent acne.",
              description_6:
                  "Green juices are packed with nutrients, including vitamins A, C, and E, which are essential for skin health. Green juices also contain chlorophyll, which can help to detoxify the skin and improve its overall health.",
              title_1: 'Carrot Juice',
              title_2: 'Beetroot Juice',
              title_3: 'Pomegranate Juice',
              title_4: 'Aloe Vera Juice',
              title_5: 'Lemon Juice',
              title_6: 'Green Juice',
              title_7: 'Conclusion',
              description_7:
                  'While these nutrient-packed juices are beneficial for the skin, they are not a substitute for a healthy and balanced diet. \n \nIncorporate these juices into your daily routine and pair them with a balanced diet and an effective skincare routine to achieve the healthy, glowing skin you deserve.',
            ),
            InsightsCard(
              bottom: screenHeight * 0.015,
              backcolor: MyColor.srow,
              cardcolor: MyColor.scrow,
              path: "assets/image/hot_water.png",
              text: 'Hot and Cold Water Benefits for Skin',
              textcolor: MyColor.snrow,
              description:
                  "Drinking water and using hot and cold water on your skin can both improve the appearance and health of your skin. \n \nHowever, different water temperatures can yield different benefits. Read on to know their unique benefits.",
              description_1:
                  "Cold water is known to help reduce inflammation, puffiness, and redness in the skin. \n \nIt can also help to shrink the appearance of pores, tighten the skin and soothe and calm irritated skin, especially in those who suffer from eczema or rosacea.",
              description_2:
                  "Hot water can help to relax and soothe sore muscles, and open up the pores, making it easier to remove impurities and toxins from the skin. \n \nThis can be particularly beneficial for those who suffer from stress-related skin conditions like acne, psoriasis, and eczema.",
              description_3:
                  "Combining cold water and hot water can yield some extra benefits. \n \nRinsing your face with cold water can help tighten and minimize pores. It can also soothe inflammation and redness, suitable for those with sensitive skin. \n \nSimilarly, warm water can open up pores and remove impurities from the skin.",
              description_4:
                  "Alternating between hot and cold water can help to improve blood circulation in the skin. Hot water can help to increase blood flow to the skin, while cold water can help to reduce inflammation and puffiness.",
              description_5:
                  "Cold water can help to tighten the skin and reduce the appearance of fine lines and wrinkles. Hot water, on the other hand, can increase blood flow and improve the elasticity of the skin.",
              description_6:
                  "Both hot and cold water can be relaxing and help to reduce stress levels. Hot water can help to soothe sore muscles and promote relaxation, while cold water can help to invigorate and energize the body.",
              title_1: 'Benefits of Cold Water',
              title_2: 'Benefits of Hot Water',
              title_3: 'Pore Tightening',
              title_4: 'Blood Circulation',
              title_5: 'Increased Skin Elasticity',
              title_6: 'Relaxation',
              title_7: 'Conclusion',
              description_7:
                  'In conclusion, drinking water and using hot and cold water on your skin can provide a variety of benefits. \n \nHowever, it\'s important to be mindful of the temperature of the water you\'re using and to avoid extremes that could potentially harm your skin.',
            ),
          ],
        ),
        SizedBox(
          height: screenHeight * 0.002,
        ),
        titleBuiled(text: 'Self-care', context),
        ListCard(
          categoryCard: [
            InsightsCard(
              backcolor: MyColor.trow,
              cardcolor: MyColor.tcrow,
              bottom: screenHeight * 0.001,
              top: screenHeight * 0.033,
              path: "assets/image/Insomnia-pana.png",
              text: 'Bedtime Drinks for Better Sleep',
              textcolor: MyColor.tnrow,
              description:
                  "Are you tired of tossing and turning all night, struggling to get a good night's rest? You're not alone. \n \nFortunately, we'll explore some of the most effective and delicious drinks to help you get the restful night's sleep you deserve.",
              description_1:
                  "Chamomile contains apigenin, an antioxidant that binds to certain receptors in the brain, reducing anxiety and promoting sleepiness.",
              description_2:
                  "Milk contains tryptophan, an amino acid that helps the body produce melatonin, a hormone that regulates sleep-wake cycles. \n \nIn addition, milk is a good source of calcium, which promotes the brain to use tryptophan to produce melatonin, giving you a better night's sleep.",
              description_3:
                  "Tart cherries are a natural source of melatonin, a hormone that regulates sleep-wake cycles. \n \nDrinking it before bed can help increase melatonin levels, leading to better sleep.",
              description_4:
                  "Coconut water is a natural source of magnesium, a mineral that can help relax the body and improve sleep quality. \n n\It also contains potassium, which can help regulate blood pressure and promote muscle relaxation.",
              description_5:
                  "Nutmeg contains a natural sedative called myristicin, which can help calm your mind and reduce anxiety. \n \nTo make nutmeg tea, simply simmer a cup of water with a pinch of nutmeg for about 10 minutes.",
              description_6:
                  "The tea contains potassium and magnesium, which are natural muscle relaxants, and the amino acid tryptophan, which is known to induce sleep. \n \nTo make banana tea, simply cut off the ends of a ripe banana and put it in boiling water for 10 minutes.",
              title_1: 'Chamomile Tea',
              title_2: 'Warm Milk',
              title_3: 'Tart Cherry Juice',
              title_4: 'Cocount Water',
              title_5: 'Nutmeg Tea',
              title_6: 'Banana Tea',
              title_7: 'Conclusion',
              description_7:
                  'Incorporating these drinks into your bedtime routine can help promote relaxation, reduce anxiety, and improve sleep quality. \n \nIf you are experiencing persistent sleep problems, it\'s always best to consult with a healthcare professional.',
            ),
            InsightsCard(
              backcolor: MyColor.trow,
              cardcolor: MyColor.tcrow,
              bottom: screenHeight * 0.055,
              path: "assets/image/Mulled wine-amico.png",
              text: 'Impact of Alcohol on Your Body',
              textcolor: MyColor.tnrow,
              description:
                  "Drinking alcohol can be enjoyable, but have you ever considered how alcohol is affecting your body? \n \nReading this article, you can take a closer look at the impact of alcohol, so you can make informed decisions about your drinking habits and overall health.",
              description_1:
                  "• Slurred speech \n \n• Impaired judgment and coordination \n \n• Nausea and vomiting \n \n• Reduced inhibitions \n \n• Memory loss or blackouts",
              description_2:
                  "The long-term effects of alcohol consumption can be serious and life-threatening. \n \nYour liver is responsible for breaking down and filtering alcohol from your bloodstream, but excessive drinking can lead to liver damage, such as cirrhosis.",
              description_3:
                  "Heavy alcohol consumption can increase the risk of certain types of cancer, including breast, liver, and colon cancer.",
              description_4:
                  "Long-term alcohol consumption can increase the risk of high blood pressure, stroke, and other cardiovascular problems.",
              description_5:
                  "Alcohol consumption can lead to disrupted sleep patterns, waking up frequently during the night, and feeling groggy or tired in the morning.",
              description_6:
                  "Alcohol can reduce the body's ability to produce white blood cells, which are essential for fighting off infections. \n \nExcessive drinking can cause inflammation throughout the body, which can lead to a weakened immune system over time.",
              title_1: 'Short-term Effects of Alcohol',
              title_2: 'Liver Damage',
              title_3: 'Increased Cancer Risk',
              title_4: 'Caediovascular Disease',
              title_5: 'Poor Sleep',
              title_6: 'Weakened Immune System',
              title_7: 'Conclusion',
              description_7:
                  'Alcohol consumption can have both short-term and long-term effects on the body, and excessive drinking can lead to numerous health problems. \n \nYou need to be mindful of your alcohol consumption and talk to your doctor if you have concerns about your drinking habits.',
            ),
            InsightsCard(
              backcolor: MyColor.trow,
              cardcolor: MyColor.tcrow,
              bottom: screenHeight * 0.033,
              path: "assets/image/Drinking tea-pana.png",
              text: 'Herbal Teas for better\nMental Health',
              textcolor: MyColor.tnrow,
              description:
                  "When you try to find medicines to support your mental health, don't forget natural remedies. The best herbal teas for better mental health are here for you to feel calm and centered no matter what life throws your way.",
              description_1:
                  "Chamomile contains compounds that bind to the same brain receptors as Valium, which helps calm the nervous system and promote sleep. \n \nSuggested intake: Use 1 tablespoon of dried chamomile flowers (2g) per cup of water, and drink 1-2 cups daily. Avoid it if you have severe allergies, take blood thinners, are pregnant, or an infant/a young child.",
              description_2:
                  "It is known for its soothing properties and is often used to treat anxiety, depression, and insomnia. The aroma of lavender can help promote relaxation, reduce stress, and improve mood. \n \nSuggested intake: Use 2 teaspoons of dried lavender flowers (about 1.5 grams) per cup of water, and drink 1-2 cups per day, ideally before bedtime.",
              description_3:
                  "Lemon balm is a member of the mint family and is known for its soothing properties. It can reduce stress levels and improve cognitive function, making it a great choice to improve mental health. \n \nSuggested intake: Use 1 tablespoon of dried lemon balm leaves (about 2 grams) per cup of water, and drink 1-3 cups per day, in the morning or afternoon.",
              description_4:
                  "Passionflower is a plant that is often used to promote relaxation, reduce anxiety, and improve sleep quality. You can make it by steeping dried passionflower leaves and flowers in hot water. \n \nSuggested intake: Use 1 tablespoon of dried passionflower (about 2 grams) per cup of water, and drink 1 cup per day, preferably in the evening.",
              description_5:
                  "Green tea is known for its calming effects and can help reduce anxiety and improve cognitive function. \n \nSuggested intake: Use 1 teaspoon of green tea leaves (about 2 grams) per cup of water, and drink 2-3 cups per day, preferably in the morning or early afternoon. Drinking more than 6-8 cups daily is not advised.",
              description_6:
                  "Rose tea is known for its calming and mood-enhancing properties. It can help reduce anxiety and stress, improve mood, and promote relaxation. \n \nSuggested intake: For fresh petals, boil 2 cups with 3 cups (700 ml) of water for 5 minutes, then strain. For dried petals, steep 1 tablespoon per cup in boiling water for 10-20 minutes. You may check brand guidelines for details.",
              title_1: 'Chamomile Tea',
              title_2: 'Lavender Tea',
              title_3: 'Lemon Balm Tea',
              title_4: 'Passionflower Tea',
              title_5: 'Green Tea',
              title_6: 'Rose Tea',
              title_7: 'Conclusion',
              description_7:
                  'Herbal teas can be a great way to support your mental health and promote relaxation. Chamomile, lavender, etc. are all great options to consider. \n \nSo why not brew up a cup of tea and take a moment to unwind?',
            ),
            InsightsCard(
              bottom: screenHeight * 0.05,
              backcolor: MyColor.trow,
              cardcolor: MyColor.tcrow,
              path: "assets/image/Hydratation-amico.png",
              text: 'Stop Anxiety by Drinking Water',
              textcolor: MyColor.tnrow,
              description:
                  "Stress and anxiety are common problems that many people face. A simple yet effective way to calm yourself is drinking water. \n \nRead on to let water calm your mind and reduce your stress.",
              description_1:
                  "• It can worsen anxiety symptoms and increase feelings of tension and fatigue. \n \n• It affects body and brain, causing changes in mood, cognition, and overall functioning. \n \n• When dehydrated, body releases stress hormones, which exacerbate anxiety symptoms such as heart palpitations and rapid breathing.",
              description_2:
                  "Cortisol is a hormone that is released in response to stress. When we are dehydrated, cortisol levels rise, making us more prone to stress and anxiety. \n \nDrinking water can help regulate it, leading to a decrease in stress and anxiety.",
              description_3:
                  "Even mild dehydration can cause irritability, fatigue, and poor concentration. \n \nBy staying hydrated, we can keep our mood stable and avoid unnecessary stress.",
              description_4:
                  "When sleep quality becomes better, in turn, stress levels reduce. \n \nWhen we are well-hydrated, we are less likely to experience common sleep disturbances like snoring and sleep apnea.",
              description_5:
                  "Drinking water can also be a mindful practice, helping us stay present and calm at the moment. \n \nWe are taking the time to be fully present and aware of the sensation of drinking water, rather than mindlessly consuming it. \n \nThis kind of practice can provide a sense of relaxation and help reduce stress.",
              description_6:
                  "In what ways can maintaining proper hydration and approaching water consumption as a mindful activity help improve overall well-being and promote a sense of relaxation throughout the day?",
              title_1: 'The Link Between Dehydration and Anxiety',
              title_2: 'Rugulate Cortisol Levels',
              title_3: 'Improve Mood',
              title_4: 'Better Sleep',
              title_5: 'Provide Mindful Hydration',
              title_6: 'Question',
              title_7: 'Conclusion',
              description_7:
                  'By staying hydrated and making water a mindful activity, you can improve your overall well-being and feel more relaxed throughout the day. ',
            ),
          ],
        ),
        SizedBox(
          height: screenHeight * 0.002,
        ),
        titleBuiled(text: 'Healthy Lifestyle', context),
        ListCard(
          categoryCard: [
            InsightsCard(
              backcolor: MyColor.forow,
              cardcolor: MyColor.focrow,
              bottom: screenHeight * 0.025,
              path: "assets/image/Hydratation-cuate.png",
              text: 'Top Fat-Burning Drinks for Weight Loss',
              textcolor: MyColor.fonrow,
              description:
                  "Losing weight is a challenging process itself. Make it easier and more pleasant with some enjoyable drinks! \n \nHere are some of the best fat-burning drinks that you can incorporate into your weight loss journey:",
              description_1:
                  "Green tea is loaded with antioxidants to boost metabolism and help burn fat. The polyphenols in green tea help increase fat oxidation, which can aid in weight loss. \n \It also contains caffeine, which can help boost energy levels and improve exercise performance.",
              description_2:
                  "Coffee contains caffeine. Caffeine has been found to increase metabolism and fat oxidation, which can help with fat burning. \n \nHowever, make sure to avoid adding sugar or cream to your coffee, as these can add extra calories.",
              description_3:
                  "Apple cider vinegar can reduce your appetite and promote your feelings of fullness. It can also help with fat burning and improve insulin sensitivity.",
              description_4:
                  "Lemons are rich in vitamin C, which helps to boost the immune system and support healthy digestion. \n \nAdditionally, lemon water can help detoxify the liver and promote hydration, which is essential for maintaining a healthy metabolism.",
              description_5:
                  "Drinking ginger tea can help reduce appetite and aid in weight loss efforts. \n \nIt may assist in fat burning by boosting metabolism and increasing energy expenditure.",
              description_6:
                  "Cumin and cinnamon have been found to have beneficial effects on weight loss and metabolism. \ \nSimply add a teaspoon of cumin and a teaspoon of cinnamon to boiling water, let it steep for 5 minutes, and enjoy.",
              title_1: 'Green Tea',
              title_2: 'Cofee',
              title_3: 'Apple Cider Vinegar',
              title_4: 'Lemon Water',
              title_5: 'Ginger Tea',
              title_6: 'Cumin & Cinnamon Water',
              title_7: 'Conclusion',
              description_7:
                  'Incorporating these fat-burning drinks into your daily diet can be a great way to boost your metabolism and support your weight loss goals. \n \nHowever, remember that these drinks are not magic solutions and should be consumed as part of a balanced diet and active lifestyle.',
            ),
            InsightsCard(
              backcolor: MyColor.forow,
              cardcolor: MyColor.focrow,
              bottom: screenHeight * 0.038,
              path: "assets/image/Hot beverage-pana.png",
              text: 'What to Drink During Fasting ?',
              textcolor: MyColor.fonrow,
              description:
                  "Fasting is popular and proved to have numerous benefits in recent years. You may wonder what you can drink to stay hydrated and reduce hunger pangs during fasting. \n \nHere's a guide",
              description_1:
                  "Water is the best drink to have during a fast, as it doesn't contain any calories or affect insulin levels. \n \nDrinking enough water can also help to reduce hunger pangs and prevent overeating when breaking the fast.",
              description_2:
                  "It can reduce hunger and boost energy levels. Caffeine has been shown to increase metabolic rate and mobilize fat for fuel, which can be especially helpful during longer fasts. \n \nHowever, be careful not to add any sweeteners or milk, as they can break your fast.",
              description_3:
                  "Herbal teas, such as peppermint, ginger, and chamomile, can be soothing and relaxing during fasting. \n \They can also help to reduce inflammation, aid digestion, and promote relaxation.",
              description_4:
                  "It is believed to contain low calories, help detoxify the liver, aid digestion, and boost the immune system. The citric acid in it is also said to have alkalizing properties, which balance the body's pH levels. \n \nHowever, please consume it in moderation as too much acidity can have negative effects.",
              description_5:
                  "Apple cider vinegar has been shown to help regulate blood sugar levels and improve insulin sensitivity. It's also low in calories and won't break your fast. \n \nMix one tablespoon of apple cider vinegar with water and drink it during your fast.",
              description_6:
                  "Cumin and cinnamon water are often recommended drinks during fasting due to their health benefits. Cumin aids digestion and helps reduce bloating, which can be helpful after long hours without food. Cinnamon water, rich in antioxidants, can help regulate blood sugar levels and provide a refreshing boost during fasting.",
              title_1: 'Water',
              title_2: 'Black Cofee',
              title_3: 'Herbal Tea',
              title_4: 'Lemon Water',
              title_5: 'Apple Cider Vinger',
              title_6: 'Cumin & Cinnamon Water',
              title_7: 'Conclusion',
              description_7:
                  'In conclusion, there are several options for what to drink during fasting, and each has its own unique benefits. \n \nRemember to listen to your body and choose the beverages that work best for you.',
            ),
            InsightsCard(
              backcolor: MyColor.forow,
              cardcolor: MyColor.focrow,
              bottom: screenHeight * 0.007,
              path: "assets/image/Stretching exercises-rafiki.png",
              text: 'Drink Water to Lose Weight: How To',
              textcolor: MyColor.fonrow,
              description:
                  "Do you ever know that drinking water can help with your weight loss? \n \nIt's true, and there're some more useful tips for you to dig deeper into and get the best out of it for losing weight.",
              description_1:
                  "Drinking a glass of water as soon as you wake up helps to kickstart your metabolism and prepares your body for the day ahead.",
              description_2:
                  "Use our app as your water intake amount calculator and a smart reminder each day. Staying hydrated helps to keep you feeling full and prevents overeating.",
              description_3:
                  "Drinking 16 ounces of water 30 minutes before meals can help reduce hunger and prevent overeating. \n \nIt can also help you feel fuller and reduce calorie intake.",
              description_4:
                  "Sugary drinks like soda and juice are high in calories and can contribute to weight gain. \n \By replacing these drinks with water, you can save hundreds of calories each day.",
              description_5:
                  "Sometimes people mistake thirst for hunger, leading them to eat unnecessarily. \n \nIf you're feeling hungry, try drinking a glass of water first to help you feel fuller and reduce calorie intake. \n \nIf you're still hungry, have a healthy snack or meal.",
              description_6:
                  "Staying hydrated during exercise is crucial for performance and recovery. \n \nMake sure to drink water before, during, and after your workout.",
              title_1: 'Start Your Day With Water',
              title_2: 'Stay Hydrated Throughout the Day',
              title_3: 'Drink Water Before Meals',
              title_4: 'Replace Sugary Drinks with Water',
              title_5: 'Drink When Feeling Hungry',
              title_6: 'Stay Hydrated Throughout Your Workout',
              title_7: 'Conclusion',
              description_7:
                  'By following these simple tips, you can help support your weight loss efforts and improve your overall health. \n \nRemember that drinking water is just one piece of the puzzle, and it should be combined with a healthy diet and regular exercise for the best results.',
            ),
            InsightsCard(
              backcolor: MyColor.forow,
              cardcolor: MyColor.focrow,
              bottom: screenHeight * 0.003,
              path: "assets/image/Breathing exercise-rafiki.png",
              text: 'Benefits of Hydration for Exercise',
              textcolor: MyColor.fonrow,
              description:
                  "Have you ever noticed that people often carry a bottle of water with them during their workout? \n \nRead on to know more about the benefits proper hydration can bring to your workout.",
              description_1:
                  "Dehydration can lead to fatigue, cramps, and decreased endurance, which can all impact athletic performance. \n \nAdequate hydration helps the body regulate temperature and maintain electrolyte balance, which are both critical for optimal performance.",
              description_2:
                  "When you're dehydrated, your muscles and joints become more prone to injury. \n \nWater helps lubricate your joints, keeps your muscles working optimally, and regulates your body temperature, preventing heat exhaustion or heat stroke.",
              description_3:
                  "When your body is dehydrated, it is more difficult to regulate body temperature, which can lead to heat exhaustion or even heatstroke. \n \nStaying hydrated helps regulate body temperature and reduces the risk of heat-related illnesses.",
              description_4:
                  "Water helps transport nutrients to cells and remove waste products, which is essential for recovery after exercise. \n \Staying hydrated after exercise can help reduce soreness and speed up recovery time.",
              description_5:
                  "Dehydration can lead to decreased cognitive performance, which can impact decision making and reaction time. \n \Staying hydrated can help maintain cognitive function and keep athletes focused during exercise.",
              description_6:
                  "The optimal fluid intake during exercise depends on various factors, including your body weight, workout intensity, and duration. \n \nYou can use our app to estimate how much you need to drink to compensate for the water you lost after exercise.",
              title_1: 'Increase Athletic Performance',
              title_2: 'Reduce Risk of Injury',
              title_3: 'Reduce Risk of Hrat Lllness',
              title_4: 'Improve Recovery',
              title_5: 'Improve Congnitive Function',
              title_6: 'Optimal Fluid Intake',
              title_7: '',
              description_7:
                  'Proper hydration is essential for anyone who is physically active. To stay hydrated during exercise, it is important to drink plenty of water, replace electrolytes, monitor urine color, etc. \n \nBy following these simple steps, you can stay hydrated and optimize your exercise routine.',
            ),
          ],
        ),
        SizedBox(
          height: screenHeight * 0.005,
        ),
      ],
    );
  }
}

Widget titleBuiled(
  BuildContext context, {
  required String text,
}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  return Padding(
    padding: EdgeInsets.only(
        bottom: screenHeight * 0.007,
        top: screenHeight * 0.02,
        left: screenHeight * 0.01),
    child: Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: screenWidth * 0.045,
          fontFamily: "Poppins"),
    ),
  );
}
