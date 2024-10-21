class Account {
  String email;
  String userName;

  Account(this.email, this.userName);

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userName': userName,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      map['email'],
      map['userName'],
    );
  }
}