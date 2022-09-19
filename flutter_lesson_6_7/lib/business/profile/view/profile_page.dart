import 'package:cainiaowo/business/authentication/authentication_repository/authentication_repository.dart';
import 'package:cainiaowo/business/authentication/bloc/authentication_bloc.dart';
import 'package:cainiaowo/business/common/utils_string.dart';
import 'package:cainiaowo/business/login/login.dart';
import 'package:cainiaowo/common/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final List _listItems = [
  {
    'icon': CNWFonts.gift_card,
    'title': '学习卡·免费领',
  },
  {
    'icon': CNWFonts.red_packet,
    'title': '分销中心',
  },
  {
    'icon': CNWFonts.group_booking,
    'title': '我的拼团',
  },
  {
    'icon': CNWFonts.heart_ed,
    'title': '想学的课',
  },
  {
    'icon': CNWFonts.feedback,
    'title': '意见反馈',
  },
];

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> slivers = [];
    slivers.add(_header());
    slivers.add(
      SliverToBoxAdapter(
        child: Divider(
          height: 26,
          thickness: 0.5,
          color: Color(0x33999999),
        ),
      ),
    );
    slivers.add(_tabItems());
    slivers.add(
      SliverToBoxAdapter(
        child: Divider(
          height: 26,
          thickness: 0.5,
          color: Color(0x33999999),
        ),
      ),
    );
    slivers.add(_list());
    slivers.add(_logoutBtn(context));
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
        slivers: slivers,
      )),
    );
  }

  Widget _header() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return SliverToBoxAdapter(
            child: GestureDetector(
          onTap: state.status != AuthenticationStatus.authenticated
              ? () {
                  Navigator.of(context).push(LoginPage.route());
                }
              : null,
          child: Container(
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: ClipOval(
                  child: Container(
                    color: Color(0x33999999),
                    child: state.user.logo != null
                        ? Image.network(UtilsString.fixedHttpStart(state.user.logo) ?? '',
                            width: 60, height: 60)
                        : Container(width: 60, height: 60),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Text(state.user.username ?? '昵称',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff303133),
                      )))
            ]),
          ),
        ));
      },
    );
  }

  Widget _tabItems() {
    return SliverToBoxAdapter(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(flex: 1, child: _myOrder()),
        Container(
          height: 85,
          child: VerticalDivider(
            width: 10,
            thickness: 0.5,
            color: Color(0x33999999),
          ),
        ),
        Expanded(flex: 1, child: _coupons()),
      ]),
    );
  }

  Widget _myOrder() {
    return _tabItem(CNWFonts.order, '我的订单');
  }

  Widget _coupons() {
    return _tabItem(CNWFonts.coupon, '优惠券');
  }

  Widget _tabItem(IconData font, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          font,
          size: 35,
        ),
        Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(title,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xff606266),
                )))
      ],
    );
  }

  Widget _list() {
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
            Map map = _listItems[index ~/ 2];
            return _listCell(map['icon'], map['title']);
          }
        },
        childCount: _listItems.length * 2 - 1,
      ),
    );
  }

  Widget _listCell(IconData font, String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              font,
              size: 25,
            ),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 13),
                    child: Text(title,
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff303133),
                        )))),
            Icon(
              CNWFonts.next,
              size: 20,
            ),
          ]),
    );
  }

  Widget _logoutBtn(BuildContext context) {
    return SliverToBoxAdapter(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return state.status != AuthenticationStatus.authenticated
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(left: 13, top: 50, right: 13),
                child: FlatButton(
                  onPressed: () {
                    // 退出登陆
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogoutRequested());
                  },
                  child: Text("退出登陆",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff303133),
                      )),
                  color: Color(0x33999999),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              );
      },
    ));
  }
}
