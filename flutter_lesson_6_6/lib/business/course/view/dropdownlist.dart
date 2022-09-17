import 'package:flutter/material.dart';

typedef DropDownListCallback = void Function(int index);

class DropDownList extends StatelessWidget {
  const DropDownList({
    Key? key,
    this.menus = const [],
    this.selectedIndex = 0,
    this.onTap,
  }) : super(key: key);

  final List menus;
  final int selectedIndex;
  final DropDownListCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: _cellForMenus(menus),
      ),
    );
  }

  List<Widget> _cellForMenus(List menus) {
    List<Widget> cells = [];
    for (int i = 0; i < menus.length; i++) {
      cells.addAll(_cellsForTitle(
        menus[i],
        hasSepLine: menus.length - 1 != i,
        isSelected: i == selectedIndex,
        index: i,
      ));
    }
    return cells;
  }

  List<Widget> _cellsForTitle(
    String title, {
    bool hasSepLine = true,
    bool isSelected = false,
    int index = 0,
  }) {
    List<Widget> cells = [];
    cells.add(GestureDetector(
      onTap: () {
        if(onTap != null) onTap!(index);
      },
      child: Container(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Color(0xFFFC9900) : Colors.black,
                ),
              ),
              isSelected ? Icon(
                Icons.done_rounded,
                size: 16,
                color: Color(0xFFFC9900),
              ) : Container(),
            ],
          ),
        ),
      ),
    ));
    if (hasSepLine) {
      cells.add(
        Divider(
          height: 0.5,
          indent: 12.0,
          endIndent: 12.0,
          color: Colors.black12,
        ),
      );
    }
    return cells;
  }
}
