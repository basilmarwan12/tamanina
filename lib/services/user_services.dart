import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserService extends GetxService {
  Rxn<User> currentUser = Rxn<User>();

  Future<UserService> init() async {
    return this;
  }

  void login(User user) {
    currentUser.value = user;
  }

  void logout() {
    currentUser.value = null;
  }
}
