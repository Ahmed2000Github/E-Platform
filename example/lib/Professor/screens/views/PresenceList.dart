// import 'package:arcore_flutter_plugin_example/Professor/api/api.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';



// class PresenceList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => EtudiantProvider(),
//       child:  MaterialApp(
//         home: HomePage(),
//       ),
//     );
//   }
// }

// class HomePage extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     final etudiantP = Provider.of<EtudiantProvider>(context);
    
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Liste de presence des étudiants"),
//           backgroundColor: Colors.blue.shade900,
//         ),
//         body: ListView.builder(
//           itemCount: etudiantP.etudiants.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//                 title: Text(etudiantP.etudiants[index].username),
//                 subtitle: Text(etudiantP.etudiants[index].path));
//           },
//         ));
//   }
// }
