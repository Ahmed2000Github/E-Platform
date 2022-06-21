// TODO Implement this library.
import 'dart:convert';
String selectedSalle = '';
String scannedStudent = '';
int idtobecorrected = 0;
int seancetobecorrected = 0;
String nametobecorrected = '';
String etudiantJson = json.encode('assets/presence.json');
List data = [];
bool visiblepres = false;
int salleId = 0;
String loggedUserName='';