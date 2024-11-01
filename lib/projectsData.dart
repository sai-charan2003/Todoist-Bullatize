// To parse this JSON data, do
//
//     final projectsData = projectsDataFromJson(jsonString);

import 'dart:convert';

List<ProjectsData> projectsDataFromJson(String str) => List<ProjectsData>.from(json.decode(str).map((x) => ProjectsData.fromJson(x)));

String projectsDataToJson(List<ProjectsData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectsData {
    String? id;
    dynamic parentId;
    int? order;
    String? color;
    String? name;
    int? commentCount;
    bool? isShared;
    bool? isFavorite;
    bool? isInboxProject;
    bool? isTeamInbox;
    String? url;
    String? viewStyle;

    ProjectsData({
        this.id,
        this.parentId,
        this.order,
        this.color,
        this.name,
        this.commentCount,
        this.isShared,
        this.isFavorite,
        this.isInboxProject,
        this.isTeamInbox,
        this.url,
        this.viewStyle,
    });

    factory ProjectsData.fromJson(Map<String, dynamic> json) => ProjectsData(
        id: json["id"],
        parentId: json["parent_id"],
        order: json["order"],
        color: json["color"],
        name: json["name"],
        commentCount: json["comment_count"],
        isShared: json["is_shared"],
        isFavorite: json["is_favorite"],
        isInboxProject: json["is_inbox_project"],
        isTeamInbox: json["is_team_inbox"],
        url: json["url"],
        viewStyle: json["view_style"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "order": order,
        "color": color,
        "name": name,
        "comment_count": commentCount,
        "is_shared": isShared,
        "is_favorite": isFavorite,
        "is_inbox_project": isInboxProject,
        "is_team_inbox": isTeamInbox,
        "url": url,
        "view_style": viewStyle,
    };
}
