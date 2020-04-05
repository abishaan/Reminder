import 'package:flutter/material.dart';
import 'package:reminder/utils/theme_color.dart';

class EmptyImageWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final double topPadding;

  const EmptyImageWidget(
      {Key key, this.imagePath, this.title, this.subtitle, this.topPadding = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: topPadding),
          child: CircleAvatar(
            radius: 100,
            backgroundColor: Colors.grey.withAlpha(30),
            child: Image.asset(
              imagePath,
              scale: 4.5,
              color: ThemeColor.primaryAccent,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.body2,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.body1,
          ),
        )
      ],
    );
  }
}
