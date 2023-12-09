class WinIntervalForProducersListDto {
  List<Interval>? min;
  List<Interval>? max;

  WinIntervalForProducersListDto({this.min, this.max});

  WinIntervalForProducersListDto.fromJson(Map<String, dynamic> json) {
    if (json['min'] != null) {
      min = <Interval>[];
      json['min'].forEach((v) {
        min!.add(Interval.fromJson(v));
      });
    }
    if (json['max'] != null) {
      max = <Interval>[];
      json['max'].forEach((v) {
        max!.add(Interval.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (min != null) {
      data['min'] = min!.map((v) => v.toJson()).toList();
    }
    if (max != null) {
      data['max'] = max!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Interval {
  String? producer;
  int? interval;
  int? previousWin;
  int? followingWin;

  Interval({this.producer, this.interval, this.previousWin, this.followingWin});

  Interval.fromJson(Map<String, dynamic> json) {
    producer = json['producer'];
    interval = json['interval'];
    previousWin = json['previousWin'];
    followingWin = json['followingWin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['producer'] = producer;
    data['interval'] = interval;
    data['previousWin'] = previousWin;
    data['followingWin'] = followingWin;
    return data;
  }
}
