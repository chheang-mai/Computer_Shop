part of 'bottom_nav_bloc.dart';

@immutable
abstract class BottomNavEvent {}

class SelectedBottomNav extends BottomNavEvent {
  final int index;
  SelectedBottomNav({required this.index});
}
