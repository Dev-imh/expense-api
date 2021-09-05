import 'package:expense/model/user.dart';
import 'package:expense/widget/button_widget.dart';
import 'package:flutter/material.dart';

class UserFormWidget extends StatefulWidget {
  final ValueChanged<User> onSavedUser;

  const UserFormWidget({
    Key? key,
    required this.onSavedUser,
  }) : super(key: key);

  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerName;
  late TextEditingController controllerEmail;
  late TextEditingController controllerPassword;

  @override
  void initState() {
    super.initState();

    initUser();
  }

  void initUser() {
    controllerName = TextEditingController();
    controllerEmail = TextEditingController();
    controllerPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildName(),
            const SizedBox(height: 16),
            buildEmail(),
            const SizedBox(height: 16),
            buildPassword(),
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

  Widget buildEmail() => TextFormField(
        controller: controllerEmail,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: '@gmail.com',
          border: OutlineInputBorder(),
        ),
        validator: (value) => 
        value != null && !value.contains('@') ? 'Enter Email @ ' : null,
      );

  Widget buildPassword() => TextFormField(
        controller: controllerPassword,
        decoration: InputDecoration(
          labelText: 'Password',
          hintText: '******',
          border: OutlineInputBorder(),
        ),
         validator: (value) => 
        value != null && value.isEmpty ? 'Enter Email' : null,
      );

  Widget buildSubmit() => ButtonWidget(
        text: 'Save',
        onClicked: () {
          final form = formKey.currentState!;
          final isValid = form.validate();

          if (isValid) {
            final user = User(
              name: controllerName.text,
              email: controllerEmail.text,
              password: controllerPassword.text,
            );
            widget.onSavedUser(user);
          }
        },
      );
}
