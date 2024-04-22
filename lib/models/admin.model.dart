class AdminUserModel {
  final String authToken;
  final String name;
  final String email;

  AdminUserModel(
      {required this.authToken, required this.email, required this.name});
}
