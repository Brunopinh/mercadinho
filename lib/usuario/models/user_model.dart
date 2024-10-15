// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String? id;
  String? userName;
  String? email;
  String? password;
  String? phone;
  String? image; 
  UserModel({
    this.id,
    this.userName,
    this.email,
    this.password,
    this.phone,
    this.image,
  });

  UserModel copyWith({
    String? id,
    String? userName,
    String? email,
    String? password,
    String? phone,
    String? image,
  }) {
    return UserModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'email': email,
      'password': password,
      'phone': phone,
      'image': image,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, userName: $userName, email: $email, password: $password, phone: $phone, image: $image)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.userName == userName &&
      other.email == email &&
      other.password == password &&
      other.phone == phone &&
      other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userName.hashCode ^
      email.hashCode ^
      password.hashCode ^
      phone.hashCode ^
      image.hashCode;
  }
}
