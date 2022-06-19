import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SchedulerPage extends StatefulWidget {
const SchedulerPage({ Key key }) : super(key: key);
@override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<SchedulerPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emploi'),
      ),
      body: Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
            var showData = json.decode(snapshot.data.toString());
            List<Meeting> collection = <Meeting>[];
            if (showData != null) {
              for (int i = 0; i < showData.length; i++) {
                collection.add(Meeting(
                    eventName: showData[i]['name'],
                    isAllDay: false,
                    from: DateFormat('dd/MM/yyyy HH:mm:ss')
                        .parse(showData[i]['start']),
                    to: DateFormat('dd/MM/yyyy HH:mm:ss')
                        .parse(showData[i]['end']),
                    //const int t = 0xffb74093;
                    background:Color(int.parse(showData[i]['color']))));
              }
            }
      return SfCalendar(
      view: CalendarView.week,
      firstDayOfWeek: 1,
      dataSource: _getCalendarDataSource(collection));
  },
  future: DefaultAssetBundle.of(context)
              .loadString("assets/emploi.json"),
        ),
      ));
}
MeetingDataSource _getCalendarDataSource([List<Meeting> collection]) {
    List<Meeting> meetings = collection ?? <Meeting>[];
    return MeetingDataSource(meetings);
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }
}

class Meeting {
  Meeting({this.eventName, this.from, this.to, this.background, this.isAllDay});

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}