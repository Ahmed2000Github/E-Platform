import 'package:arcore_flutter_plugin_example/Professeur/screens/views/CameraDetection.dart';
import 'package:arcore_flutter_plugin_example/Professeur/screens/views/LunchCamera.dart';
import 'package:flutter/material.dart';

class drawer extends StatelessWidget {

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
                // Navigator.of(context).pop();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ScanScreen()),
                // );
                },
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
