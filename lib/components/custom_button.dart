import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final double iconGap;
  final Function onTap;
  final Color color;
  final Color textColor;
  final double padding;
  final double radius;
  final Widget trailing;
  final double textSize;

  CustomButton({
    this.label,
    this.icon,
    this.iconGap,
    this.onTap,
    this.color,
    this.textColor,
    this.padding,
    this.radius,
    this.trailing,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 8),
          color: color ?? theme.primaryColor,
        ),
        padding: EdgeInsets.all(padding ?? (icon != null ? 15.0 : 15.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? SizedBox.shrink(),
            icon != null ? SizedBox(width: iconGap ?? 20) : SizedBox.shrink(),
            Text(
              label,
              textAlign: TextAlign.center,
              style: theme.textTheme.subtitle1.copyWith(
                  color: textColor ?? theme.backgroundColor,
                  fontSize: textSize ?? 15),
            ),
            trailing != null ? Spacer() : SizedBox.shrink(),
            trailing ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
