import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexTitle extends StatelessWidget {
  const IndexTitle({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 20, 0, 0),
      child: Text(title,
          style: TextStyle(
            fontSize: 48.sp,
            color: Color(0xFF333333),
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
