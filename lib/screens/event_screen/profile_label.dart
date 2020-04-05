import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reminder/utils/theme_color.dart';

class ProfileLabel extends StatelessWidget {
  const ProfileLabel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 0, 10),
              child: Text(
                'Hey Peter,',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: ThemeColor.primaryAccent),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: IconButton(
                icon: Icon(
                  MdiIcons.logout,
                  color: ThemeColor.darkAccent,
                  size: 25,
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
          child: Text(
            'what\'s your plan today?',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: ThemeColor.primaryAccent),
          ),
        ),
      ],
    );
  }
}
