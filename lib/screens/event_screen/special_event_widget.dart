import 'package:flutter/material.dart';
import 'package:reminder/models/event.dart';
import 'package:reminder/themes/theme_color.dart';

class SpecialEventWidget extends StatelessWidget {
  final RemindEvent remindEvent;

  const SpecialEventWidget(this.remindEvent, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
              color: ThemeColor.primaryAccent.withAlpha(40), width: 1)),
      child: Container(
        height: 130,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            splashColor: ThemeColor.lightPurple.withAlpha(20),
            onTap: () {},
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 35,
                  right: -50,
                  child: ClipRect(
                    child: CircleAvatar(
                      backgroundColor: ThemeColor.darkAccent,
                      radius: 40,
                    ),
                  ),
                ),
                Positioned(
                  top: -105,
                  left: 135,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: ThemeColor.lightPurple.withAlpha(20),
                  ),
                ),
                Positioned(
                  top: 70,
                  left: -70,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: ThemeColor.lightPurple.withAlpha(25),
                  ),
                ),
                ListTile(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
