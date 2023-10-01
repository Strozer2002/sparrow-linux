class AuthCredentials {
  final String token;
  final String subdomain;
  final String role;

  const AuthCredentials({
    required this.token,
    required this.subdomain,
    required this.role,
  });
}
