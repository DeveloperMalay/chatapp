class MessageModel {
  String? sender;
  String? text;
  bool? seen;
  DateTime? createdon;

//default constructor
  MessageModel({this.createdon, this.seen, this.sender, this.text});

//converting firebase_json data to map and then cenvert this into a object
  MessageModel.fromMap(Map<String, dynamic> map) {
    sender = map['sender'];
    text = map['text'];
    seen = map['seen'];
    createdon = map['createdon'];
  }
// converting data_object form app to convert it to a map and then json 
  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'seen': seen,
      'text': text,
      'createdon': createdon
    };
  }
}
