class NotificationStruct {
  late int id;
  late String content;
  late int targetId;
  late String type;
  late String createdAt;
  late bool markAsRead;
  late String createdFor;

  NotificationStruct(
      {required this.id,
       required  this.content,
       required  this.targetId,
       required  this.type,
       required  this.createdAt,
       required  this.markAsRead,
       required  this.createdFor});

  NotificationStruct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    targetId = json['targetId'];
    type = json['type'];
    createdAt = json['createdAt'];
    markAsRead = json['markAsRead'];
    createdFor = json['createdFor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['targetId'] = this.targetId;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['markAsRead'] = this.markAsRead;
    data['createdFor'] = this.createdFor;
    return data;
  }
}