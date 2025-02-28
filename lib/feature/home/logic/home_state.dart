part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeUserLoading extends HomeState {}

final class HomeUserLoaded extends HomeState {}

final class HomeUserError extends HomeState {
  final String message;

  HomeUserError(this.message);
}


final class HomeProductsLoading extends HomeState {}

final class HomeProductsLoaded extends HomeState {}

final class HomeProductsError extends HomeState {
  final String message;

  HomeProductsError(this.message);
}


final class ProductDetailsLoading extends HomeState {}

final class ProductDetailsLoaded extends HomeState {}

final class ProductDetailsError extends HomeState {
  final String message;

  ProductDetailsError(this.message);
}
class RelatedProductsLoading extends HomeState {}
class RelatedProductsLoaded extends HomeState {}
class RelatedProductsError extends HomeState {
  final String message;
  RelatedProductsError(this.message);
}