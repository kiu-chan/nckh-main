class User {
  final String imagePath;
  final String name;
  final String email;
  final String phonenum;
  final String about;

  const User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.phonenum,
    required this.about,
  });

  User copy({
    String? imagePath,
    String? name,
    String? email,
    String? phonenum,
    String? about,
  }) =>
      User(
        imagePath: imagePath ?? this.imagePath,
        name: name ?? this.name,
        email: email ?? this.email,
        phonenum: phonenum ?? this.phonenum,
        about: about ?? this.about,
      );

  static User fromJson(Map<String, dynamic> json) => User(
      imagePath: json['imagePath'],
      name: json['name'],
      email: json['email'],
      phonenum: json['phonenum'],
      about: json['about']);

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'name': name,
        'email': email,
        'phonenum': phonenum,
        'about': about,
      };
}
