class LoginUsuario {
  final String username;
  final String password;
  final String token;

  LoginUsuario(this.username, this.password, {this.token});

  factory LoginUsuario.fromJson(Map<String, dynamic> json) {
    return LoginUsuario(json['nombreUsuario'] as String, 'password',
        token: json['token'] as String);
  }
}
