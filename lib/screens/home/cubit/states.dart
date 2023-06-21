abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeGetSourcesLoadingState extends HomeState {}

class HomeGetSourcesSuccessState extends HomeState {}

class HomeGetSourcesErrorState extends HomeState {
  String error;

  HomeGetSourcesErrorState(this.error);
}

class HomeChangeSource extends HomeState {}

class HomeConnectionErrorState extends HomeState {}

class HomeGetNewsLoadingState extends HomeState {}

class HomeGetNewsSuccessState extends HomeState {}
class HomeGetNewsDetailsSuccessState extends HomeState {}
class HomeGetNewsDetailsLoadState extends HomeState {}

class HomeGetNewsErrorState extends HomeState {
  String error;

  HomeGetNewsErrorState(this.error);
}
