// To parse this JSON data, do
//
//     final sectionsData = sectionsDataFromJson(jsonString);

import 'dart:convert';

List<SectionsData> sectionsDataFromJson(String str) => List<SectionsData>.from(json.decode(str).map((x) => SectionsData.fromJson(x)));

String sectionsDataToJson(List<SectionsData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SectionsData {
    String? id;
    String? v2Id;
    String? projectId;
    String? v2ProjectId;
    int? order;
    String? name;

    SectionsData({
        this.id,
        this.v2Id,
        this.projectId,
        this.v2ProjectId,
        this.order,
        this.name,
    });

    factory SectionsData.fromJson(Map<String, dynamic> json) => SectionsData(
        id: json["id"],
        v2Id: json["v2_id"],
        projectId: json["project_id"],
        v2ProjectId: json["v2_project_id"],
        order: json["order"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "v2_id": v2Id,
        "project_id": projectId,
        "v2_project_id": v2ProjectId,
        "order": order,
        "name": name,
    };
}
