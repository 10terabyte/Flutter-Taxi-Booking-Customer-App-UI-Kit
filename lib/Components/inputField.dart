import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final IconData? icon;
  final String? hintText;
  final TextInputType? textInputType;
  final Color? textFieldColor, iconColor;
  final bool? obscureText;
  final bool? enable;
  final double? bottomMargin;
  final TextStyle? textStyle, hintStyle;
  final validateFunction;
  final  onSaved;
  final Key? key;

  //passing props in the Constructor.
  //Java like style
  InputField(
      {this.key,
      this.hintText,
      this.obscureText,
      this.textInputType,
      this.textFieldColor,
      this.icon,
      this.iconColor,
      this.bottomMargin,
      this.textStyle,
      this.validateFunction,
      this.onSaved,
      //this.focusNode,
      this.enable,
      this.hintStyle});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Container(
        margin: EdgeInsets.only(bottom: bottomMargin ?? 0.00),
        child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              color: textFieldColor),
          child: TextFormField(
            style: textStyle,
            key: key,
            obscureText: false, //obscureText,
            keyboardType: textInputType,
            validator: validateFunction,
            onSaved: onSaved,
           //focusNode: FocusNode(),
            enabled: enable,
            decoration: InputDecoration(
              border: InputBorder.none,

              hintText: hintText,
              hintStyle: hintStyle,
              icon: Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
              // hideDivider: true
            ),
          ),
        )));
  }
}
