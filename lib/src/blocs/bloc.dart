import 'dart:async';
import 'package:login_bloc/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc with Validators {
  final BehaviorSubject _email = BehaviorSubject<String>();
  final BehaviorSubject _password = BehaviorSubject<String>();

  // Add data to the stream.
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  // Retrieve data from the stream.
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, password, (e, p) => true);

  submit() {
    final validEmail = _email.value;
    final validPassword = _password.value;

    print('email $validEmail');
    print('email $validPassword');
  }

  dispose() {
    _email.close();
    _password.close();
  }
}
