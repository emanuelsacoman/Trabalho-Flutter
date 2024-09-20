class Login{
   String? email;
   String? password;

   Login({this.email, this.password});

   Map tojson(){
    return {
      'email': email,
      'password': password,
    };
   }

   Login.fromJson(Map<String, dynamic> json){
    email = json['email'];
    password = json['password'];
   }
}