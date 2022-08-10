class CommentModel {
  String? commentId;
  List<CommentModel>? commentChildren;
  String? description;
  CommentModel(this.commentId, this.description,this.commentChildren);

}