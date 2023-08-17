import 'User.dart';

class Ckeck {
User user;
String token;

Ckeck({required this.user, required this.token});

factory Ckeck.fromJson(Map<String, dynamic> json) {
return Ckeck(
user: User.fromJson(json['user']),
token: json['token'],
);
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['user'] = this.user.toJson();
data['token'] = this.token;
return data;
}
}