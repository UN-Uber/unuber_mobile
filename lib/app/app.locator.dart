// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/api/auth_services.dart';
import '../services/api/credit_card_services.dart';
import '../services/api/user_crud_service.dart';
import '../services/data_transfer/credit_card_data_service.dart';
import '../services/secure_storage/secure_storage_service.dart';
import '../services/validations/credit_card_validation_service.dart';
import '../services/validations/login_validation_service.dart';
import '../services/validations/signup_validation_service.dart';

final locator = StackedLocator.instance;

void setupLocator({String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => LoginValidationService());
  locator.registerLazySingleton(() => CreditCardValidationService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => CreditCardService());
  locator.registerLazySingleton(() => SignupValidationService());
  locator.registerLazySingleton(() => SecureStorageService());
  locator.registerLazySingleton(() => CreditCardDataService());
  locator.registerLazySingleton(() => UserCRUDService());
}
