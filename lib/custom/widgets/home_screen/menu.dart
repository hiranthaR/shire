import 'package:flutter/material.dart';
import 'package:shire/utils/icons.dart';

class HomeScreenMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: <Widget>[
          GridView.count(
            padding: EdgeInsets.only(left: 3.0, right: 3.0),
            crossAxisCount:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 2
                    : 3,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              MenuTile(title: "Chatrooms", image: ShireIcons.CHAT_ICON,routeName: "/chatrooms",),
              MenuTile(title: "Inbox", image: ShireIcons.INBOX_ICON,routeName: "/chatrooms",),
            ],
          )
        ],
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  final String title;
  final String image;
  final String routeName;

  MenuTile({@required this.title, @required this.image,@required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      child: SizedBox.expand(
        child: RaisedButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(height:130.0,padding: EdgeInsets.all(5.0),child: Image.asset(image)),
              Text(title),
            ],
          ),
          onPressed: () {
            Navigator.pushNamed(context, routeName);
          },
        ),
      ),
    );
  }
}
