
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
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MainPage(),
          SideBar(),
        ],
        ),
    );
      
}
}
