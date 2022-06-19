// [UnivIt : Errouk Ismail]

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String token;
  final String email;
  final String password;
  final String type_user;

   User({
     this.id,
     this.firstName,
     this.lastName,
     this.username,
     this.token,
     this.email,
     this.password,
     this.type_user,
  });


   factory User.fromMap(Map<String, dynamic> json)=> new User(
     id: json['id'],
     firstName: json['firstName'],
     lastName: json['lastName'],
     username: json['username'],
     token: json['token'],
     email: json['email'],
     password: json['password'],
     type_user: json['type_user'],
   );
   Map<String, dynamic> toMap() {
     return{
       'id': id,
       'firstName':firstName,
       'lastName': lastName,
       'username': username,
       'token': token,
       'email': email,
       'password': password,
       'type_user': type_user,
     };
   }

}

