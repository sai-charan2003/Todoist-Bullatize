// To parse this JSON data, do
//
//     final tasksData = tasksDataFromJson(jsonString);

import 'dart:convert';

List<TasksData> tasksDataFromJson(String str) => List<TasksData>.from(json.decode(str).map((x) => TasksData.fromJson(x)));

String tasksDataToJson(List<TasksData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TasksData {
    String? creatorId;
    DateTime? createdAt;
    String? assigneeId;
    String? assignerId;
    int? commentCount;
    bool? isCompleted;
    String? content;
    String? description;
    Due? due;
    dynamic duration;
    String? id;
    List<String>? labels;
    int? order;
    int? priority;
    String? projectId;
    String? sectionId;
    String? parentId;
    String? url;

    TasksData({
        this.creatorId,
        this.createdAt,
        this.assigneeId,
        this.assignerId,
        this.commentCount,
        this.isCompleted,
        this.content,
        this.description,
        this.due,
        this.duration,
        this.id,
        this.labels,
        this.order,
        this.priority,
        this.projectId,
        this.sectionId,
        this.parentId,
        this.url,
    });

    factory TasksData.fromJson(Map<String, dynamic> json) => TasksData(
        creatorId: json["creator_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        assigneeId: json["assignee_id"],
        assignerId: json["assigner_id"],
        commentCount: json["comment_count"],
        isCompleted: json["is_completed"],
        content: json["content"],
        description: json["description"],
        due: json["due"] == null ? null : Due.fromJson(json["due"]),
        duration: json["duration"],
        id: json["id"],
        labels: json["labels"] == null ? [] : List<String>.from(json["labels"]!.map((x) => x)),
        order: json["order"],
        priority: json["priority"],
        projectId: json["project_id"],
        sectionId: json["section_id"],
        parentId: json["parent_id"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "creator_id": creatorId,
        "created_at": createdAt?.toIso8601String(),
        "assignee_id": assigneeId,
        "assigner_id": assignerId,
        "comment_count": commentCount,
        "is_completed": isCompleted,
        "content": content,
        "description": description,
        "due": due?.toJson(),
        "duration": duration,
        "id": id,
        "labels": labels == null ? [] : List<dynamic>.from(labels!.map((x) => x)),
        "order": order,
        "priority": priority,
        "project_id": projectId,
        "section_id": sectionId,
        "parent_id": parentId,
        "url": url,
    };
}

class Due {
    DateTime? date;
    bool? isRecurring;
    DateTime? datetime;
    String? string;
    String? timezone;

    Due({
        this.date,
        this.isRecurring,
        this.datetime,
        this.string,
        this.timezone,
    });

    factory Due.fromJson(Map<String, dynamic> json) => Due(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        isRecurring: json["is_recurring"],
        datetime: json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        string: json["string"],
        timezone: json["timezone"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "is_recurring": isRecurring,
        "datetime": datetime?.toIso8601String(),
        "string": string,
        "timezone": timezone,
    };
}
