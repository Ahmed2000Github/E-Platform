
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../widgets/side_bar.dart';
import 'main_page.dart'; 



class WelcomePageProf extends StatefulWidget {
  const WelcomePageProf({ Key key }) : super(key: key);

  @override
  _WelcomePageProfState createState() => _WelcomePageProfState();
}

class _WelcomePageProfState extends State<WelcomePageProf> {
  var ctime;

  Widget build(BuildContext context){
    return Scaffold(
      body: WillPopScope(
        onWillPop: (){
          DateTime now = DateTime.now();
          if (ctime == null || now.difference(ctime) > Duration(seconds: 2)) {
            //add duration of press gap
            ctime = now;
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Taper une autre fois pour sortit'))
            ); //scaffold message, you can show Toast message too.
            return Future.value(false);
          }

          return exit(0);
        },
        child: Stack(
          children: <Widget>[
            MainPage(),
            SideBar(),
          ],
        ),
      ),
    );
      
}
}
