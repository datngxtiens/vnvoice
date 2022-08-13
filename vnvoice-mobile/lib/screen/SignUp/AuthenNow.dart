import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vnvoicemobile/provider/userProvider.dart';
import 'package:vnvoicemobile/screen/Home/Feed.dart';

import '../../Widgets/textFieldInput.dart';
import '../../models/userModel.dart';
import '../Home/Home.dart';
import 'UploadID.dart';

class AuthenNowScreen extends StatefulWidget {
  final email;
  const AuthenNowScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<AuthenNowScreen> createState() => _AuthenNowScreenState();
}

class _AuthenNowScreenState extends State<AuthenNowScreen> {
  TextEditingController _channelController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    User cuurentUser = User(email: widget.email);
    userProvider.setUser(cuurentUser);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color.fromRGBO(218, 81, 82, 1),),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            children: [
              Text(
                "Bạn có muốn xác thực tài khoản ngay bây giờ để tận hưởng đầy đủ tính năng của ứng dụng không?",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  letterSpacing: 1.3,

                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context)=> const UploadIDScreen()
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: const Text("Xác thực",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 22),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      color: Color.fromRGBO(218, 81, 82, 1),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context)=> const MobileScreenLayout()
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: const Text("Thực hiện sau",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 22),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      color: Color.fromRGBO(218, 81, 82, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
