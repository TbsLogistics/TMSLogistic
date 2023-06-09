class Validate {
  String username(String? value) {
    if (value!.isEmpty) {
      return "Nhập tài khoản";
    }
    return "";
  }

  String password(String? value) {
    if (value!.isEmpty) {
      return "Nhập mật khẩu";
    } else {
      if (value.length <= 6 && value.length >= 30) {
        return "Tối thiểu 6 kí tự và tối đa 30 kí tự";
      }
    }
    return "";
  }

  String newPassword(String? value) {
    if (value!.isEmpty) {
      return "Nhập mật khẩu";
    } else if (value.length <= 6 && value.length >= 30) {
      return "Tối thiểu 6 kí tự và tối đa 30 kí tự";
    }
    return "";
  }

  String reNewPassword(String? value1, String value2) {
    if (value2.isEmpty) {
      return "Nhập lại mật khẩu";
    } else {
      if (value2.length <= 6 && value2.length >= 30) {
        return "Tối thiểu 6 kí tự và tối đa 30 kí tự";
      } else {
        if (value1 != value2) {
          return "Mật khẩu nhập lại không trùng khớp";
        }
        return "";
      }
    }
  }

  String timeOfDay({String? value}) {
    if (value!.isEmpty) {
      return "Chọn ngày tháng";
    }
    return "";
  }

  String numberCar({String? value}) {
    if (value!.isEmpty) {
      return "Nhập số xe";
    }
    return "";
  }

  String selectCustomer({String? value}) {
    if (value == null) {
      return "Chọn khách hàng";
    }
    return "";
  }

  String selectWareHome({String? value}) {
    if (value == null) {
      return "Chọn khách hàng";
    }
    return "";
  }

  String selectTypeProduct({String? value}) {
    if (value == null) {
      return "Chọn loại hàng";
    }
    return "";
  }

  String selectTypeCar({String? value}) {
    if (value == null) {
      return "Chọn loại xe";
    }
    return "";
  }
}
