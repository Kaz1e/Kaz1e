import 'dart:convert';

TimeRegstration timeRegstrationFromJson(String str) =>
    TimeRegstration.fromJson(json.decode(str));

String timeRegstrationToJson(TimeRegstration data) =>
    json.encode(data.toJson());

class TimeRegstration {
  TimeRegstration({
    this.fname,
    this.lname,
    this.serviceId,
    this.message,
  });

  String fname;
  String lname;
  String serviceId;
  String message;

  factory TimeRegstration.fromJson(Map<String, dynamic> json) =>
      TimeRegstration(
        fname: json["fname"],
        lname: json["lname"],
        serviceId: json["service_id"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "fname": fname,
        "lname": lname,
        "service_id": serviceId,
        "message": message,
      };
}

Registration registrationFromJson(String str) =>
    Registration.fromJson(json.decode(str));

String registrationToJson(Registration data) => json.encode(data.toJson());

class Registration {
  Registration({
    this.username,
    this.selectedValue,
    this.password,
    this.passwordConfirmation,
  });

  String username;
  String selectedValue;
  String password;
  String passwordConfirmation;

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
        username: json["username"],
        selectedValue: json["gender"],
        password: json["password"],
        passwordConfirmation: json["password_confirmation"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "gender": selectedValue,
        "password": password,
        "password_confirmation": passwordConfirmation,
      };
}

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    this.fname,
    this.lname,
    this.password,
    this.passwordConfirmation,
  });

  String fname;
  String lname;
  String password;
  String passwordConfirmation;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        fname: json["fname"],
        lname: json["lname"],
        password: json["password"],
        passwordConfirmation: json["passwordConfirmation"],
      );

  Map<String, dynamic> toJson() => {
        "fname": fname,
        "lname": lname,
        "password": password,
        "password_confirmation": passwordConfirmation,
      };
}
