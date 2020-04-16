import 'dart:convert';

Report reportFromJson(String str) => Report.fromJson(json.decode(str));

String reportToJson(Report data) => json.encode(data.toJson());

class Report {
    String id;
    DateTime dateReport;
    dynamic inTime;
    String outTime;
    String employeeId;

    Report({
        this.id,
        this.dateReport,
        this.inTime,
        this.outTime,
        this.employeeId,
    });

    factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        dateReport: DateTime.parse(json["dateReport"]),
        inTime: json["inTime"],
        outTime: json["outTime"],
        employeeId: json["employeeId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dateReport": "${dateReport.year.toString().padLeft(4, '0')}-${dateReport.month.toString().padLeft(2, '0')}-${dateReport.day.toString().padLeft(2, '0')}",
        "inTime": inTime,
        "outTime": outTime,
        "employeeId": employeeId,
    };
}
