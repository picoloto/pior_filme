class Movie {
  int? id;
  int? year;
  String? title;
  List<String>? studios;
  List<String>? producers;
  bool? winner;

  Movie({
    this.id,
    this.year,
    this.title,
    this.studios,
    this.producers,
    this.winner,
  });

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
    title = json['title'];
    studios = json['studios'].cast<String>();
    producers = json['producers'].cast<String>();
    winner = json['winner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['year'] = year;
    data['title'] = title;
    data['studios'] = studios;
    data['producers'] = producers;
    data['winner'] = winner;
    return data;
  }
}
