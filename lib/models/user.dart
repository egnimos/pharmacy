class User {
  final String currency;
  final String secret;
  final String email;
  final String mobile;
  final String name;
  final String weight;
  final String height;
  final String age;
  final String bloodGroup;
  final String gender;
  final String image;
  final String referCode;
  final String? referFrom;

  User({
    this.currency = "INR",
    this.secret = "bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14",
    required this.email,
    required this.mobile,
    required this.age,
    required this.bloodGroup,
    required this.gender,
    required this.height,
    required this.name,
    required this.weight,
    required this.image,
    required this.referCode,
    this.referFrom,
  });

  factory User.fromJson(Map<String, dynamic> data) => User(
        email: data["email"],
        mobile: data["mobile"],
        age: data["age"].toString(),
        bloodGroup: data["bloodgroup"],
        gender: data["gender"],
        height: data["height"].toString(),
        name: data["name"],
        weight: data["weight"].toString(),
        image: data["image"] ?? "",
        referCode: data["refer_code"] ?? "",
        referFrom: data["refered_from"] ?? "",
      );

  Map<String, String> toJson() => {
        'currency': currency,
        'secret': secret,
        'email': email,
        'mobile': mobile,
        'name': name,
        'weight': weight,
        'height': height,
        'age': age,
        'bloodgroup': bloodGroup,
        'gender': gender,
        "image": image,
        "refered_from": referFrom ?? "",
        "refer_code": referCode,
      };

  // female ? 'female' : 'male'
}
