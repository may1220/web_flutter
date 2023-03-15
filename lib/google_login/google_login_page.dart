import 'package:flutter/material.dart';
import 'package:testing_app/google_login/button_widget.dart';
import 'package:testing_app/google_login/text_widget.dart';

class GoogleLoginPage extends StatelessWidget {
  const GoogleLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/Illustration 1.png",
              filterQuality: FilterQuality.high,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(left: 35, right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: "Welcome to",
                  fontSize: 22.0,
                  color: Colors.black54,
                ),
                SizedBox(
                  height: 10,
                ),
                TextWidget(
                  text: "Dribbox",
                  fontSize: 38.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 15,
                ),
                TextWidget(
                  text:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Congue bibendum pellentesque mauris, nibh senectus dignissim euismod diam. Sed arcu eget et, id arcu ultricies scelerisque nisl.",
                ),
                SizedBox(
                  height: 20,
                ),
                TextWidget(text: "Join for free"),
                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 1,
                        child: ButtonWidget(
                            text: "Smart id", icon: "assets/fingerscan.png")),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: ButtonWidget(
                        text: "Smart id",
                        icon: "assets/Vector.png",
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Center(
                  child: TextWidget(text: "Use social login"),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/instagram.png"),
                    SizedBox(
                      width: 20,
                    ),
                    Image.asset("assets/facebook.png"),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: TextWidget(
                    text: "Create an account",
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
