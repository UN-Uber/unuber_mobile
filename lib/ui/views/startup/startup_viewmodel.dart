// Dart imports:
import 'dart:async';

// Package imports:
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/app/app.router.dart';
import 'package:unuber_mobile/services/api/user_crud_service.dart';
import 'package:unuber_mobile/services/secure_storage/secure_storage_service.dart';

/// The class StartupViewModel is the ViewModel for the startup route
class StartupViewModel extends BaseViewModel {
  /// Service used to navigate to other routes
  final _navigationService= locator<NavigationService>();
  /// Service used to encrypt and persist in some data
  final _secureStorageService= locator<SecureStorageService>();
  final _userCRUDService = locator<UserCRUDService>();

  StartupViewModel(){
    // Using a 3 seconds timer, then navigating to other route
    new Timer(const Duration(seconds: 3), _nextScreen);
    _userCRUDService.setMinInfo();
  }

  /// The method _isSessionActive is used to check if the device has a token previously stored
  Future<bool> _isSessionActive() async {
    String? token = await _secureStorageService.getStringValue(key: 'authToken');
    if (token != null){
      // token was stored
      if (!JwtDecoder.isExpired(token)){
        // token isn't expired
        return true;
      }
      else{
        // token expired
        await _secureStorageService.delete(key: 'authKey');
        await _secureStorageService.delete(key: 'userId');
        return false;
      }
    }

    return false;
  }

  /// The method _navigateToLogin is used to clear the widget tree and navigate to the login route
  Future _navigateToLogin() async {
    await _navigationService.clearStackAndShow(Routes.loginView);
  }

  /// The method _navigateToHome is used to clear the widget tree and navigate to the home route
  Future _navigateToHome() async {
    await _navigationService.clearStackAndShow(Routes.homeView);
  }

  /// The method _nextScreen is used to chose the next route to push into the widget tree
  _nextScreen() async {
    bool session= await _isSessionActive();
    if (!session){
      await _navigateToLogin();
    }
    else {
      await _navigateToHome();
    }
  }
}
