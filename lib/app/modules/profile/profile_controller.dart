import 'package:get/get.dart';
import 'package:zegen_test_app/app/models/user_model.dart';

class ProfileController extends GetxController {
  final Rxn<UserModel> user = Rxn<UserModel>();

  bool get isLoggedIn => user.value != null;

  void setUser(UserModel u) {
    user.value = u;
    print('UDAH BERUBAH ${user.value?.toJson()}');
    print(isLoggedIn ? "ISI" : "KOSONG");
  }

  void setUserFromMap(Map<String, dynamic> data) {
    user.value = UserModel.fromJson(data);
    print('UDAH BERUBAH ${user.value?.toJson()}');
    print(isLoggedIn ? "ISI" : "KOSONG");
  }

  void clearUser() {
    user.value = null;
    print('UDAH HAPUS ${user.value?.toJson()}');
  }
}
