class UserHrmModel {
  String? firstName;
  String? lastName;
  String? comeDate;
  String? zoneID;
  String? zoneName;
  int? jobPosID;
  int? jPLevelID;
  String? deptID;
  int? annualLeave;
  String? jobpositionName;
  String? jPName;
  String? jPLevelName;
  String? departmentName;
  int? empID;

  UserHrmModel(
      {this.firstName,
      this.lastName,
      this.comeDate,
      this.zoneID,
      this.zoneName,
      this.jobPosID,
      this.jPLevelID,
      this.deptID,
      this.annualLeave,
      this.jobpositionName,
      this.jPName,
      this.jPLevelName,
      this.departmentName,
      this.empID});

  UserHrmModel.fromJson(Map<String, dynamic> json) {
    firstName = json['FirstName'];
    lastName = json['LastName'];
    comeDate = json['ComeDate'];
    zoneID = json['ZoneID'];
    zoneName = json['ZoneName'];
    jobPosID = json['JobPosID'];
    jPLevelID = json['JPLevelID'];
    deptID = json['DeptID'];
    annualLeave = json['AnnualLeave'];
    jobpositionName = json['JobpositionName'];
    jPName = json['JPName'];
    jPLevelName = json['JPLevelName'];
    departmentName = json['DepartmentName'];
    empID = json['EmpID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['ComeDate'] = comeDate;
    data['ZoneID'] = zoneID;
    data['ZoneName'] = zoneName;
    data['JobPosID'] = jobPosID;
    data['JPLevelID'] = jPLevelID;
    data['DeptID'] = deptID;
    data['AnnualLeave'] = annualLeave;
    data['JobpositionName'] = jobpositionName;
    data['JPName'] = jPName;
    data['JPLevelName'] = jPLevelName;
    data['DepartmentName'] = departmentName;
    data['EmpID'] = empID;
    return data;
  }
}
