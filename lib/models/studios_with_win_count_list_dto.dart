class StudiosWithWinCountListDto {
  List<Studios>? studios;

  StudiosWithWinCountListDto({this.studios});

  StudiosWithWinCountListDto.fromJson(Map<String, dynamic> json) {
    if (json['studios'] != null) {
      studios = <Studios>[];
      json['studios'].forEach((v) {
        studios!.add(Studios.fromJson(v));
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
}

class Studios {
  String? name;
  int? winCount;

  Studios({this.name, this.winCount});

  Studios.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    winCount = json['winCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['winCount'] = winCount;
    return data;
  }
}
