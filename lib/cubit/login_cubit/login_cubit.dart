import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailure(
            'No user found for that email.'
        ));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailure(
            'Wrong password provided for that user.'
        ));
      }
    } catch (e) {
      // TODO
      emit(LoginFailure(
          'An error occurred while trying to login'
      ));
    }
  }
}
