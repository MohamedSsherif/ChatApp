import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_cubit_state.dart';

class RegisterCubitCubit extends Cubit<RegisterCubitState> {
  RegisterCubitCubit() : super(RegisterCubitInitial());


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
}
