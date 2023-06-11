class DayOffLettersManagerModel {
  int? regID;
  int? empID;
  String? type;
  String? reason;
  String? startDate;
  double? period;
  String? regDate;
  String? address;
  String? endDate;
  String? lastName;
  String? firstName;
  String? deptID;
  int? posID;
  String? comeDate;
  int? jPLevel;
  String? jobPositionName;
  String? departmentName;
  String? position;
  int? annualLeave;
  int? apprOrder;
  int? apprState;
  int? aStatus;

  DayOffLettersManagerModel(
      {this.regID,
      this.empID,
      this.type,
      this.reason,
      this.startDate,
      this.period,
      this.regDate,
      this.address,
      this.endDate,
      this.lastName,
      this.firstName,
      this.deptID,
      this.posID,
      this.comeDate,
      this.jPLevel,
      this.jobPositionName,
      this.departmentName,
      this.position,
      this.annualLeave,
      this.apprOrder,
      this.apprState,
      this.aStatus});

  DayOffLettersManagerModel.fromJson(Map<String, dynamic> json) {
    regID = json['regID'];
    empID = json['EmpID'];
    type = json['Type'];
    reason = json['Reason'];
    startDate = json['StartDate'];
    period = json['Period'];
    regDate = json['RegDate'];
    address = json['Address'];
    endDate = json['EndDate'];
    lastName = json['LastName'];
    firstName = json['FirstName'];
    deptID = json['DeptID'];
    posID = json['PosID'];
    comeDate = json['ComeDate'];
    jPLevel = json['JPLevel'];
    jobPositionName = json['JobPositionName'];
    departmentName = json['departmentName'];
    position = json['Position'];
    annualLeave = json['AnnualLeave'];
    apprOrder = json['apprOrder'];
    apprState = json['apprState'];
    aStatus = json['aStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['regID'] = regID;
    data['EmpID'] = empID;
    data['Type'] = type;
    data['Reason'] = reason;
    data['StartDate'] = startDate;
    data['Period'] = period;
    data['RegDate'] = regDate;
    data['Address'] = address;
    data['EndDate'] = endDate;
    data['LastName'] = lastName;
    data['FirstName'] = firstName;
    data['DeptID'] = deptID;
    data['PosID'] = posID;
    data['ComeDate'] = comeDate;
    data['JPLevel'] = jPLevel;
    data['JobPositionName'] = jobPositionName;
    data['departmentName'] = departmentName;
    data['Position'] = position;
    data['AnnualLeave'] = annualLeave;
    data['apprOrder'] = apprOrder;
    data['apprState'] = apprState;
    data['aStatus'] = aStatus;
    return data;
  }
}
