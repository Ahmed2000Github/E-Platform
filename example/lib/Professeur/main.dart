import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:arcore_flutter_plugin_example/Professeur/Views/ScanScreen.dart';
import 'package:arcore_flutter_plugin_example/Professeur/Views/CameraDetection.dart';
import 'package:arcore_flutter_plugin_example/Professeur/Views/LunchCamera.dart';
import 'package:arcore_flutter_plugin_example/Professeur/Views/GetLevels.dart';
import 'package:arcore_flutter_plugin_example/Professeur/Views/StartCamera.dart';

void main() {
  //Widget App // Material App //CupertionApp
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(primarySwatch: Colors.blue),
    routes: {
      "/ScanScreen": (context) => ScanScreen(),
      "/CameraDetection": (context) => CameraDetection(),
      "/LunchCamera":(context) => LunchCamera(),
      "/GetLevels":(context) => GetLevels(),
      "/StartCamera":(context) => StartCamera()
    },
  ));
}
class HomePage extends StatelessWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Gestion de présence")
      ),
      body: Center(
        child: Text('ESPACE PROFESSEUR')
      ),
      drawer: drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.search),
        mini: true,
        hoverColor: Colors.black,
      ),
    );
  }
}

class drawer extends StatelessWidget {
  // const drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Reda Firoud",
                  style: TextStyle(
                      fontSize: 25,)
              ),
              accountEmail: Text("Professeur IRISI 2",
                  style: TextStyle(
                    fontSize: 15,)),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images_etudiants/avatars/firoud.jpeg"),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScanScreen()),
                );},
              leading: Icon(
                  Icons.qr_code,
                  color: Colors.black
              ),
              title: Text("Scan QR Code",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black),
                  ),),


            ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraDetection()),
                  );},
                leading: Icon(
                    Icons.checklist,
                    color: Colors.blue
                ),
                title: Text("Vérifier la liste de présence",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue)
                  ,),
                subtitle: Text("Capturé par la caméra",
                    style: TextStyle(
                        color: Colors.lightBlue)),
            ),
            ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LunchCamera()),
                  );},
                leading: Icon(
                    Icons.camera,
                    color: Colors.blue
                ),
                title: Text("Lancer la caméra",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue)
                  ,),
                
            ),


            ListTile(
              onTap: () {},
              leading: Icon(
                  Icons.logout,
                  color: Colors.black),
              title: Text("Se déconnecter",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black)
              ),
            ),
          ],
        ));
  }
}