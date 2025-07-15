import 'package:get_it/get_it.dart';

import 'domain/auth/authentication_client.dart';
import 'domain/auth/authentication_service.dart';

var getIt = GetIt.instance;

class IoC{
  void initServices() {
    getIt.registerSingleton(
      AuthenticationService(
        authenticationClient: AuthenticationClient(),
      ),
    );}
}