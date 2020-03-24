import 'package:flutter/material.dart';
import 'package:reminder/services/event_service.dart';
import 'package:reminder/models/event.dart';
import 'package:reminder/screens/event_screen/create_event.dart';
import 'package:reminder/themes/theme_color.dart';

class EventCard extends StatelessWidget {
  final int index;
  final RemindEvent remindEvent;

  const EventCard({Key key, this.index, this.remindEvent}) : super(key: key);

  _showBottomSheet(BuildContext context) {
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
                builder: (_) =>
                    CreateEventWidget(event: remindEvent, isEdit: true),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
            onTap: () {
              EventService().deleteEvent(remindEvent.reference);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          width: 3,
          color: ThemeColor.darkAccent.withAlpha(40),
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        height: 100,
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
                              event: remindEvent, isEdit: true),
                        );
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.delete),
                      title: Text('Delete'),
                      onTap: () {
                        EventService().deleteEvent(remindEvent.reference);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
            child: ListTile(
              title: Container(
                padding: EdgeInsets.fromLTRB(8, 8, 0, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      remindEvent.title,
                      style: TextStyle(fontWeight: FontWeight.w700),
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
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12, bottom: 4, left: 4),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 6,
                            width: 6,
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 4,
                                  color: index % 2 == 0
                                      ? Colors.deepPurpleAccent.withAlpha(700)
                                      : Colors.redAccent.withAlpha(700),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              remindEvent.category != ''
                                  ? '${remindEvent.category} at '
                                  : '',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Text(
                              remindEvent.remindTime,
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
