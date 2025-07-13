import 'authentication_client.dart';

class AuthenticationService {
  final AuthenticationClient authenticationClient;

  AuthenticationService({required this.authenticationClient});

  // Future<ResponseEntity<AuthenticateResponse?>> authenticate(
  //     LoginRequest request,
  //     ) async {
  //   return await authenticationClient.authenticate(request);
  // }
}