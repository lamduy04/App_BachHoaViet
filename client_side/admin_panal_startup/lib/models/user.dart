class User {
  String? name;
  String? password;
  String? sId;
  String? createdAt;
  String? updatedAt;

  User(
      {this.name,
        this.password,
        this.sId,
        this.createdAt,
        this.updatedAt,
        });

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    password = json['password'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['password'] = this.password;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}