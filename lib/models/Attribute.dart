// ignore: file_names
import 'dart:convert';

class Attribute {
  String? en;
  String? vn;
  Attribute({
    this.en,
    this.vn,
  });

  Attribute copyWith({
    String? en,
    String? vn,
  }) {
    return Attribute(
      en: en ?? this.en,
      vn: vn ?? this.vn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'en': en,
      'vn': vn,
    };
  }

  factory Attribute.fromMap(Map<String, dynamic> map) {
    return Attribute(
      en: map['en'] != null ? map['en'] as String : null,
      vn: map['vn'] != null ? map['vn'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Attribute.fromJson(String source) =>
      Attribute.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Attribute(en: $en, vn: $vn)';

  @override
  bool operator ==(covariant Attribute other) {
    if (identical(this, other)) return true;

    return other.en == en && other.vn == vn;
  }

  @override
  int get hashCode => en.hashCode ^ vn.hashCode;
}
