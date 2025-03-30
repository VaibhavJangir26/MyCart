class UserInfoModel {
  String? uuid;
  String? displayName;
  String? email;

  UserInfoModel({
    required this.uuid,
    required this.displayName,
    required this.email,
  });

  factory UserInfoModel.fromJson(Map<String,dynamic> json){
    return UserInfoModel(
        uuid: json['uuid'],
        displayName: json['displayName'],
        email: json['email']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'uuid': uuid,
      'displayName': displayName,
      'email': email,
    };
  }

}
