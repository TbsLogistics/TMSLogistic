class ListTypeVoteModel {
  int? id;
  String? name;

  ListTypeVoteModel({this.id, this.name});

  ListTypeVoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  static List<ListTypeVoteModel> fromJsonList(List list) {
    return list.map((item) => ListTypeVoteModel.fromJson(item)).toList();
  }

  String userAsString() {
    return "${this.id} ${this.name}";
  }

  bool isEqual(ListTypeVoteModel model) {
    return this.name == model.name;
  }

  @override
  String toString() {
    if (name == null) {
      return name = "";
    }
    return name!;
  }
}
