
import '../models/commentModel.dart';

CommentModel commentFake = CommentModel(
  "root",
  "",
  [CommentModel(
      "1",
      "1 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mauris in aliquam sem fringilla ut morbi tincidunt augue interdum. Tellus id interdum velit laoreet.",
      [
        CommentModel("11", "description 11", []),
        CommentModel("12", "description 12", [CommentModel("121","des",[CommentModel("121","des",[CommentModel("121","des",[])])])])
      ]
  ),
  CommentModel(
      "2",
      "2 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mauris in aliquam sem fringilla ut morbi tincidunt augue interdum. Tellus id interdum velit laoreet.",
      [
        CommentModel("21", "description 21", []),
        CommentModel("22", "description 22", [])
      ]
  ),
  CommentModel(
      "3",
      "3 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mauris in aliquam sem fringilla ut morbi tincidunt augue interdum. Tellus id interdum velit laoreet.",
      [
        CommentModel("31", "description 31", []),
        CommentModel("32", "description 32", [CommentModel("321","des 321",[])])
      ]
  ),
  CommentModel(
      "4",
      "4 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mauris in aliquam sem fringilla ut morbi tincidunt augue interdum. Tellus id interdum velit laoreet.v",
      [
        CommentModel("41", "description 41", []),
        CommentModel("42", "description 42", [CommentModel("4 21","des",[])])
      ]
  )]
);