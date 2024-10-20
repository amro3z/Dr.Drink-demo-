import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SingleVisibleItemList extends StatefulWidget {
  final String title;
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
  final Color backgroundColor;
  final Color textColor;
  final Color notactivedotcolor;

  const SingleVisibleItemList({
    super.key,
    required this.title,
    required this.description,
    required this.description_1,
    required this.description_2,
    required this.description_3,
    required this.description_4,
    required this.description_5,
    required this.description_6,
    required this.description_7,
    required this.backgroundColor,
    required this.textColor,
    required this.notactivedotcolor,
    required this.title_1,
    required this.title_2,
    required this.title_3,
    required this.title_4,
    required this.title_5,
    required this.title_6,
    required this.title_7,
  });

  @override
  _SingleVisibleItemListState createState() => _SingleVisibleItemListState();
}

class _SingleVisibleItemListState extends State<SingleVisibleItemList> {
  PageController _pageController = PageController();
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageListener);
  }

  void _pageListener() {
    setState(() {
      _currentPage = _pageController.page!; // Update the current page position
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget buildItem({
    required double opacity,
    required String title,
    required String description,
    String? imagePath,
    double? fontsize = 25,
  }) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 300),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imagePath == null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Image.asset(
                        imagePath,
                        color: widget.textColor,
                        height: 30,
                        width: 30,
                      ),
                    ),
              Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: fontsize,
                  color: widget.textColor,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                description,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  color: widget.textColor,
                  fontFamily: 'Poppins',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget Function(double)> itemBuilders = [
      (opacity) => buildItem(
            opacity: opacity,
            title: widget.title,
            description: widget.description,
            fontsize: 40,
            // Update with your image path
          ),
      (opacity) => buildItem(
            opacity: opacity,
            title: widget.title_1,
            description: widget.description_1,
            imagePath: 'assets/image/1.png', // Update with your image path
          ),
      (opacity) => buildItem(
            opacity: opacity,
            title: widget.title_2,
            description: widget.description_2,
            imagePath: 'assets/image/2.png', // Update with your image path
          ),
      (opacity) => buildItem(
            opacity: opacity,
            title: widget.title_3,
            description: widget.description_3,
            imagePath: 'assets/image/3.png', // Update with your image path
          ),
      (opacity) => buildItem(
            opacity: opacity,
            title: widget.title_4,
            description: widget.description_4,
            imagePath: 'assets/image/4.png', // Update with your image path
          ),
      (opacity) => buildItem(
            opacity: opacity,
            title: widget.title_5,
            description: widget.description_5,
            imagePath: 'assets/image/5.png', // Update with your image path
          ),
      (opacity) => buildItem(
            opacity: opacity,
            title: widget.title_6,
            description: widget.description_6,
            imagePath: 'assets/image/6.png', // Update with your image path
          ),
      (opacity) => buildItem(
          opacity: opacity,
          title: widget.title_7,
          description: widget.description_7,
          imagePath: 'assets/image/7.png',
          fontsize: 0 // Update with your image path
          ),
    ];

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: widget.backgroundColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          backgroundColor: widget.backgroundColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(
            '${widget.title}',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: widget.textColor,
              fontSize: 16,
            ),
          ),
          iconTheme: IconThemeData(
            color: widget.textColor,
          ),
          centerTitle: true,
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: itemBuilders.length,
                  itemBuilder: (context, index) {
                    double pageDifference = (_currentPage - index).abs();
                    double opacity = (1 - pageDifference).clamp(0.0, 1.0);

                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: itemBuilders[index](opacity),
                    );
                  },
                ),
              ),
            ],
          ),
          // Add SmoothPageIndicator at the top right corner
          Positioned(
            right: 16,
            top: 60, // Set the position from the top
            child: SmoothPageIndicator(
              controller: _pageController, // Link the controller
              count: itemBuilders.length,
              axisDirection: Axis.vertical, // Set the axis to vertical
              effect: ExpandingDotsEffect(
                dotHeight: 12,
                dotWidth: 15,
                activeDotColor: widget.textColor,
                dotColor: widget.notactivedotcolor,
                expansionFactor: 3, // Dot expansion factor
                spacing: 12, // Space between dots
              ),
            ),
          ),
        ],
      ),
    );
  }
}
