
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../widgets/side_bar.dart';
import 'main_page.dart'; 



class WelcomePage extends StatefulWidget {
  const WelcomePage({ Key key }) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
