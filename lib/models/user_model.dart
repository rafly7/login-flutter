import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
    String userId;
    String displayName;
    String email;
    String password;
    DateTime dateofbirth;
    String placeofbirth;
    String address;
    String phone;
    dynamic photoUrl;
    String bloodGroup;

    User({
        this.userId,
        this.displayName,
        this.email,
        this.password,
        this.dateofbirth,
        this.placeofbirth,
        this.address,
        this.phone,
        this.photoUrl,
        this.bloodGroup,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        displayName: json["displayName"],
        email: json["email"],
        password: json["password"],
        dateofbirth: DateTime.parse(json["dateofbirth"]),
        placeofbirth: json["placeofbirth"],
        address: json["address"],
        phone: json["phone"],
        photoUrl: json["photoUrl"],
        bloodGroup: json["bloodGroup"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "displayName": displayName,
        "email": email,
        "password": password,
        "dateofbirth": "${dateofbirth.year.toString().padLeft(4, '0')}-${dateofbirth.month.toString().padLeft(2, '0')}-${dateofbirth.day.toString().padLeft(2, '0')}",
        "placeofbirth": placeofbirth,
        "address": address,
        "phone": phone,
        "photoUrl": photoUrl,
        "bloodGroup": bloodGroup,
    };
}
