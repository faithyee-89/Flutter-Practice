import 'package:flutter/material.dart';

class IndexTitle extends StatelessWidget {
  const IndexTitle({Key key, @required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
      child: Text(title,
          style: TextStyle(
            fontSize: 21,
            color: Color(0xFF333333),
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
