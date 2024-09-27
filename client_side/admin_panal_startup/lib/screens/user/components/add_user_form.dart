import 'package:admin/utility/extensions.dart';

import '../../../models/user.dart';
import 'package:flutter/material.dart';
import '../../../utility/constants.dart';
import '../../../widgets/custom_text_field.dart';

class UserSubmitForm extends StatelessWidget {
  final User? user;

  const UserSubmitForm({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.userProvider.setDataForUpdateUser(user);
    return SingleChildScrollView(
      child: Form(
        key: context.userProvider.addUserFormKey,
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          width: size.width * 0.5,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: context.userProvider.userNameCtrl,
                      labelText: 'Tên tài khoản',
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Hãy thêm tên tài khoản';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: context.userProvider.userCtrl,
                      labelText: 'Mật khẩu',
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Hãy thêm mật khẩu';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: defaultPadding * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: secondaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the popup
                    },
                    child: Text('Huỷ'),
                  ),
                  SizedBox(width: defaultPadding),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      // Validate and save the form
                      if (context.userProvider.addUserFormKey.currentState!.validate()) {
                        context.userProvider.addUserFormKey.currentState!.save();
                        //TODO: should complete call submitUser
                        context.userProvider.submitUser();
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Xác nhận'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// How to show the category popup
void showAddUserForm(BuildContext context, User? user) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(child: Text('Thêm tài khoản'.toUpperCase(), style: TextStyle(color: primaryColor))),
        content: UserSubmitForm(user: user),
      );
    },
  );
}
