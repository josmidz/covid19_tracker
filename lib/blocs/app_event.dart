import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  @override
  List<Object> get props =>[];
}

class NoState extends AppEvent{}
class ShowScrollUppButtonState extends AppEvent{}

class LoadingState extends AppEvent{}

class LoadedState extends AppEvent{}

class LoginSuccessState extends AppEvent{}

class NoNetworkState extends AppEvent{}

class FailState extends AppEvent{}

class FailWithMessageState extends AppEvent{
  final message;
  FailWithMessageState({this.message});
  @override
  List<Object> get props => [message];
}