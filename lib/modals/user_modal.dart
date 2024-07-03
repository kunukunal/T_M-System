class UserModel {
  int? userId;
  String? name;
  String? email;
  String? image;
  int? planId;
  int? planExpired;
  String? token;
  String? tokenExpireAt;

  UserModel({
    required this.userId,
    required this.name,
    this.email,
    this.image,
    this.planId,
    this.planExpired,
    required this.token,
    this.tokenExpireAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    planId = json['plan_id'];
    planExpired = json['plan_expired'];
    token = json['authToken'];
    tokenExpireAt = json['expiresAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['image'] = image;
    data['plan_id'] = planId;
    data['plan_expired'] = planExpired;
    data['authToken'] = token;
    data['expiresAt'] = tokenExpireAt;

    return data;
  }
}
