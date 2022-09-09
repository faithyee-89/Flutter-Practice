import 'package:flutter/material.dart';
import 'package:flutter_lesson_5_2/flex_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlexCarPage(
            backView: Card(
              color: Colors.white,
              elevation: 2,
              child: Container(
                alignment: Alignment.center,
                height: 70,
                width: 250,
                child: Text(
                  '猫咪：要需要出去玩！！！',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            frontView: SizedBox(
              height: 180,
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                    'http://pic1.win4000.com/wallpaper/2018-12-07/5c0a0d5496d70.jpg'),
              ),
            )),
      ),
    );
  }
}
