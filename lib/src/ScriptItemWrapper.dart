import 'package:flutter/material.dart';

class ScriptItemWrapper extends StatelessWidget {
  final Widget child;
  final bool isCustomizable;
  final Function onCallBack;

  const ScriptItemWrapper({Key key, this.child, this.isCustomizable, this.onCallBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isCustomizable) {
      return Container(
        // width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // CloseButton(),
            Expanded(
              flex: 9,
              // width: MediaQuery.of(context).size.width * 0.7,
              child: child,
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  child: Icon(Icons.remove),
                ),
                onTap: this.onCallBack,
              ),
            ),
          ],
        ),
      );
      // return Stack(
      //   children: <Widget>[
      //     child
      //   ],
      // )
    } else {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: child
      );
    }
  }
}
