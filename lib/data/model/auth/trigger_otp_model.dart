class TriggerOtpModel {
  String? message;
  String? status;
  Data? data;

  TriggerOtpModel({this.message, this.status, this.data});

  TriggerOtpModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? otpType;
  String? creationTime;
  String? otp;

  Data({this.id, this.otpType, this.creationTime, this.otp});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    otpType = json['otpType'];
    creationTime = json['creationTime'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['otpType'] = this.otpType;
    data['creationTime'] = this.creationTime;
    data['otp'] = this.otp;
    return data;
  }
}
