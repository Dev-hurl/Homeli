import 'package:flutter/foundation.dart';
import 'package:homeli/core/routing/app_router.dart'; // wherever your existing `enum UserRole` lives

class UserRoleProvider extends ChangeNotifier {
  UserRole _activeRole = UserRole.seeker;
  UserRole get activeRole => _activeRole;

  void setRole(UserRole role) {
    if (_activeRole == role) return;
    _activeRole = role;
    notifyListeners();
  }
}