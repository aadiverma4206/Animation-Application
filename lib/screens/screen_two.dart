import 'package:flutter/material.dart';

class ScreenTwo extends StatefulWidget {
  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo>
    with SingleTickerProviderStateMixin {
  bool visible = true;

  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late Animation<double> slideAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900));

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeIn));

    slideAnimation = Tween<double>(begin: 80, end: 0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOut));

    controller.forward();
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
            Color(0xFFE3F2FD),
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
            "Animated Opacity",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget buildHeader() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Opacity(
          opacity: fadeAnimation.value,
          child: Transform.translate(
            offset: Offset(0, slideAnimation.value),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fade Animation",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Tap to show and hide smoothly",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildAnimatedBox() {
    return GestureDetector(
      onTap: () {
        setState(() {
          visible = !visible;
        });
      },
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          width: visible ? 220 : 140,
          height: visible ? 220 : 140,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF2196F3),
                Color(0xFF6EC6FF),
              ],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                blurRadius: 25,
                offset: Offset(0, 10),
              )
            ],
          ),
          child: Center(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              child: visible
                  ? Icon(Icons.visibility,
                  key: ValueKey(1), color: Colors.white, size: 50)
                  : Icon(Icons.visibility_off,
                  key: ValueKey(2), color: Colors.white, size: 50),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
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
              Icon(Icons.opacity, color: Colors.blue),
              SizedBox(width: 10),
              Text(
                "Opacity Features",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildTag("Fade In"),
              buildTag("Fade Out"),
              buildTag("Smooth"),
              buildTag("Responsive"),
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
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  Widget buildBottomButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          visible = !visible;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2196F3),
              Color(0xFF6EC6FF),
            ],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 15,
            )
          ],
        ),
        child: Center(
          child: Text(
            visible ? "Hide Box" : "Show Box",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(20),
        children: [
          buildHeader(),
          SizedBox(height: 40),
          Center(child: buildAnimatedBox()),
          buildInfoCard(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildFloatingEffect() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Positioned(
          top: 120 + slideAnimation.value,
          left: 20,
          child: Opacity(
            opacity: fadeAnimation.value,
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2196F3),
                    Color(0xFF6EC6FF),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(),
          buildFloatingEffect(),
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