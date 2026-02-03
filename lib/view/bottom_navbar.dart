import 'package:computer_shop/bloc/bottom_nav_bloc.dart';
import 'package:computer_shop/service/cart_store.dart';
import 'package:computer_shop/view/cart_screen.dart';
import 'package:computer_shop/view/home_screen.dart';
import 'package:computer_shop/view/notifi_screen.dart';
import 'package:computer_shop/view/profile_screen.dart';
import 'package:computer_shop/view/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavbarScreen extends StatelessWidget {
  const BottomNavbarScreen({super.key });


  static final List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
   CartScreen(),
    NotifiScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return Scaffold(
          body: screens[state.index],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.index,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              context.read<BottomNavBloc>().add(SelectedBottomNav(index: value));
            },
            selectedItemColor: Colors.blue, // ✅ replace your Colorr if needed
            unselectedItemColor: Colors.black,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Cart"),
              BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notification"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            ],
          ),
        );
      },
    );
  }
}
