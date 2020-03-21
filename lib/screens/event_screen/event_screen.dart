import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reminder/api/event_api.dart';
import 'package:reminder/models/event.dart';
import 'package:reminder/screens/event_screen/category_widget.dart';
import 'package:reminder/screens/event_screen/today_events.dart';
import 'package:reminder/themes/theme_color.dart';
import 'package:reminder/widgets/empty_image_widget.dart';
import 'package:reminder/screens/event_screen/special_event_widget.dart';
import 'package:reminder/screens/event_screen/normal_event_widget.dart';
import 'package:reminder/screens/event_screen/label_widget.dart';

class EventScreen extends StatefulWidget {
  static const homeMenuItems = ['Manage Categories', 'Settings'];

  const EventScreen({Key key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  EventAPI _eventAPI = EventAPI();
  String _screenTitle = 'Remind Me!';

  final List<PopupMenuItem> _popupHomeMenuItems = EventScreen.homeMenuItems
      .map((value) => PopupMenuItem(
            value: value,
            child: Text(value),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
//        drawer: Drawer(),
//        appBar: AppBar(
//          elevation: 0,
//          iconTheme: IconThemeData(color: ThemeColor.darkAccent),
//          title: Text(
//            'Remind Me!',
//            style: TextStyle(color: ThemeColor.darkAccent),
//          ),
//          backgroundColor: Colors.white,
//        ),
        backgroundColor: Colors.white,
        body: _buildEventList(context),
      ),
    );
  }

  Widget _upperView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
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
        ),
//        SpecialEventWidget(
//          RemindEvent(
//            title: 'Appoinment',
//            description: 'at hospital',
//            category: 'personal',
//            remindTime: '5:56 PM',
//            remindDate: '',
//          ),
//        ),
//        LabelWidget('Categories', 1),
//        SingleChildScrollView(
//          scrollDirection: Axis.horizontal,
//          child: Container(
//            margin: EdgeInsets.symmetric(horizontal: 10),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: <Widget>[
//                CategoryWidget(Icon(Icons.work), 'Personal'),
//                CategoryWidget(Icon(Icons.book), 'Study'),
//                CategoryWidget(Icon(Icons.timelapse), 'Meeting'),
//                CategoryWidget(Icon(Icons.work), 'Work'),
//                CategoryWidget(Icon(Icons.category), 'Others'),
//              ],
//            ),
//          ),
//        ),
//        SizedBox(
//          height: 10,
//        ),
//        Divider(),
//        LabelWidget('Today\'s Events', 2),
      ],
    );
  }

  Widget _buildEventList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _eventAPI.getEvents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return snapshot.data.documents.length > 0
              ? ListView(
                  children: snapshot.data.documents
                      .asMap()
                      .map(
                        (index, data) => MapEntry(
                          index,
                          index == 0
                              ? _upperView()
                              : NormalEventWidget(
                                  index, RemindEvent.fromSnapshot(data)),
                        ),
                      )
                      .values
                      .toList(),
                )
              : ListView(
                  children: <Widget>[
                    _upperView(),
                    EmptyImageWidget(
                        title: 'You have a free day.',
                        subtitle:
                            'Ready for some new events? Tap + to write them down.',
                        imagePath: 'assets/images/archive.png'),
                  ],
                );
        });
  }
}
