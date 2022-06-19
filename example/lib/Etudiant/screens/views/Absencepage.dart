import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:arcore_flutter_plugin_example/Etudiant/screens/views/reclamation_page.dart';
import 'package:flutter/services.dart';

class AbsencePage extends StatefulWidget {
const AbsencePage({ Key key }) : super(key: key);
@override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<AbsencePage> {
  List _items = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/absence.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
    });
  }

@override
void initState() {
  super.initState();
  WidgetsBinding.instance?.addPostFrameCallback((_) {
    // do something
    readJson();
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des absences'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
            },
            child: Center(
            ),
          ),
          SizedBox(width: 20.0)
        ],
      ),
      body: Column(
        children: [
          _items.isNotEmpty
                ?Expanded(
            child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                               Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _items[index]["name"].toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Absent de : "+
                                       _items[index]["de"].toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Absent à : "+
                                       _items[index]["à"].toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(
                             context,
                           MaterialPageRoute(builder: (context) => const ReclamationPage()),
                            );
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: const Center(
                                            child: Text(
                                              'Reclamer',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
                
          ): Container(),
        ],
      ),
    );
  }
}