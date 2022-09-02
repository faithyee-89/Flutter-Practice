import 'package:flutter/material.dart';

class FriendsItem extends StatelessWidget {
  // 网络图片
  final String? imageUrl;
  // 昵称
  final String? name;
  // 组头标题
  final String? groupTitle;
  // 本地图片地址
  final String? imageAssets;

  const FriendsItem({
    Key? key,
    this.name,
    this.groupTitle,
    this.imageUrl,
    this.imageAssets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 30),
          height: groupTitle != null ? 30 : 0,
          color: const Color.fromRGBO(220, 220, 220, 1),
          child: groupTitle != null
              ? Text(
                  groupTitle!,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                )
              : null,
        ),
        Container(
          color: Colors.white,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(image: getImage()),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      height: 53.5,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        name!,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: const Color.fromRGBO(220, 220, 220, 1),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  ImageProvider getImage() {
    if (imageUrl == null) {
      return AssetImage(imageAssets!);
    }
    return NetworkImage(imageUrl!);
  }
}
