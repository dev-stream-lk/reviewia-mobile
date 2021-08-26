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
        required this.blocked});

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
    return data;
  }
}