import 'package:flutter/material.dart';
import 'screen_one.dart';
import 'screen_two.dart';
import 'screen_three.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late Animation<double> slideAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1200));

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeIn));

    slideAnimation = Tween<double>(begin: 100, end: 0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOut));

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color1,
    required Color color2,
    required VoidCallback onTap,
  }) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Opacity(
          opacity: fadeAnimation.value,
          child: Transform.translate(
            offset: Offset(0, slideAnimation.value),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color1, color2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: color1.withOpacity(0.4),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: Colors.white, size: 30),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          Text(
                            subtitle,
                            style: TextStyle(
                                color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios,
                        color: Colors.white, size: 18)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildHeader() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Opacity(
          opacity: fadeAnimation.value,
          child: Transform.translate(
            offset: Offset(0, slideAnimation.value - 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Animation Hub",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Explore smooth and modern animations",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildProfile() {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.deepPurple,
          child: Icon(Icons.person, color: Colors.white),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            "Welcome Back",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        Icon(Icons.notifications_none, size: 28)
      ],
    );
  }

  Widget buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFEDE7F6),
            Color(0xFFFFFFFF),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget buildBottomBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.home, color: Colors.deepPurple),
          Icon(Icons.animation, color: Colors.grey),
          Icon(Icons.settings, color: Colors.grey),
        ],
      ),
    );
  }

  Widget buildBody() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(20),
        children: [
          buildHeader(),
          SizedBox(height: 30),
          buildCard(
            title: "Animated Container",
            subtitle: "Smooth size and shape transitions",
            icon: Icons.crop_square,
            color1: Color(0xFF6C63FF),
            color2: Color(0xFF9C89FF),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ScreenOne()));
            },
          ),
          buildCard(
            title: "Animated Opacity",
            subtitle: "Fade in and fade out effects",
            icon: Icons.blur_on,
            color1: Color(0xFF00C9A7),
            color2: Color(0xFF92FE9D),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ScreenTwo()));
            },
          ),
          buildCard(
            title: "Animation Controller",
            subtitle: "Advanced custom animations",
            icon: Icons.auto_awesome,
            color1: Color(0xFFFF6A88),
            color2: Color(0xFFFF99AC),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ScreenThree()));
            },
          ),
          SizedBox(height: 100),
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
                Padding(
                  padding: EdgeInsets.all(20),
                  child: buildProfile(),
                ),
                buildBody(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: buildBottomBar(),
          )
        ],
      ),
    );
  }
}