class Seance {
  int id;
  Seance({id});
  factory Seance.fromJson(Map<String, dynamic> json) => Seance(
        id: json['id'],
      );
}
