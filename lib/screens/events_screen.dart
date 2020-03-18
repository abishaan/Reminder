import 'package:flutter/material.dart';
import 'package:reminder/models/event_model.dart';
import 'package:reminder/utils/theme_color.dart';

class EventsScreen extends StatefulWidget {
  final Event events;

  const EventsScreen({Key key, this.events}) : super(key: key);

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
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
      elevation: 2,
      shape: Border(
        left: BorderSide(
          color: index % 2 == 0 ? Colors.deepPurple : Colors.red,
          width: 5,
        ),
      ),
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
        Positioned(
          top: 0.0,
          bottom: 0.0,
          left: 45.0,
          child: Container(
            height: double.infinity,
            width: 3,
            color: Colors.grey.withAlpha(50),
          ),
        ),
        Positioned(
          top: 65.0,
          left: 38,
          child: Container(
            height: 16.0,
            width: 16.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index % 2 == 0
                  ? Colors.deepPurpleAccent.withAlpha(1000)
                  : Colors.redAccent.withAlpha(1000),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 5,
                  color: index % 2 == 0
                      ? Colors.deepPurple.withAlpha(100)
                      : Colors.red.withAlpha(100),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 60.0),
          child: _buildEventRow(index),
        )
      ],
    );
  }

  Widget _eventLabel(String label) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.topLeft,
      child: Text(
        label,
        style: TextStyle(
          color: ThemeColor.subTitleColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildCategory(Color color1, Color color2, String label) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 1]),
      ),
      height: 80,
      width: 80,
      child: Center(
        child: Text(
          label,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
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
            SizedBox(
              height: 10,
            ),
            _eventLabel('Categories'),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildCategory(Colors.purple.withAlpha(450), Colors.pink.withAlpha(450), 'Personal'),
                  _buildCategory(Colors.pink.withAlpha(450), Colors.red.withAlpha(450), 'Study'),
                  _buildCategory(Colors.red.withAlpha(450), Colors.deepOrange.withAlpha(450), 'Meeting'),
                  _buildCategory(Colors.deepOrange.withAlpha(450), Colors.orange.withAlpha(450), 'Work'),
                  _buildCategory(Colors.orange.withAlpha(450), Colors.amber.withAlpha(450), 'Others'),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            Divider(),
            _eventLabel('Today\'s Events'),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: checkbox.length,
                itemBuilder: (context, index) {
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

