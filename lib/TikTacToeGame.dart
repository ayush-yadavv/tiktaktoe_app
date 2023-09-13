import 'dart:math';

import 'package:flutter/material.dart';

class TikTacToeGame extends StatefulWidget {
  final int type;

  TikTacToeGame({required this.type});

  @override
  _TikTacToeGameState createState() => _TikTacToeGameState();
}

class _TikTacToeGameState extends State<TikTacToeGame> {
  late int myType;
  late List<int> selectedArray;
  late bool finalResult;
  late List<String> selectedTexture;
  late List<int> positionArray;
  late int chance;
  late Random rng;

  @override
  void initState() {
    super.initState();
    myType = widget.type;
    selectedArray = List.filled(9, 0);
    finalResult = false;
    selectedTexture = List.filled(9, 'Random.png');
    positionArray = List.generate(9, (index) => index);
    chance = 0;
    rng = Random();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: finalResult
          ? Center(
        child: Text(
          winText(),
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: 70,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSelectedColumn(0),
              buildSelectedColumn(1),
              buildSelectedColumn(2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSelectedColumn(3),
              buildSelectedColumn(4),
              buildSelectedColumn(5),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSelectedColumn(6),
              buildSelectedColumn(7),
              buildSelectedColumn(8),
            ],
          ),
        ],
      ),
    );
  }

  String winText() {
    if (myType == 1) {
      return "You Win!";
    } else {
      return "Opponent Wins";
    }
  }

  Widget buildSelectedColumn(int texture) {
    return InkWell(
      onTap: () {
        if (selectedArray[texture] == 1) {
          return;
        } else {
          selectedTexture[texture] = retrieveTexture(computer: false);
          selectedArray[texture] = 1;
          positionArray.remove(texture);

          chance++;
          print("Chance: " + chance.toString());
          print(positionArray);
          computerPlay();
          setState(() {});
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.27,
          height: MediaQuery.of(context).size.width * 0.27,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.teal, spreadRadius: 1, blurRadius: 5),
            ],
          ),
          child: selectedArray[texture] == 1
              ? Image.asset(selectedTexture[texture])
              : Container(),
        ),
      ),
    );
  }

  void computerPlay() {
    if (chance < 9) {
      int a = computerAI();
      selectedTexture[positionArray[a]] = retrieveTexture(computer: true);
      selectedArray[positionArray[a]] = 1;
      positionArray.remove(positionArray[a]);
      chance++;
      print("Comp:" +
          positionArray.toString() +
          "   ,Chance:" +
          chance.toString());
      setState(() {});
    }
  }

  int computerAI() {
    // Implement your computer AI logic here.
    // This function should return the index of the position to play.
    return rng.nextInt(positionArray.length);
  }

  String retrieveTexture({required bool computer}) {
    if (computer == false) {
      if (myType == 1) {
        return 'Images/Circle.png';
      } else {
        return 'Images/Cross.png';
      }
    } else {
      if (myType == 1) {
        return 'Images/Cross.png';
      } else {
        return 'Images/Circle.png';
      }
    }
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TikTacToeGame(type: 1), // Set the type for player 1 or 2.
  ));
}
