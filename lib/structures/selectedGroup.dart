


class SlectedGroup {

  late int id;
  late String createdAt;
  late int postId;
  late List<dynamic> messages;
  late bool active;

  SlectedGroup(
      {required this.id,
        required this.createdAt,
        required this.postId,
        required this.messages,
        required this.active,
      });

  SlectedGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    postId = json['postId'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages.add(new Messages.fromJson(v));
      });
    }
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['postId'] = this.postId;
    if (this.messages != null) {
      data['messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    data['active'] = this.active;
    return data;
  }
}


class Messages {

  late int id;
  late String createdAt;
  late String createdBy;
  late String content;


  Messages({required this.id, required this.createdAt, required this.createdBy, required this.content});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['content'] = this.content;
    return data;
  }


}