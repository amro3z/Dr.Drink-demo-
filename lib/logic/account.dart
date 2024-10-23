class Account {
  String? email;
  String? userName;
  String photoURL = '';

  Account({this.email, this.userName, this.photoURL = ''});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userName': userName,
      'photoURL': photoURL,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      email: map['email'],
      userName: map['userName'],
      photoURL: map['photoURL'],
    );
  }
}