class StudiosWithWinCountListDto {
  List<Studio>? studios;

  StudiosWithWinCountListDto({this.studios});

  StudiosWithWinCountListDto.fromJson(Map<String, dynamic> json) {
    if (json['studios'] != null) {
      studios = <Studio>[];
      json['studios'].forEach((v) {
        studios!.add(Studio.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (studios != null) {
      data['studios'] = studios!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'StudiosWithWinCountListDto(${toJson().toString()})';
  }
}

class Studio {
  String? name;
  int? winCount;

  Studio({this.name, this.winCount});

  Studio.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    winCount = json['winCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['winCount'] = winCount;
    return data;
  }

  @override
  String toString() {
    return 'Studios(${toJson().toString()})';
  }
}
