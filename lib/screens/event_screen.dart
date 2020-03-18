import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder/models/event_model.dart';
import 'package:reminder/utils/theme_color.dart';

class EventScreen extends StatefulWidget {
  final Event events;

  const EventScreen({Key key, this.events}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  List<bool> checkbox = new List<bool>();

  @override
  void initState() {
    setState(() {
      for (int i = 0; i <= 10; i++) {
        checkbox.add(false);
      }
    });
    super.initState();
  }

  Widget _buildEventRow(int index) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side:
              BorderSide(width: 2, color: ThemeColor.darkAccent.withAlpha(50))),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        height: 120,
        child: ListTile(
          title: Container(
            padding: EdgeInsets.fromLTRB(8, 8, 0, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Title',
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
                    'Lorem LoremLorem ipsome Lorem LoremLorem ipsome ',
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
                          'Meeting:',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Text(
                          '10.30 am',
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
    );
  }

  Widget _buildEventListRow(int index) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: _buildEventRow(index),
        )
      ],
    );
  }

  Widget _eventLabel(String label, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.topLeft,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 12),
            child: Text(
              label,
              style: TextStyle(
                color: ThemeColor.darkAccent,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Positioned(
            bottom: 3,
            left: 15,
            width: 30,
            height: 2.5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 1],
                  colors: [
                    ThemeColor.darkAccent.withAlpha(700),
                    ThemeColor.titleColor.withAlpha(700),
                  ],
                ),
              ),
            ),
          ),
          index == 2
              ? Positioned(
                  bottom: 3,
                  left: 50,
                  width: 30,
                  height: 2.5,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0.1, 1],
                        colors: [
                          ThemeColor.darkAccent.withAlpha(700),
                          ThemeColor.titleColor.withAlpha(700),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget _buildCategory(Icon icon, String label) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: IconButton(
              icon: icon,
              color: ThemeColor.darkAccent,
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              label,
              style: TextStyle(
                  color: ThemeColor.titleColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryCard(String title) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
              color: ThemeColor.primaryAccent.withAlpha(40), width: 1)),
      child: Container(
        height: 150,
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
                          'Title',
                          style: TextStyle(
                              color: ThemeColor.titleColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 28),
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
                            'Lorem LoremLorem ipsome Lorem LoremLorem ipsome ',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: ThemeColor.subTitleColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16, bottom: 4, left: 4),
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
                                  'Meeting:',
                                  style: TextStyle(
                                    color: ThemeColor.titleColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text(
                                  '10.30 am',
                                  style: TextStyle(
                                    color: ThemeColor.titleColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            _eventLabel('Categories', 1),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildCategory(Icon(Icons.work), 'Personal'),
                    _buildCategory(Icon(Icons.book), 'Study'),
                    _buildCategory(Icon(Icons.timelapse), 'Meeting'),
                    _buildCategory(Icon(Icons.work), 'Work'),
                    _buildCategory(Icon(Icons.category), 'Others'),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            _eventLabel('Today\'s Events', 2),
            Expanded(
              child: ListView.builder(
                itemCount: checkbox.length,
                itemBuilder: (context, index) {
                  if (index == 0) return _categoryCard('fff');
                  return _buildEventListRow(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
