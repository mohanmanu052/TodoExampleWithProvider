import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? category;
  String? description;
  String? documentId;
  String? time;
  String? title;
  String? imageAsset;

  TodoModel(
      {this.category,
      this.description,
      this.documentId,
      this.imageAsset,
      this.time,
      this.title});

  factory TodoModel.fromJson(QueryDocumentSnapshot<Object?> json) {
    return TodoModel(
        category: json['category'],
        imageAsset: setImageAsset(json['category']),
        description: json['description'],
        time: json['time'],
        title: json['title'],
        documentId: json['documentId']);
  }

  static String setImageAsset(String categeoryType) {
    switch (categeoryType) {
      case 'Business':
        return 'assets/images/business.png';
      case 'Social':
        return 'assets/images/social.png';
      case 'Personal':
        return 'assets/images/personal.png';
      case 'Other':
        return 'assets/images/other.png';
    }
    return '';
  }
}
