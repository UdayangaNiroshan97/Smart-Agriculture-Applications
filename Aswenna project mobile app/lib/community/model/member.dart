class Member {
  String id;
  String username;
  String email;

  Member(this.id, this.username, this.email);

  Member.fromJson(Map<String, dynamic> json)
  : id = json['id'],
    username = json['username'],
    email = json['email'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'username': username,
        'email': email,
      };
}
