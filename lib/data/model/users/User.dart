class User {
int id;
String firstName;
String lastName;
String? fatherName;
String? email;
String mobile;
String nationalCode;
String? idCode;
String birthday;
String? phone;
String? workPhone;
String uuid;
String? address;
String? workAddress;
bool isAdmin;
bool verified;
double wallet;
String createdAt;
String updatedAt;
String? deletedAt;
String fullName;

User({
required this.id,
required this.firstName,
required this.lastName,
required this.fatherName,
required this.email,
required this.mobile,
required this.nationalCode,
required this.idCode,
required this.birthday,
required this.phone,
required this.workPhone,
required this.uuid,
required this.address,
required this.workAddress,
required this.isAdmin,
required this.verified,
required this.wallet,
required this.createdAt,
required this.updatedAt,
required this.deletedAt,
required this.fullName,
});

factory User.fromJson(Map<String, dynamic> json) {
return User(
id: json['id'],
firstName: json['first_name'],
lastName: json['last_name'],
fatherName: json['father_name'],
email: json['email'],
mobile: json['mobile'],
nationalCode: json['national_code'],
idCode: json['id_code'],
birthday: json['birthday'],
phone: json['phone'],
workPhone: json['work_phone'],
uuid: json['uuid'],
address: json['address'],
workAddress: json['work_address'],
isAdmin: json['is_admin'],
verified: json['verified'],
wallet: json['wallet'],
createdAt: json['created_at'],
updatedAt: json['updated_at'],
deletedAt: json['deleted_at'],
fullName: json['full_name'],
);
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['id'] = this.id;
data['first_name'] = this.firstName;
data['last_name'] = this.lastName;
data['father_name'] = this.fatherName;
data['email'] = this.email;
data['mobile'] = this.mobile;
data['national_code'] = this.nationalCode;
data['id_code'] = this.idCode;
data['birthday'] = this.birthday;
data['phone'] = this.phone;
data['work_phone'] = this.workPhone;
data['uuid'] = this.uuid;
data['address'] = this.address;
data['work_address'] = this.workAddress;
data['is_admin'] = this.isAdmin;
data['verified'] = this.verified;
data['wallet'] = this.wallet;
data['created_at'] = this.createdAt;
data['updated_at'] = this.updatedAt;
data['deleted_at'] = this.deletedAt;
data['full_name'] = this.fullName;
return data;
}
}