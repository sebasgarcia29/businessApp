import 'dart:async';
import 'package:rxdart/rxdart.dart';

//Validations
import 'package:formvalidation/src/bloc/validators.dart';

class LoginBloc with Validators {
  // final _emailController = StreamController<String>.broadcast();
  // final _passwordController = StreamController<String>.broadcast();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Recuperar data del Stream
  Stream<String> get emailStream {
    return _emailController.stream.transform(validateEmail);
  }

  Stream<String> get passwordStream {
    return _passwordController.stream.transform(validatePassword);
  }

  //Combinar Strems

  Stream<bool> get formValidateStream => 
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);



  // Insert values al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;


  //Get Values strings

  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
