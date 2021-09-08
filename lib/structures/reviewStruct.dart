class ReviewStruct {
  late int reviewId;
  late String reviewedBy;
  late String email;
  late int postId;
  late String createdAt;
  late String description;
  late double userRate;
  late int likeCount;
  late int dislikeCount;
  late int reportCount;
  late double sentimentRate;
  late double finalRate;
  late bool blocked;
  late List<DislikedList> dislikedList;
  late List<LikedList> likedList;

  ReviewStruct(
      {required this.reviewId,
        required this.reviewedBy,
        required this.email,
        required this.postId,
        required this.createdAt,
        required this.description,
        required this.userRate,
        required this.likeCount,
        required this.dislikeCount,
        required this.reportCount,
        required this.sentimentRate,
        required this.finalRate,
        required this.blocked,
        required this.likedList,
        required this.dislikedList});

  ReviewStruct.fromJson(Map<String, dynamic> json) {
    reviewId = json['reviewId'];
    reviewedBy = json['reviewedBy'];
    email = json['email'];
    postId = json['postId'];
    createdAt = json['createdAt'];
    description = json['description'];
    userRate = json['userRate'];
    likeCount = json['likeCount'];
    dislikeCount = json['dislikeCount'];
    reportCount = json['reportCount'];
    sentimentRate = json['sentimentRate'];
    finalRate = json['finalRate'];
    blocked = json['blocked'];
    if (json['dislikedList'] != null) {
      dislikedList = <DislikedList>[];
      json['dislikedList'].forEach((v) {
        dislikedList.add(new DislikedList.fromJson(v));
      });
    }
    if (json['likedList'] != null) {
      likedList =  <LikedList>[];
      json['likedList'].forEach((v) {
        likedList.add(new LikedList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reviewId'] = this.reviewId;
    data['reviewedBy'] = this.reviewedBy;
    data['email'] = this.email;
    data['postId'] = this.postId;
    data['createdAt'] = this.createdAt;
    data['description'] = this.description;
    data['userRate'] = this.userRate;
    data['likeCount'] = this.likeCount;
    data['dislikeCount'] = this.dislikeCount;
    data['reportCount'] = this.reportCount;
    data['sentimentRate'] = this.sentimentRate;
    data['finalRate'] = this.finalRate;
    data['blocked'] = this.blocked;
    if (this.dislikedList != null) {
      data['dislikedList'] = this.dislikedList.map((v) => v.toJson()).toList();
    }
    if (this.likedList != null) {
      data['likedList'] = this.likedList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LikedList {
  late String email;

  LikedList({required this.email});

  LikedList.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}


class DislikedList {
  late String email;

  DislikedList({required this.email});

  DislikedList.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}
