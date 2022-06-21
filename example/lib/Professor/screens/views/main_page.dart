import 'package:arcore_flutter_plugin_example/Etudiant/screens/cours_list.dart';
import 'package:arcore_flutter_plugin_example/Etudiant/screens/views/welcome_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'welcome_page.dart';

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
                    Text("Espace Professeur",style:TextStyle(fontSize:20))
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
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.settings, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          //Handle button tap
          print(index);
          switch (index) {
            case 0:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WelcomePage()));
              break;
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WelcomePage()));
              break;
            case 2:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WelcomePage()));
              break;
            default:
          }
        },
      ),
    );
  }
}
