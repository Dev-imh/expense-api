import 'package:expense/api/sheets/user_sheets_api.dart';
import 'package:expense/model/user.dart';
import 'package:expense/widget/button_widget.dart';
import 'package:expense/widget/user_form_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateSheetsPage extends StatefulWidget {
  const CreateSheetsPage({Key? key}) : super(key: key);

  @override
  _CreateSheetsPageState createState() => _CreateSheetsPageState();
}

class _CreateSheetsPageState extends State<CreateSheetsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(22),
        child: UserFormWidget(
          onSavedUser: (user) async {
            final id = await UserSheetsApi.getRowCount() + 1;
            final newUser = user.copy(id: id);

            await UserSheetsApi.insert([newUser.toJson()]);
          },
        ),
      ),
    );
  }

  // Future insertUsers() async {
  //   final users = [
  //     User(id: 1, name: 'lenoi', email: 'lenoi@gmail.com', password: '123456'),
  //     User(id: 2, name: 'lenoi2', email: 'lenoi2@gmail.com', password: '123456'),
  //     User(id: 3, name: 'lenoi3', email: 'lenoi3@gmail.com', password: '123456'),
  //     User(id: 4, name: 'lenoi4', email: 'lenoi4@gmail.com', password: '123456'),
  //     User(id: 5, name: 'lenoi5', email: 'lenoi5@gmail.com', password: '123456'),
  //   ];
  //   final jsonUsers = users.map((user) => user.toJson()).toList();

  //   await UserSheetsApi.insert(jsonUsers);
  // }
}
