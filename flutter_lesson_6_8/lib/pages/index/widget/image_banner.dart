import 'package:cainiaowo/common/values/index.dart';
import 'package:cainiaowo/utils/utils_string.dart';
import 'package:cainiaowo/models/adbanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_vant_kit/main.dart';

class ImageBanner extends StatelessWidget {
  const ImageBanner({Key? key, required this.banners}) : super(key: key);
  final List<AdBanner> banners;

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenUtil().screenWidth;
    return Container(
      width: screenWidth,
      height: (screenWidth / 1920 * 400) + 30,
      child: Swipe(
        autoPlay: true,
        indicatorColor: AppColors.primaryColor,
        children: _banners(context),
      ),
    );
  }

  List<Widget> _banners(BuildContext context) {
    return banners.map((banner) {
      return InkWell(
        onTap: () {
          // Application.navigateTo(
          //             context, Routes.webViewPage, {"url": banner.redirectUrl});
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10.w),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: UtilsString.fixedHttpStart(banner.imgUrl ?? ""),
            )),
      );
    }).toList();
  }
}
