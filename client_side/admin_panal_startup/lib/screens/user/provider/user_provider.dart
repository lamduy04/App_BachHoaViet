import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/api_response.dart';
import '../../../models/user.dart';
import '../../../services/http_services.dart';
import '../../../utility/snack_bar_helper.dart';

class UserProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final addUserFormKey = GlobalKey<FormState>();
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController userCtrl = TextEditingController();

  User? userForUpdate;



  UserProvider(this._dataProvider);



  //TODO: should complete addUser
  void addUser() async {
    try {
      String name = userNameCtrl.text.trim(); // Lấy giá trị nhập vào từ TextField
      String password = userCtrl.text; // Lấy giá trị nhập vào từ TextField

      // Kiểm tra định dạng email
      if (!isValidEmail(name)) {
        SnackBarHelper.showErrorSnackBar('Email không hợp lệ. Vui lòng nhập đúng định dạng email!');
        return;
      }

      Map<String, dynamic> user = {
        'name': name,
        'password': password,
      };

      final response = await service.addItem(endpointUrl: 'users/register', itemData: user);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          _dataProvider.getAllUser();
          log('Thêm thành công!');
        } else {
          SnackBarHelper.showErrorSnackBar('Thêm thất bại: ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar('Lỗi: ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('Đã có lỗi xảy ra: $e');
      rethrow;
    }
  }

// Hàm kiểm tra định dạng email
  bool isValidEmail(String email) {
    // Sử dụng biểu thức chính quy để kiểm tra định dạng email
    // Đây là một phần mềm chính quy đơn giản để kiểm tra định dạng email
    // Bạn có thể sử dụng biểu thức chính quy phức tạp hơn để kiểm tra nếu cần thiết
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  //TODO: should complete updateUser
  void updateUser() async {
    try {
      String name = userNameCtrl.text.trim(); // Lấy giá trị nhập vào từ TextField
      String password = userCtrl.text; // Lấy giá trị nhập vào từ TextField

      // Kiểm tra định dạng email
      if (!isValidEmail(name)) {
        SnackBarHelper.showErrorSnackBar('Email không hợp lệ. Vui lòng nhập đúng định dạng email!');
        return;
      }

      Map<String, dynamic> user = {
        'name': name,
        'password': password,
      };

      final response = await service.updateItem(endpointUrl: 'users', itemData: user, itemId: userForUpdate?.sId ?? '');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          _dataProvider.getAllUser();
          log('Sửa Thành công!');

        } else {
          SnackBarHelper.showErrorSnackBar('Thêm thất bại: ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar('Lỗi: ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
    }
  }

  //TODO: should complete submitUser
  submitUser(){
    if (userForUpdate != null){
      updateUser();
    }else{
      addUser();
    }
  }

  //TODO: should complete deleteUser
  deleteUser(User user) async {
    try {
      Response response = await service.deleteItem(endpointUrl: 'users', itemId: user.sId ?? '');

      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar('Xoá thành công!');
          _dataProvider.getAllUser();

        }
      } else {
        SnackBarHelper.showErrorSnackBar('Error ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  setDataForUpdateUser(User? user) {
    if (user != null) {
      userForUpdate = user;
      userNameCtrl.text = user.name ?? '';
      userCtrl.text = user.password ?? '';
    } else {
      clearFields();
    }
  }

  clearFields() {
    userNameCtrl.clear();
    userCtrl.clear();
    userForUpdate = null;
  }
}
