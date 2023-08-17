abstract class CheckLoginEvent {}

class CheckLoginInitEvent extends CheckLoginEvent{}

class CheckLoginButtonClick extends CheckLoginEvent{
  String mobileNumber;
  CheckLoginButtonClick(this.mobileNumber);
}