import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String? label;
  final Widget? icon;
  final double? iconGap;
  final Function? onTap;
  final Color? color;
  final Color? textColor;
  final double? padding;
  final double? radius;
  final Widget? trailing;
  final double? textSize;
  final double? width;

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
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      // onTap: onTap != null ?? onTap : ((){}),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 10),
          color: color ?? theme.primaryColorLight,
        ),
        width: width ?? double.infinity,
        padding: EdgeInsets.all(padding ?? (icon != null ? 16.0 : 20.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? SizedBox.shrink(),
            icon != null ? SizedBox(width: iconGap ?? 20) : SizedBox.shrink(),
            Text(
              label ?? "Continue",
              textAlign: TextAlign.center,
              // style: theme.textTheme.button
              //     .copyWith(color: textColor ?? theme.scaffoldBackgroundColor),
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  letterSpacing: .25,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: textColor ?? theme.scaffoldBackgroundColor,
                ),
              ),
            ),
            trailing != null ? Spacer() : SizedBox.shrink(),
            trailing ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
