class WinIntervalForProducersListDto {
  List<IntervalWin>? min;
  List<IntervalWin>? max;

  WinIntervalForProducersListDto({this.min, this.max});

  WinIntervalForProducersListDto.fromJson(Map<String, dynamic> json) {
    if (json['min'] != null) {
      min = <IntervalWin>[];
      json['min'].forEach((v) {
        min!.add(IntervalWin.fromJson(v));
      });
    }
    if (json['max'] != null) {
      max = <IntervalWin>[];
      json['max'].forEach((v) {
        max!.add(IntervalWin.fromJson(v));
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

  @override
  String toString() {
    return 'WinIntervalForProducersListDto(${toJson().toString()})';
  }
}

class IntervalWin {
  String? producer;
  int? interval;
  int? previousWin;
  int? followingWin;

  IntervalWin(
      {this.producer, this.interval, this.previousWin, this.followingWin});

  IntervalWin.fromJson(Map<String, dynamic> json) {
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

  @override
  String toString() {
    return 'Interval(${toJson().toString()})';
  }
}
