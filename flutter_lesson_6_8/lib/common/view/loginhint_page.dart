import 'package:cainiaowo/common/application.dart';
import 'package:cainiaowo/common/values/index.dart';
import 'package:cainiaowo/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vant_kit/main.dart';

class LoginHintPage extends StatelessWidget {
  const LoginHintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '您还未登陆，请先登录！',
          style: TextStyle(
            fontSize: AppFontSize.normalSp,
            color: AppColors.regularTextColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: NButton(
            text: "去登录",
            block: true,
            height: 100.h,
            width: 800.w,
            borderRadius: BorderRadius.circular(100.w),
            color: AppColors.primaryColor,
            onClick: () {
              Application.router.navigateTo(context, Routes.login);
            },
          ),
        )
      ],
    );
  }
}
