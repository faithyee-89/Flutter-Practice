import 'package:flutter/material.dart';

const _kScaleHeight = 36;

/// default indicator height
const _kScaleFactor = 0.4;

class Button extends StatefulWidget {
  const Button({
    Key? key,
    this.colors,
    this.onPressed,
    required this.child,
    this.padding,
    this.borderRadius = const BorderRadius.all(Radius.circular(2)),
    this.textColor,
    this.splashColor,
    this.disabledColor,
    this.disabledTextColor,
    this.onHighlightChanged,
    this.minWidth = 88.0,
    this.height = 45.0,
    this.indicatorOnly = false,
    this.indicatorColor,
    this.indicatorSize = 10.0,
    this.loading = false,
  }) : super(key: key);

  // 渐变色数组
  final List<Color>? colors;
  final Color? textColor;
  final Color? splashColor;
  final Color? disabledTextColor;
  final Color? disabledColor;
  final EdgeInsetsGeometry? padding;

  final Widget child;
  final BorderRadius borderRadius;
  final double minWidth;
  final double height;

  final GestureTapCallback? onPressed;
  final ValueChanged<bool>? onHighlightChanged;
  final bool loading;
  final Color? indicatorColor;
  final double indicatorSize;
  final bool indicatorOnly;

  @override
  State<Button> createState() => new LoadingState();
}

class ElevatedGradientButton extends StatefulWidget {
  const ElevatedGradientButton({
    Key? key,
    this.colors,
    this.onPressed,
    this.padding,
    this.borderRadius = const BorderRadius.all(Radius.circular(2)),
    this.textColor,
    this.splashColor,
    this.disabledColor,
    this.disabledTextColor,
    this.onHighlightChanged,
    this.shadowColor,
    this.child,
  }) : super(key: key);

  // 渐变色数组
  final List<Color>? colors;
  final Color? textColor;
  final Color? splashColor;
  final Color? disabledTextColor;
  final Color? disabledColor;
  final Color? shadowColor;
  final EdgeInsetsGeometry? padding;

  final Widget? child;
  final BorderRadius? borderRadius;

  final GestureTapCallback? onPressed;
  final ValueChanged<bool>? onHighlightChanged;

  @override
  _ElevatedGradientButtonState createState() => _ElevatedGradientButtonState();
}

class _ElevatedGradientButtonState extends State<ElevatedGradientButton> {
  bool _tapDown = false;

  @override
  Widget build(BuildContext context) {
    bool disabled = widget.onPressed == null;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        boxShadow: disabled
            ? null
            : [
                _tapDown
                    ? BoxShadow(
                        offset: const Offset(2, 6),
                        spreadRadius: -2,
                        blurRadius: 9,
                        color: widget.shadowColor ?? Colors.black54,
                      )
                    : BoxShadow(
                        offset: const Offset(0, 2),
                        spreadRadius: -2,
                        blurRadius: 3,
                        color: widget.shadowColor ?? Colors.black87,
                      )
              ],
      ),
      child: Button(
        colors: widget.colors,
        onPressed: widget.onPressed,
        padding: widget.padding,
        borderRadius: widget.borderRadius!,
        textColor: widget.textColor,
        splashColor: widget.splashColor,
        disabledColor: widget.disabledColor,
        disabledTextColor: widget.disabledTextColor,
        child: widget.child!,
        onHighlightChanged: (v) {
          setState(() {
            _tapDown = v;
          });
          widget.onHighlightChanged!(v);
        },
      ),
    );
  }
}

class LoadingState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    // color
    final Color indColor =
        widget.indicatorColor ?? Theme.of(context).accentColor;
    // indicator size
    double scaleFactor;
    if (widget.indicatorSize != 0 && widget.indicatorSize > 0) {
      scaleFactor = (widget.indicatorSize / _kScaleHeight);
    } else {
      scaleFactor = (widget.height != 0)
          ? _kScaleFactor * (widget.height / _kScaleHeight)
          : _kScaleFactor;
    }
    // indicator area
    final Widget indicator = Transform.scale(
        scale: scaleFactor,
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
          valueColor: AlwaysStoppedAnimation(indColor),
        ));

    Widget child;
    if (widget.loading && widget.indicatorOnly) {
      child = indicator;
    } else if (widget.loading && !widget.indicatorOnly) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          indicator,
          SizedBox(width: 5.0 * scaleFactor),
          widget.child
        ],
      );
    } else {
      child = widget.child;
    }

    ThemeData theme = Theme.of(context);
    //确保colors数组不空
    List<Color> _colors =
        widget.colors ?? [theme.primaryColor, theme.primaryColorDark];
    final radius = widget.borderRadius;
    bool disabled = widget.onPressed == null;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: disabled ? null : LinearGradient(colors: _colors),
        color: disabled ? widget.disabledColor ?? theme.disabledColor : null,
        borderRadius: radius,
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: radius,
        clipBehavior: Clip.hardEdge,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: widget.minWidth, minHeight: widget.height),
          child: InkWell(
            splashColor: widget.splashColor ?? _colors.last,
            highlightColor: Colors.transparent,
            onHighlightChanged: widget.onHighlightChanged,
            onTap: widget.onPressed,
            child: Padding(
              padding: widget.padding ?? theme.buttonTheme.padding,
              child: DefaultTextStyle(
                style: const TextStyle(fontWeight: FontWeight.bold),
                child: Center(
                  child: DefaultTextStyle(
                    style: theme.textTheme.button!.copyWith(
                      color: disabled
                          ? widget.disabledTextColor ?? Colors.black38
                          : widget.textColor ?? Colors.white,
                    ),
                    child: child,
                  ),
                  widthFactor: 1,
                  heightFactor: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
