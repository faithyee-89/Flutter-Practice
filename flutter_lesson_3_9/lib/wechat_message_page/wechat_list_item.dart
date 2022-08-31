import 'package:flutter/material.dart';
import 'package:flutter_lesson_3_9/wechat_message_page/wechat_user_model.dart';

class UserListItem extends StatelessWidget {
  UserListItem({
    Key? key,
    required this.userData,
  }) : super(key: key);

  Data userData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          _userPicView(),
          SizedBox(width: 5,),
          _itemContent(),
        ],
      ),
    );
  }

  Widget _userPicView() {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: userData.users!.first.profileImageUrl!.contains('http')
                ? Image.network(
                    userData.users!.first.profileImageUrl!,
                    width: 50,
                    height: 50,
                  )
                : Image.asset(
                    userData.users!.first.profileImageUrl!,
                    width: 50,
                    height: 50,
                  ),
          ),
        ),
        userData.badge == null ? Container() : _badge(),
      ],
    );
  }

  Widget _badge() {
    return Positioned(
        right: 0,
        top: 0,
        child: Container(
          alignment: Alignment.center,
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            color: Colors.red,
          ),
          child: Text(
            userData.badge!.text!,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ));
  }

  Widget _itemContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              userData.screenName!,
              style: TextStyle(fontSize : 16),
            ),
            Text(
              userData.createdAt!,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Text(
          userData.text!,
          maxLines: 1,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ]),
    );
  }
}
