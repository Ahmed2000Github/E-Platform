import 'dart:convert';

import 'package:arcore_flutter_plugin_example/Etudiant/screens/views/main_page.dart';
import 'package:arcore_flutter_plugin_example/Etudiant/screens/views/welcome_page.dart';
import 'package:arcore_flutter_plugin_example/utils.dart';
import 'package:arcore_flutter_plugin_example/utils_data.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool valNotify1 = true;
  bool valNotify2 = true;
  bool valNotify3 = true;
  onChangedMethod1(bool newValue1) {
    setState(() {
      valNotify1 = newValue1;
    });
  }

  onChangedMethod2(bool newValue1) {
    setState(() {
      valNotify1 = newValue1;
    });
  }

  onChangedMethod3(bool newValue1) {
    setState(() {
      valNotify1 = newValue1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          "Settings",
          style: TextStyle(fontSize: 22, color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => (MainPage())));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.volume_up_outlined,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Notifications",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 20,
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            buildNotificationOption("Theme Dark", valNotify1, onChangedMethod1),
            buildNotificationOption(
                "Account Active", valNotify2, onChangedMethod2),
            buildNotificationOption(
                "Opportunity Dark", valNotify3, onChangedMethod3),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.account_box,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Acount",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(height: 20, thickness: 1),
            SizedBox(
              height: 10,
            ),
            buildAccountOption(context, "Content Settings"),
            buildAccountOption(context, "langage "),
            buildAccountOption(context, "privacy and  Security"),
            TextButton(onPressed: () async {}, child: Text("Francais")),
          ],
        ),
      ),
    );
  }
}

Padding buildNotificationOption(
    String title, bool value, Function onChangedMethod) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
              activeColor: Colors.lightBlue,
              trackColor: Colors.grey,
              value: value,
              onChanged: (bool newValue) {
                onChangedMethod(newValue);
              }),
        )
      ],
    ),
  );
}

GestureDetector buildAccountOption(BuildContext context, String title) {
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(onPressed: () {}, child: Text("Francais")),
                  TextButton(onPressed: () {}, child: Text("Anglais")),
                  TextButton(onPressed: () {}, child: Text("Arabe")),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Close"))
              ],
            );
          });
    },
    child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600]),
            ),
          ],
        )),
  );
}
