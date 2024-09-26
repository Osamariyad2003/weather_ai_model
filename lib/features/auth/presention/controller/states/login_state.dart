
abstract class SignInStates{}

class SignInInitialState extends SignInStates{}
class SignInLoadingState extends SignInStates{}
class SignInSuccessState extends SignInStates {


}
class SignInErrorState extends SignInStates{
  final String error;
  SignInErrorState(this.error);
}



class SeePassState extends SignInStates{}


class ChangePasswordState extends SignInStates{

}
class LoadingPasswordState extends SignInStates{}
class ErrorPasswordState extends SignInStates{
  final String error;
  ErrorPasswordState(this.error);
}