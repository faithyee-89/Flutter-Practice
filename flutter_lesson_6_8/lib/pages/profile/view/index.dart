import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cainiaowo/common/authentication/authentication.dart';
import 'package:cainiaowo/common/values/index.dart';
import 'package:cainiaowo/utils/utils_string.dart';
import 'package:cainiaowo/common/application.dart';
import 'package:cainiaowo/common/icons.dart';
import 'package:cainiaowo/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cainiaowo/common/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vant_kit/main.dart';

final cniao5Url = "https://m.cniao5.com";
final List<ItemModel> _listItems = [
  ItemModel(
      icon: CNWFonts.gift_card, title: "学习卡·免费领", url: "$cniao5Url/studycard"),
  ItemModel(
      icon: CNWFonts.red_packet, title: "分销中心", url: "$cniao5Url/distribution"),
  ItemModel(
      icon: CNWFonts.group_booking, title: "我的拼团", url: "$cniao5Url/pintuan"),
  ItemModel(icon: CNWFonts.heart_ed, title: "想学的课", url: "$cniao5Url/course"),
  ItemModel(
      icon: CNWFonts.feedback,
      title: "意见反馈",
      url: "http://cniao555.mikecrm.com/ktbB0ht"),
];

final Map<String, ItemModel> _tabModels = {
  "order": ItemModel(
      icon: CNWFonts.order, title: "我的订单", url: "$cniao5Url/user/order"),
  "coupon": ItemModel(
      icon: CNWFonts.coupon, title: "优惠券", url: "$cniao5Url/user/coupon"),
};

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> slivers = [];
    slivers.add(_header());
    slivers.add(_divider());
    slivers.add(_tabItems(context));
    slivers.add(_divider());
    slivers.add(_list(context));

    return SafeArea(
      child:
          Scaffold(body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            slivers.add(_logoutButton(context));
          }
          return CustomScrollView(slivers: slivers);
        },
      )),
    );
  }

  Widget _header() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        String userName =
            state.user == null ? '登录/免费注册' : state.user?.username ?? "无名";
        return SliverToBoxAdapter(
            child: GestureDetector(
          onTap: state.status != AuthenticationStatus.authenticated
              ? () {
                  Application.router.navigateTo(context, Routes.login);
                }
              : null,
          child: Container(
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: ClipOval(
                  child: Container(
                    color: Color(0x33999999),
                    child: Container(
                      width: 60,
                      height: 60,
                      child: CachedNetworkImage(
                          imageUrl: UtilsString.fixedHttpStart(
                              state.user?.logoUrl ?? defualtHeadImg)),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Text(userName,
                      style: TextStyle(
                        fontSize: AppFontSize.mediumSp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      )))
            ]),
          ),
        ));
      },
    );
  }

  Widget _tabItems(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(flex: 1, child: _myOrder(context)),
        Container(
          height: 85,
          child: VerticalDivider(
            width: 10,
            thickness: 0.5,
            color: Color(0x33999999),
          ),
        ),
        Expanded(flex: 1, child: _coupons(context)),
      ]),
    );
  }

  Widget _myOrder(BuildContext context) {
    return _tabItem(context, _tabModels["order"]!);
  }

  Widget _coupons(BuildContext context) {
    return _tabItem(context, _tabModels["coupon"]!);
  }

  Widget _tabItem(BuildContext context, ItemModel model) {
    return Ink(
      child: InkWell(
        onTap: () {
          String url = model.url;
          print("地址：$url");
          Application.navigateTo(context, Routes.webViewPage,
              params: {"url": model.url});
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              model.icon,
              size: 35,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(model.title,
                    style: TextStyle(
                      fontSize: AppFontSize.normalSp,
                      color: Color(0xff606266),
                    )))
          ],
        ),
      ),
    );
  }

  Widget _list(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (content, index) {
          if (index.isOdd) {
            return Divider(
              height: 1,
              thickness: 0.5,
              color: Color(0xFFEEEEEE),
            );
          } else {
            ItemModel itemModel = _listItems[index ~/ 2];
            return _listCell(context, itemModel);
          }
        },
        childCount: _listItems.length * 2 - 1,
      ),
    );
  }

  Widget _listCell(BuildContext context, ItemModel itemModel) {
    return Ink(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
          onTap: () {
            Application.navigateTo(context, Routes.webViewPage,
                params: {"url": itemModel.url});
          },
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  itemModel.icon,
                  size: 25,
                ),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: Text(itemModel.title,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff303133),
                            )))),
                Icon(
                  CNWFonts.next,
                  size: 20,
                ),
              ])),
    );
  }

  Widget _logoutButton(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: NButton(
          text: "退出登录",
          textColor: AppColors.gray,
          block: true,
          plain: true,
          borderRadius: BorderRadius.circular(100.w),
          onClick: () {
            showDialog(
                context: context,
                builder: (_) {
                  return NDialog(
                      title: "提示",
                      message: "您确定退出登录吗",
                      showCancelButton: true,
                      confirmTextColor: AppColors.white,
                      confirmButtonColor: AppColors.primaryColor,
                      onConfirm: () {
                        context.read<AuthenticationBloc>().add(LogoutEvent());
                      });
                });
          },
        ),
      ),
    );
  }

  Widget _divider() {
    return const SliverToBoxAdapter(
      child: Divider(
        height: 26,
        thickness: 0.5,
        color: Color(0x33999999),
      ),
    );
  }
}

class ItemModel {
  final String title;
  final IconData icon;
  final String url;

  const ItemModel({required this.title, required this.icon, required this.url});
}
