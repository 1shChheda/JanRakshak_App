class sendWidget {
  Result? result;

  sendWidget({this.result});

  sendWidget.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  List<int>? priorityIndexes;
  List<int>? optionalIndexes;

  Result({this.priorityIndexes, this.optionalIndexes});

  Result.fromJson(Map<String, dynamic> json) {
    priorityIndexes = json['priorityIndexes'].cast<int>();
    optionalIndexes = json['optionalIndexes'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['priorityIndexes'] = this.priorityIndexes;
    data['optionalIndexes'] = this.optionalIndexes;
    return data;
  }
}