// TODO Implement this library.
import 'dart:convert';

String selectedSalle = '';
String scannedStudent = '';
String etudiantJson = json.encode('assets/presence.json');
final data = json.decode(etudiantJson);
int salleId = 0;
