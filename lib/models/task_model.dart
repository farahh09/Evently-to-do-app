class TaskModel {
  String title;
  String description;
  String id;
  String category;
  int date;
  int time;
  String userId;
  bool isFavorite;

  TaskModel({
    required this.title,
    required this.description,
    this.id = '',
    required this.category,
    this.isFavorite = false,
    required this.date,
    required this.time,
    required this.userId,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
    : this(
        title: json['title'],
        description: json['description'],
        id: json['id'],
        category: json['category'],
        isFavorite: json['isFavorite'],
        date: json['date'],
        time: json['time'],
        userId: json['userId'],
      );

  Map<String, Object> toJson() {
    return {
      'title': title,
      'description': description,
      'id': id,
      'category': category,
      'isFavorite': isFavorite,
      'date': date,
      'time': time,
      'userId': userId
    };
  }
}
