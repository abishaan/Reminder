import 'package:flutter/material.dart';
import 'package:reminder/api/event_api.dart';
import 'package:reminder/models/event.dart';
import 'package:reminder/screens/event_screen/create_event_widget.dart';
import 'package:reminder/screens/event_screen/event_list_widget.dart';
import 'package:reminder/themes/theme_color.dart';

class SpecialEventWidget extends StatelessWidget {
  final RemindEvent remindEvent;

  const SpecialEventWidget(this.remindEvent, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EventAPI eventAPI = EventAPI();

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
            onLongPress: () {
              showDialog<String>(
                context: context,
                builder: (_) => SimpleDialog(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Edit'),
                      onTap: () {
                        Navigator.pop(context);
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          isScrollControlled: true,
                          context: context,
                          builder: (_) => CreateEventWidget(
                              event: remindEvent, isEditMode: true),
                        );
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.delete),
                      title: Text('Delete'),
                      onTap: () {
                        eventAPI.deleteEvent(remindEvent.reference);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 70,
                  right: -50,
                  child: ClipRect(
                    child: CircleAvatar(
                      backgroundColor: ThemeColor.lightPurple.withAlpha(20),
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
                EventListWidget(
                  titleColor: ThemeColor.titleColor,
                  titleSize: 20,
                  remindEvent: remindEvent,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
