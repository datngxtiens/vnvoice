
import '../models/comment.dart';

Comment commentFake = Comment(
  "root",
  "",
  [Comment(
      "1",
      "1 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mauris in aliquam sem fringilla ut morbi tincidunt augue interdum. Tellus id interdum velit laoreet.",
      [
        Comment("11", "description 11", []),
        Comment("12", "description 12", [Comment("121","des",[Comment("121","des",[Comment("121","des",[])])])])
      ]
  ),
  Comment(
      "2",
      "2 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mauris in aliquam sem fringilla ut morbi tincidunt augue interdum. Tellus id interdum velit laoreet.",
      [
        Comment("21", "description 21", []),
        Comment("22", "description 22", [])
      ]
  ),
  Comment(
      "3",
      "3 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mauris in aliquam sem fringilla ut morbi tincidunt augue interdum. Tellus id interdum velit laoreet.",
      [
        Comment("31", "description 31", []),
        Comment("32", "description 32", [Comment("321","des 321",[])])
      ]
  ),
  Comment(
      "4",
      "4 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mauris in aliquam sem fringilla ut morbi tincidunt augue interdum. Tellus id interdum velit laoreet.v",
      [
        Comment("41", "description 41", []),
        Comment("42", "description 42", [Comment("4 21","des",[])])
      ]
  )]
);