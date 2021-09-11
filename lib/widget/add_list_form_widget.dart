import 'package:expense/model/addlist.dart';
import 'package:expense/widget/button_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddListFormWidget extends StatefulWidget {
  final ValueChanged<AddList> onSavedAddList;

  const AddListFormWidget({
    Key? key,
    required this.onSavedAddList,
  }) : super(key: key);

  @override
  _AddListFormWidgetState createState() => _AddListFormWidgetState();
}

class _AddListFormWidgetState extends State<AddListFormWidget> {

bool value = false;
int val = -1;

  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerName;
  late TextEditingController controllerAmount;
  late TextEditingController controllercategory;

  @override
  void initState() {
    super.initState();

    initAddList();
  }

  void initAddList() {
    controllerName = TextEditingController();
    controllerAmount = TextEditingController();
    controllercategory = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildName(),
            const SizedBox(height: 16),
            buildAmount(),
            const SizedBox(height: 16),
            buildCategory(),
            const SizedBox(height: 16),
            buildSubmit(),
          ],
        ),
      );

  Widget buildName() => TextFormField(
        controller: controllerName,
        decoration: InputDecoration(
          labelText: 'Name',
          hintText: 'name',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Name' : null,
      );

  Widget buildAmount() => TextFormField(
        controller: controllerAmount,
        decoration: InputDecoration(
          labelText: 'Amount',
          hintText: 'บาท',
          border: OutlineInputBorder(),
        ),
        // validator: (value) =>
        // value != null && !value.contains('@') ? 'Enter Email @ ' : null,
      );

  Widget buildCategory() => ListTile(
                title: Text("Male"),
                leading: Radio(
                  value: 1,
                  groupValue: val,
                  onChanged: (value) {
                    setState(() {
                      // val = value;
                    });
                  },
                  activeColor: Colors.green,
                ),
              );

  Widget buildSubmit() => ButtonWidget(
        text: 'Save',
        onClicked: () {
          final form = formKey.currentState!;
          final isValid = form.validate();

          if (isValid) {
            final list = AddList(
              name: controllerName.text,
              amount: controllerAmount.text,
            );
            widget.onSavedAddList(list);
          }
        },
      );
}
