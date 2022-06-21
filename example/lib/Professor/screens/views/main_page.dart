import 'package:arcore_flutter_plugin_example/Etudiant/screens/cours_list.dart';
import 'package:arcore_flutter_plugin_example/Etudiant/screens/views/welcome_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'welcome_page.dart';
import 'globals.dart' as globals;

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WelcomePageProf()));
          },
          child:Container(
                  child:(
                    Text("Espace du Professeur: "+ globals.loggedUserName,style:TextStyle(fontSize:15))
                    ),
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/prof/teacher.png"),
                        fit: BoxFit.fitHeight),
                  ),
                ) 
        ),
      ),
    
    );
  }
}
