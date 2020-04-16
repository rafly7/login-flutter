// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Department departmentFromJson(String str) => Department.fromJson(json.decode(str));

String departmentToJson(Department data) => json.encode(data.toJson());

class Department {
    int departmentId;
    String departmentName;

    Department({
        this.departmentId,
        this.departmentName,
    });

    factory Department.fromJson(Map<String, dynamic> json) => Department(
        departmentId: json["departmentId"],
        departmentName: json["departmentName"],
    );

    Map<String, dynamic> toJson() => {
        "departmentId": departmentId,
        "departmentName": departmentName,
    };
}