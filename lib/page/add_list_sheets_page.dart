import 'package:expense/api/sheets/addlistdheets_api.dart';
import 'package:expense/widget/add_list_form_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AddListSheetsPage extends StatefulWidget {
  const AddListSheetsPage({Key? key}) : super(key: key);

  @override
  _AddListSheetsPageState createState() => _AddListSheetsPageState();
}

class _AddListSheetsPageState extends State<AddListSheetsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API ADD LIST'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(22),
        child: AddListFormWidget(
          onSavedAddList: (list) async {
            final id = await AddListSheetsApi.getRowCount() + 1;
            final newList = list.copy(id: id);

            await AddListSheetsApi.insert([newList.toJson()]);
          },
        ),
      ),
    );
  }
}
