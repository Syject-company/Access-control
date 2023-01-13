abstract class LogInState {}

class LogInInitial extends LogInState {}

class AzureLoggedIn extends LogInState {}

class ErrorShown extends LogInState {
  ErrorShown({required this.error});

  final String error;
}

class UserDataErrorChecked extends LogInState {}
