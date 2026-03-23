import 'package:flutter/material.dart';

class ScreenThree extends StatefulWidget {
  @override
  State<ScreenThree> createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<double> rotationAnimation;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    scaleAnimation = Tween<double>(begin: 0.6, end: 1.2).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.1416).animate(
        CurvedAnimation(parent: controller, curve: Curves.linear));

    opacityAnimation = Tween<double>(begin: 0.3, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeIn));

    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFCE4EC),
            Color(0xFFFFFFFF),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget buildTopBar() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
          SizedBox(width: 15),
          Text(
            "Animation Controller",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget buildAnimatedCircle() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Opacity(
          opacity: opacityAnimation.value,
          child: Transform.rotate(
            angle: rotationAnimation.value,
            child: Transform.scale(
              scale: scaleAnimation.value,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFF6A88),
                      Color(0xFFFF99AC),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pinkAccent.withOpacity(0.4),
                      blurRadius: 30,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: Center(
                  child: Icon(Icons.auto_awesome,
                      color: Colors.white, size: 40),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildProgress() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Column(
          children: [
            SizedBox(height: 40),
            Container(
              height: 8,
              width: 220,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment:
                Alignment(-1 + controller.value * 2, 0),
                child: Container(
                  width: 80,
                  height: 8,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFF6A88),
                        Color(0xFFFF99AC),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Text(
              "${(controller.value * 100).toInt()}%",
              style: TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        );
      },
    );
  }

  Widget buildInfoCard() {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.settings, color: Colors.pink),
              SizedBox(width: 10),
              Text(
                "Controller Features",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildTag("Scale"),
              buildTag("Rotate"),
              buildTag("Opacity"),
              buildTag("Loop"),
            ],
          )
        ],
      ),
    );
  }

  Widget buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.pink.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  Widget buildBottomButton() {
    return GestureDetector(
      onTap: () {
        if (controller.isAnimating) {
          controller.stop();
        } else {
          controller.repeat(reverse: true);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFF6A88),
              Color(0xFFFF99AC),
            ],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.4),
              blurRadius: 15,
            )
          ],
        ),
        child: Center(
          child: Text(
            controller.isAnimating ? "Pause Animation" : "Start Animation",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Expanded(
      child: ListView(
        children: [
          SizedBox(height: 30),
          Center(child: buildAnimatedCircle()),
          buildProgress(),
          buildInfoCard(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(),
          SafeArea(
            child: Column(
              children: [
                buildTopBar(),
                buildBody(),
                buildBottomButton(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}