class AppUser {
  final String uid;
  final DateTime created;
  final String email;
  final String displayName;
  final String password;

  AppUser({
    this.uid,
    this.created,
    this.email,
    this.displayName,
    this.password,
  });
  AppUser.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        created = data['created'],
        email = data['email'],
        displayName = data['displayName'],
        password = data['password'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'created': created,
      'email': email,
      'displayName': displayName,
      'password': password,
    };
  }
}
