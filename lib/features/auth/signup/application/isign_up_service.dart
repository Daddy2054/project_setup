import 'package:project_setup/features/auth/signup/data/dto/sign_up_response.dart';

abstract class ISignUpService {
  Future<SignUpResponse> signUp(Map<String, dynamic> request);
}
