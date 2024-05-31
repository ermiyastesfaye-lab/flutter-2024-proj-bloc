// ignore_for_file: public_member_api_docs, sort_constructors_first
class UpdateUserDto {
  final String? email;
  final String? password;
  UpdateUserDto({
    this.email,
    this.password,
  });

  

  factory UpdateUserDto.fromJson(Map<String, dynamic> json) {
    return UpdateUserDto(
      email: json['email'].toString(),
      password: json['password'].toString()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password
    };
  }
}
