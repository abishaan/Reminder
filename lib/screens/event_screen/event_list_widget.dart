import 'package:flutter/material.dart';
import 'package:reminder/models/event.dart';
import 'package:reminder/themes/theme_color.dart';

class EventListWidget extends StatelessWidget {
  final RemindEvent remindEvent;

  const EventListWidget(this.remindEvent, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        padding: EdgeInsets.fromLTRB(8, 6, 0, 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              remindEvent.title,
              style: TextStyle(
                  color: ThemeColor.titleColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 24),
            ),
            Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 4,
                    color: ThemeColor.accent.withAlpha(700),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      subtitle: Padding(
        padding: EdgeInsets.fromLTRB(8, 4, 0, 4),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                remindEvent.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: ThemeColor.subTitleColor,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 4, left: 4),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 8,
                    width: 8,
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.pink,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      remindEvent.category,
                      style: TextStyle(
                        color: ThemeColor.titleColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Text(
                      remindEvent.remindTime,
                      style: TextStyle(
                        color: ThemeColor.titleColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
