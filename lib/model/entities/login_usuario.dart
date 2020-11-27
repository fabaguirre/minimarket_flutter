class LoginUsuario {
  final String username;
  final String password;
  final String token;

  LoginUsuario(this.username, this.password, {this.token});

  factory LoginUsuario.fromJson(Map<String, dynamic> json) {
    return LoginUsuario(json['nombreUsuario'] as String, 'password',
        token: json['token'] as String);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginUsuario &&
          username.compareTo(other.username) == 0 &&
          password.compareTo(other.password) == 0 &&
          token.compareTo(other.token) == 0;

  @override
  int get hashCode => username.hashCode ^ password.hashCode ^ token.hashCode;
}
