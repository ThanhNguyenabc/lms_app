// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class History {
  String userName;
  History({
    required this.userName,
  });

  History copyWith({
    String? userName,
  }) {
    return History(
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
    };
  }

  factory History.fromMap(Map<String, dynamic> map) {
    return History(
      userName: map['userName'] as String,
    );
  }

  String toJson() => json.encode(toMap());
 
  factory History.fromJson(String source) => History.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'History(userName: $userName)';

  @override
  bool operator ==(covariant History other) {
    if (identical(this, other)) return true;
  
    return 
      other.userName == userName;
  }

  @override
  int get hashCode => userName.hashCode;
}
