import 'package:computer_shop/view/edit_profile_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ===== TOP BAR =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "My Profile",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ===== PROFILE HEADER =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Row(
                children: [
                  // Avatar
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          "assets/images/image.png",
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.camera_alt,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 15),

                  // Name & Email
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Chheang Mai",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "ChheangMai@gmail.com",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreen() ));
                          },
                          style: ElevatedButton.styleFrom(
                           
                            backgroundColor: const Color.fromARGB(255, 18, 100, 168),
                            minimumSize: const Size(150, 40),
                          ),
                          child: const Text(
                            "Edit Profile",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ===== MENU LIST =====
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  ListTile(
                    leading: const Icon(Icons.favorite_border),
                    title: const Text("Favourites"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.download),
                    title: const Text("Downloads"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),

                  const Divider(),

                  ListTile(
                    leading: const Icon(Icons.language),
                    title: const Text("Language"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: const Text("Location"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.display_settings),
                    title: const Text("Display"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.tune),
                    title: const Text("Feed preference"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.subscriptions),
                    title: const Text("Subscription"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),

                  const Divider(),

                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text("Clear Cache"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.history),
                    title: const Text("Clear history"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),

                  const SizedBox(height: 5),

                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      "Log Out",
                      style: TextStyle(color: Colors.red),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // logout logic
                    },
                  ),

                  const SizedBox(height: 20),

                  const Center(
                    child: Text(
                      "App version 003",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
