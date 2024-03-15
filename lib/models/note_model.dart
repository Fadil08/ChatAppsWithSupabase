class Notes {
  int? id;
  String title;
  String description;
  // String? date;
  String? name;

  Notes({
    this.id,
    required this.title,
    required this.description,
    // this.date,
    this.name,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        // // date: json["date"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        // // "date": date,
        "name": name,
      };

  Notes copyWith({
    int? id,
    String? title,
    String? description,
    // String? date,
    String? name,
  }) {
    return Notes(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      // // // date: date ?? this.date,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      // // 'date': date,
      'name': name,
    };
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      // // date: map['date'] as String,
      name: map['name'] as String,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Notes.fromJson(String source) => Notes.fromMap(json.decode(source) as Map<String, dynamic>);
}
