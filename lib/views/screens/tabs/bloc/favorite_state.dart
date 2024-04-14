part of 'favorite_bloc.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

final class FavoriteInitial extends FavoriteState {}
final class FavoriteLoading extends FavoriteState {}

final class FavoriteChanges extends FavoriteState {
  final bool isFavorite;
  const FavoriteChanges({required this.isFavorite});
   @override
   List<Object> get props => [isFavorite];
}
