import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _number = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('计数器'),
      ),
      body: _viewBody(),
    );
  }

  Widget _viewBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: () {
                print(_number);
                setState(() {
                  _number--;
                });
              },
              child: Text('计数器-1'),
              color: Colors.blue,
            ),
            Text(_number.toString()),
            MaterialButton(
              onPressed: () {
                setState(() {
                  _number++;
                });
                print(_number);
              },
              child: Text('计数器+1'),
              color: Colors.blue,
            ),
          ],
        )
      ],
    );
  }
}
