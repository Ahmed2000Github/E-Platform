class UserDto {
  final String email;
  final String password;

  UserDto({

    this.email,
    this.password,
  });


  factory UserDto.fromMap(Map<String, dynamic> json)=> new UserDto(

    email: json['email'],
    password: json['password'],
  );
  Map<String, dynamic> toMap() {
    return{

      'email': email,
      'password': password,
    };
  }

}

