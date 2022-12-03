abstract class AdminStates {}

class InitialState extends AdminStates {}

class AdminBottomNavState extends AdminStates {}

class ImagePickerSuccess extends AdminStates {}

class ImagePickerFailed extends AdminStates {}

class CreateProductLoadingState extends AdminStates {}

class CreateProductSuccessState extends AdminStates {}

class CreateProductFailedState extends AdminStates {
  final String error;

  CreateProductFailedState(this.error);
}

class UploadProductSuccessState extends AdminStates {}

class UploadProductFailedState extends AdminStates {
  final String error;

  UploadProductFailedState(this.error);
}

class GoToMapSuccessState extends AdminStates {}

class GoToMapFailedState extends AdminStates {}
