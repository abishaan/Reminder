import 'package:flutter/material.dart';

class EmptyImageWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const EmptyImageWidget({Key key, this.imagePath, this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: CircleAvatar(
            radius: 80,
            backgroundColor: Colors.grey.withAlpha(50),
            child: Image.asset(
              imagePath,
              scale: 5,
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
