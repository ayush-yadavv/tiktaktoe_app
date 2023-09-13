import 'package:flutter/material.dart';
import 'package:tik_tak_toe/TikTacToeGame.dart';

void main() {
  runApp(MainScreen());
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedNumber = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "TikTacToe",
              style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
          ),
          elevation: 20,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: (selectedNumber != 0)
              ? IconButton(
            onPressed: () {
              if (selectedNumber >= 1) {
                setState(() {
                  selectedNumber = 0;
                });
              }
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.teal,
              size: 30,
            ),
          )
              : Container(),
        ),
        body: (selectedNumber == 0)
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose option',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildOption(1, 'Images/Circle.png'),
                  SizedBox(width: 20),
                  buildOption(2, 'Images/Cross.png'),
                ],
              ),
              SizedBox(height: 80),
            ],
          ),
        )
            : TikTacToeGame(type: selectedNumber),
      ),
    );
  }

  Widget buildOption(int number, String imageAsset) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedNumber = number;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.27,
        height: MediaQuery.of(context).size.width * 0.27,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: (number == 1) ? Colors.red : Colors.black,
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Image.asset(imageAsset),
      ),
    );
  }
}
