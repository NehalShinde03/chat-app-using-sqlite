class UserModel{

  final int? userId;
  final String? userName;
  final String? userPassword;
  final String? userCreationTime;

  UserModel({this.userId, this.userName, this.userPassword,this.userCreationTime});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      userId: json['userId'],
      userName: json['userName'],
      userPassword: json['userPassword'],
     userCreationTime: json['userCreationTime'],
  );

  Map<String, dynamic> toJson() => {
    'userId':userId,
    'userName':userName,
    'userPassword':userPassword,
    'userCreationTime':userCreationTime,
  };

}
