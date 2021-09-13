class ChatListStruct {
  late int id;
  late String createdAt;
  late int postId;
  late CreatedBy createdBy;
  late bool active;

  ChatListStruct(
      {required this.id,
        required this.createdAt,
        required this.postId,
        required this.createdBy,
        required this.active});

  ChatListStruct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    postId = json['postId'];
    createdBy = (json['createdBy'] != null
        ? new CreatedBy.fromJson(json['createdBy'])
        : null)!;
    // if (json['users'] != null) {
    //   users = <Users>[];
    //   json['users'].forEach((v) {
    //     users.add(new Users.fromJson(v));
    //   });
    // }
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['postId'] = this.postId;
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy.toJson();
    }
    // if (this.users != null) {
    //   data['users'] = this.users.map((v) => v.toJson()).toList();
    // }
    // if (this.messages != null) {
    //   data['messages'] = this.messages.map((v) => v.toJson()).toList();
    // }
    data['active'] = this.active;
    return data;
  }
}

class CreatedBy {
  late int id;
  late String firstName;
  late String lastName;
  late String email;

  CreatedBy(
      {required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;

    return data;
  }
}
// class Users {
//   late int id;
//   late String firstName;
//   late String lastName;
//   late String email;
//
//   Users(
//       {required this.id,
//         required this.firstName,
//         required this.lastName,
//         required this.email});
//
//   Users.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     firstName = json['firstName'];
//     lastName = json['lastName'];
//     email = json['email'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['firstName'] = this.firstName;
//     data['lastName'] = this.lastName;
//     data['email'] = this.email;
//
//     return data;
//   }
// }
