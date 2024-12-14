sealed class UIState {
  const UIState();

  factory UIState.initial() => InitialState();

  factory UIState.loading({String? message}) => LoadingState(message);

  factory UIState.success() => SuccessState();

  factory UIState.error(String errorMessage) => ErrorState(errorMessage);
}

class InitialState extends UIState {}

class LoadingState extends UIState {
  final String? message;

  LoadingState(this.message);
}

class ErrorState extends UIState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}

class SuccessState extends UIState {}

extension UIStateWhen on UIState {
  T when<T>({
    required T Function() onInitial,
    required T Function(String? loadingMessage) onLoading,
    required T Function(String errorMessage) onError,
    required T Function() onSuccess,
  }) {
    if (this is InitialState) {
      return onInitial();
    } else if (this is LoadingState) {
      return onLoading((this as LoadingState).message);
    } else if (this is ErrorState) {
      return onError((this as ErrorState).errorMessage);
    } else if (this is SuccessState) {
      return onSuccess();
    } else {
      throw Exception('Unknown state: $this');
    }
  }
}
