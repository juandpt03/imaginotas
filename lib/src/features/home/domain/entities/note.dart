import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  final String id;
  final String title;
  final String content;
  final String category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;

  const NoteEntity({
    this.id = '',
    this.title = '',
    this.content = '',
    this.category = '',
    required this.createdAt,
    required this.updatedAt,

    this.userId = '',
  });

  factory NoteEntity.empty() =>
      NoteEntity(createdAt: DateTime.now(), updatedAt: DateTime.now());

  NoteEntity copyWith({
    String? id,
    String? title,
    String? content,
    String? category,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
  }) {
    return NoteEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
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
}
