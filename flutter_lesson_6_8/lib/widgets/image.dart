import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cainiaowo/utils/utils_string.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  String url;
  final double? width;
  final double? height;
  final BoxFit? fit;

  double marginLeft;
  double marginRight;
  double marginTop;
  double marginBottom;
  double cornerRadius;
  final double margin;
  final double borderWidth;
  final Color borderColor;
  final bool isCircle;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  ImageView(this.url,
      {this.width,
      this.height,
      this.marginBottom = 0,
      this.marginRight = 0,
      this.marginTop = 0,
      this.marginLeft = 0,
      this.margin = 0,
      this.cornerRadius = 0,
      this.isCircle = false,
      this.borderColor = Colors.transparent,
      this.borderWidth = 0,
      this.backgroundColor = Colors.transparent,
      this.onPressed,
      this.fit}) {
    if (margin > 0) {
      marginLeft = margin;
      marginTop = margin;
      marginRight = margin;
      marginBottom = margin;
    }

    if (isCircle) {
      cornerRadius = width ?? 0 / 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(this.marginLeft, this.marginTop,
            this.marginRight, this.marginBottom),
        decoration: new BoxDecoration(
          border:
              new Border.all(width: this.borderWidth, color: this.borderColor),
          color: this.backgroundColor,
          borderRadius:
              new BorderRadius.all(new Radius.circular(this.cornerRadius)),
        ),
        child: GestureDetector(
          onTap: this.onPressed ?? () => {},
          child: ClipRRect(
              borderRadius: BorderRadius.circular(this.cornerRadius),
              child: getImage()),
        ));
  }

  Widget getImage() {
    if (this.url == "") return Container();

    this.url = UtilsString.fixedHttpStart(url);
    return CachedNetworkImage(
      imageUrl: url,
      width: this.width,
      height: this.height,
      fit: this.fit,
    );
    //   if (url.startsWith("http")) {
    //     //网络图片
    //     return CachedNetworkImage(
    //       imageUrl: url,
    //       width: this.width,
    //       height: this.height,
    //       fit: this.fit,
    //     );
    //   } else if (url.startsWith("images")) {
    //     //项目内图片
    //     print("加载项目图片:${url}");
    //     return Image.asset(url,
    //         width: this.width,
    //         height: this.height,
    //         fit: this.fit);
    //   } else {
    //     //加载手机里面的图片
    //     return Image.file(File(url),
    //         width: this.width,
    //         height: this.height,
    //         fit: this.fit);
    //   }
    // }
  }
}
