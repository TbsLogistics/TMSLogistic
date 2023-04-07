class ListImageModel {
  String? fileName;
  String? image;
  String? note;

  ListImageModel({this.fileName, this.image, this.note});

  ListImageModel.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    image = json['image'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fileName'] = fileName;
    data['image'] = image;
    data['note'] = note;
    return data;
  }
}
