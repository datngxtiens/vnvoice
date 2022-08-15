class Comment {
  String? commentId;
  List<Comment>? commentChildren;
  String? description;

  Comment(this.commentId, this.description, this.commentChildren);
}