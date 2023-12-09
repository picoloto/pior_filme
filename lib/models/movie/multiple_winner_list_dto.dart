class MultipleWinnerListDto {
  List<Years>? years;

  MultipleWinnerListDto({this.years});

  MultipleWinnerListDto.fromJson(Map<String, dynamic> json) {
    if (json['years'] != null) {
      years = <Years>[];
      json['years'].forEach((v) {
        years!.add(Years.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (years != null) {
      data['years'] = years!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'MultipleWinnerListDto(${toJson().toString()})';
  }
}

class Years {
  int? year;
  int? winnerCount;

  Years({this.year, this.winnerCount});

  Years.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    winnerCount = json['winnerCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['winnerCount'] = winnerCount;
    return data;
  }

  @override
  String toString() {
    return 'Years(${toJson().toString()})';
  }
}
