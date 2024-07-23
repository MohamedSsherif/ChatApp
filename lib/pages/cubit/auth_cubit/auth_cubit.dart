import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

    Future<void> registerUser({required String email, required String password}) async {

    emit(RegisterCubitLoading());
    try{
      UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterCubitSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(RegisterCubitFailure('The password provided is too weak.'));
      } else if (ex.code == 'email-already-in-use') {
        emit(RegisterCubitFailure('The account already exists for that email.'));
      }
    } catch (e) {
      emit(RegisterCubitFailure('An error occurred while trying to register'));
    }
    }

    
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
