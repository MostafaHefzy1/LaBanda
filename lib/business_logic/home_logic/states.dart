abstract class HomeStates {}

class InitialState extends HomeStates {}

class HomeBottomNavState extends HomeStates {}

class GetProductSuccessSate extends HomeStates {}

class GetProductsFailedSate extends HomeStates {
  final String error;

  GetProductsFailedSate(this.error);
}

class GetCategorySuccessSate extends HomeStates {}

class GetCategoryFailedSate extends HomeStates {
  final String error;

  GetCategoryFailedSate(this.error);
}

class GetMealsProductSuccessSate extends HomeStates {}

class GetMealsProductsFailedSate extends HomeStates {
  final String error;

  GetMealsProductsFailedSate(this.error);
}

class GetCrepeProductSuccessSate extends HomeStates {}

class GetCrepeProductsFailedSate extends HomeStates {
  final String error;

  GetCrepeProductsFailedSate(this.error);
}

class GetBurgerProductSuccessSate extends HomeStates {}

class GetBurgerProductsFailedSate extends HomeStates {
  final String error;

  GetBurgerProductsFailedSate(this.error);
}

class GetPastaProductSuccessSate extends HomeStates {}

class GetPastaProductsFailedSate extends HomeStates {
  final String error;

  GetPastaProductsFailedSate(this.error);
}

class GetSandwichesProductSuccessSate extends HomeStates {}

class GetSandwichesProductsFailedSate extends HomeStates {
  final String error;

  GetSandwichesProductsFailedSate(this.error);
}

class GetWaffleProductSuccessSate extends HomeStates {}

class GetWaffleProductsFailedSate extends HomeStates {
  final String error;

  GetWaffleProductsFailedSate(this.error);
}

class InsertDataInCartScreen extends HomeStates {}

class SuccessInsertDataInCartScreen extends HomeStates {}

class SuccessGetAllProductInCartState extends HomeStates {}

class FailedGetAllProductInCartState extends HomeStates {
  final String error;

  FailedGetAllProductInCartState(this.error);
}

class IncreaseCartState extends HomeStates {}

class GetAllProductToCartState extends HomeStates {}

class DecreaseCartState extends HomeStates {}

class UpdateDataToState extends HomeStates {}

class DeleteDataToCart extends HomeStates {}

class IsDarkState extends HomeStates {}

class UserEditingImageSuccess extends HomeStates {}

class UserEditingImageFailed extends HomeStates {}

class GETEditingImageSuccess extends HomeStates {}

class GETEditingImageFailed extends HomeStates {}

class StateSearchLogic extends HomeStates {}

class ClearSearchLogic extends HomeStates {}

class StateAddLocation extends HomeStates {}
