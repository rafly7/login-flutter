// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Employee employeeFromJson(String str) => Employee.fromJson(json.decode(str));

String employeeToJson(Employee data) => json.encode(data.toJson());

class Employee {
    String employeeId;
    int deptId;
    String firstName;
    String lastName;
    dynamic gender;
    dynamic familyName;
    dynamic familyNumber;
    dynamic photos;
    String phone;
    String bloodType;
    DateTime hiredDate;
    String status;
    Department department;

    Employee({
        this.employeeId,
        this.deptId,
        this.firstName,
        this.lastName,
        this.gender,
        this.familyName,
        this.familyNumber,
        this.photos,
        this.phone,
        this.bloodType,
        this.hiredDate,
        this.status,
        this.department,
    });

    factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        employeeId: json["employeeId"],
        deptId: json["deptId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        familyName: json["familyName"],
        familyNumber: json["familyNumber"],
        photos: json["photos"],
        phone: json["phone"],
        bloodType: json["bloodType"],
        hiredDate: DateTime.parse(json["hiredDate"]),
        status: json["status"],
        department: Department.fromJson(json["department"]),
    );

    Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "deptId": deptId,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "familyName": familyName,
        "familyNumber": familyNumber,
        "photos": photos,
        "phone": phone,
        "bloodType": bloodType,
        "hiredDate": "${hiredDate.year.toString().padLeft(4, '0')}-${hiredDate.month.toString().padLeft(2, '0')}-${hiredDate.day.toString().padLeft(2, '0')}",
        "status": status,
        "department": department.toJson(),
    };
}

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