class ChangePageRegister {
  String? idKhachhang;
  String? idTeamCar;
  String? idKho;
  String? numberCar;

  ChangePageRegister({
    required this.idKhachhang,
    required this.idKho,
    required this.idTeamCar,
    required this.numberCar,
  });
  ChangePageRegister.fromjson(Map<String, dynamic> json) {
    idKhachhang = json["idKhachhang"];
    idKho = json["idKho"];
    idTeamCar = json["idTeamCar"];
    numberCar = json["numberCar"];
  }
}
