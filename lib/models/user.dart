class User {
  User({
    required this.fname,
    required this.lname,
    required this.email,
    required this.phoneNumber,
    required this.graduate,
  });
  final String fname;
  final String lname;
  final String email;
  final String phoneNumber;
  final String graduate;

  late final Map<String, String> mapOfUser = {
    'fname': fname,
    'lname': lname,
    'email': email,
    'phoneNumber': phoneNumber,
    'graduate': graduate
  };
}
