class ChatroomModel {
  String? classroomid;
  List<String>? partcipants;

  //default constructor
  ChatroomModel({this.classroomid, this.partcipants});


//converting firebase_json data to map and then cenvert this into a object 
  ChatroomModel.fromMap(Map<String, dynamic> map) {
    classroomid = map['classroomid'];
    partcipants = map['participants'];
  }

  Map<String, dynamic> toMap() {
    return {
      'classroomid': classroomid,
      'participants': partcipants,
    };
  }
}
