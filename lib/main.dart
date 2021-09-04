import 'package:expense/api/sheets/user_sheets_api.dart';
import 'package:expense/page/create_sheets_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserSheetsApi.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CreateSheetsPage(),
    );
  }
}

// class Container extends StatefulWidget {
//   const Container({ Key? key }) : super(key: key);

//   @override
//   _ContainerState createState() => _ContainerState();
// }

// class _ContainerState extends State<Container> {
//   @override
//   Widget build(BuildContext context) {
//     return CreateSheetsPage();
//   }
// }