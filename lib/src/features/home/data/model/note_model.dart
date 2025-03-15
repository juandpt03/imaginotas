import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imaginotas/src/features/home/domain/entities/note.dart';

class NoteModel implements NoteEntity {
  @override
  final String id;

  @override
  final String title;

  @override
  final String content;

  @override
  final String category;

  @override
  final DateTime createdAt;

  @override
  final DateTime updatedAt;

  @override
  final String userId;

  const NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json, String noteId) {
    return NoteModel(
      id: noteId,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      category: json['category'] ?? '',
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      userId: json['userId'] ?? '',
    );
  }

  factory NoteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      return NoteModel(
        id: doc.id,
        title: '',
        content: '',
        category: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        userId: '',
      );
    }

    return NoteModel.fromJson(data, doc.id);
  }

  factory NoteModel.fromEntity(NoteEntity note) {
    return NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      category: note.category,
      createdAt: note.createdAt,
      updatedAt: note.updatedAt,
      userId: note.userId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'category': category,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'userId': userId,
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    content,
    category,
    createdAt,
    updatedAt,
    userId,
  ];

  @override
  bool? get stringify => true;

  @override
  NoteEntity copyWith({
    String? id,
    String? title,
    String? content,
    String? category,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
  }
}
