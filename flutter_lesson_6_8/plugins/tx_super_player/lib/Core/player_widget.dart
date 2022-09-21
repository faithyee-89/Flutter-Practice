part of cniao5_super_player;

class PlayerVideo extends StatefulWidget {
  final PlayerController controller;

  PlayerVideo({required this.controller});

  @override
  _PlayerVideoState createState() => _PlayerVideoState();
}

class _PlayerVideoState extends State<PlayerVideo> {
  int _textureId = -1;

  @override
  void initState() {
    super.initState();

    widget.controller.textureId.then((val) {
      setState(() {
        print("_textureId = $val");
        _textureId = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _textureId == -1
        ? Container()
        : Texture(
            textureId: _textureId,
          );
  }
}
