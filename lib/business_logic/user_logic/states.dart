abstract class UserStates {}

class InitialState extends UserStates {}

class ShowAndHidePassword extends UserStates {}

class RegisterLoadingState extends UserStates {}

class RegisterSuccessState extends UserStates {}

class RegisterFailedState extends UserStates {
  final String error;

  RegisterFailedState(this.error);
}

class LoginLoadingState extends UserStates {}

class LoginSuccessState extends UserStates {
  final String uid;

  LoginSuccessState(this.uid);
}

class LoginFailedState extends UserStates {
  final String error;

  LoginFailedState(this.error);
}

class googleLoadingState extends UserStates {}

class googleSuccessState extends UserStates {
  final String uid;

  googleSuccessState(this.uid);
}

class googleFailedState extends UserStates {
  final String error;

  googleFailedState(this.error);
}

class createUserSuccessState extends UserStates {}

class createUserFailedState extends UserStates {
  final String error;

  createUserFailedState(this.error);
}

class forgetpasswordsucess extends UserStates {}

class forgetpasswordFaield extends UserStates {
  final String error;

  forgetpasswordFaield(this.error);
}

class admin extends UserStates {}
