part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}
 final class FavoriteUpdate extends FavoriteEvent{
  final bool isFavorite;
  const FavoriteUpdate({required this.isFavorite});
   @override
   List<Object> get props => [isFavorite];
 }