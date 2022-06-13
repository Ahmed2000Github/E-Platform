class Etudiant {
  String username;
  String path;
  bool is_present;

  Etudiant({is_present, path, username});

  factory Etudiant.fromJson(Map<String, dynamic> json) => Etudiant(
        username: json['username'],
        path: json['path'],
        is_present: json['is_present'],
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'path': path,
        'is_present': is_present,
      };
}
