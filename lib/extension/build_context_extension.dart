import 'package:flutter/material.dart';

extension EBuildContext on BuildContext {
  Widget buildFlatButton({
    required String title,
    required VoidCallback onPressed,
    EdgeInsets? padding,
    bool isLoading = false,
    bool isEnabled = true,
    bool fit = false,
  }) {
    return FractionallySizedBox(
      widthFactor: fit ? null : 1.0,
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(padding ?? EdgeInsets.all(12)),
          overlayColor: MaterialStateProperty.resolveWith((states) {
            if (isEnabled && states.contains(MaterialState.pressed))
              return Theme.of(this).splashColor;
            return Colors.transparent;
          }),
          // MaterialStateProperty.all(
          //   isEnabled ? Theme.of(this).splashColor : Colors.transparent,
          // ),
          backgroundColor: MaterialStateProperty.all(
            isEnabled
                ? Theme.of(this).accentColor
                : Theme.of(this).disabledColor,
          ),
          textStyle: MaterialStateProperty.all(TextStyle()),
        ),
        onPressed: onPressed,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            (() {
              if (isLoading) {
                return SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                );
              }
              return SizedBox();
            })(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  color:
                      Theme.of(this).canvasColor.withOpacity(isLoading ? 0 : 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
