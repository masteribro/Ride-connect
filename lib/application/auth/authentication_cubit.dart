import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/auth/authentication_service.dart';
import 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationService authenticationService;

  AuthenticationCubit(this.authenticationService)
      : super(AuthenticationStateUninitialized());
}