import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class ScreenOne extends StatefulWidget {
  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;

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
            Color(0xFFF3E7FF),
            Color(0xFFFFFFFF),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
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
                  "Animated Container",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Tap the box to see transformation",
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
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 700),
        curve: Curves.easeInOut,
        width: isExpanded ? 260 : 130,
        height: isExpanded ? 260 : 130,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isExpanded
                ? [Color(0xFF00C9A7), Color(0xFF92FE9D)]
                : [Color(0xFF6C63FF), Color(0xFF9C89FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(isExpanded ? 40 : 16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: isExpanded ? 25 : 10,
              offset: Offset(0, isExpanded ? 15 : 5),
            )
          ],
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: isExpanded
                ? Icon(Icons.check, key: ValueKey(1), size: 50, color: Colors.white)
                : Icon(Icons.touch_app,
                key: ValueKey(2), size: 40, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 20),
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
              Icon(Icons.animation, color: AppColors.primary),
              SizedBox(width: 10),
              Text(
                "Properties Changing",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildTag("Width"),
              buildTag("Height"),
              buildTag("Color"),
              buildTag("Radius"),
            ],
          )
        ],
      ),
    );
  }

  Widget buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(color: AppColors.primary),
      ),
    );
  }

  Widget buildBottomButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6C63FF), Color(0xFF9C89FF)],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.3),
              blurRadius: 15,
            )
          ],
        ),
        child: Center(
          child: Text(
            isExpanded ? "Shrink Box" : "Expand Box",
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
          SizedBox(height: 40),
        ],
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
            "Screen One",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget buildFloatingEffect() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Positioned(
          top: 100 + slideAnimation.value,
          right: 20,
          child: Opacity(
            opacity: fadeAnimation.value,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF9C89FF)],
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