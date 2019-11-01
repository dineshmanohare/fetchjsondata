class User {
  final String login;
  final String id;
  final String avatar;

  User({
    this.login,
    this.id,
    this.avatar,
  });
  factory User.fromData(Map<String, dynamic> data) {
    return User(
      login: data['login'],
      id: data['id'].toString(),
      avatar: data['avatar_url'],
    );
  }
}
