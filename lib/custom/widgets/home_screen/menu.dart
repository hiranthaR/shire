import 'package:flutter/material.dart';

class HomeScreenMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      child: Wrap(
        children: <Widget>[
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[

            ],
          )
        ],
      ),
    );
  }
}
