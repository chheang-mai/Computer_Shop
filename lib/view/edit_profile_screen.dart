import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final firstName = TextEditingController(text: "Jhonson");
  final lastName = TextEditingController(text: "King");
  final phone = TextEditingController(text: "689 7852");
  final email = TextEditingController();

  String countryCode = "+91";
  String? gender;

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    phone.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== TOP BAR =====
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: save action
                        // example: print(firstName.text);
                      },
                      icon: const Icon(Icons.check_rounded, size: 26),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ===== AVATAR =====
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 42,
                      backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1520975869018-7f7f1f1f1f1f?auto=format&fit=crop&w=200&q=60",
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 16,
                          onPressed: () {
                            // TODO: change photo
                          },
                          icon: const Icon(Icons.camera_alt_outlined),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Your Information",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 14),

              // ===== FIRST NAME =====
              TextField(
                controller: firstName,
                decoration: InputDecoration(
                  labelText: "First name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // ===== LAST NAME =====
              TextField(
                controller: lastName,
                decoration: InputDecoration(
                  labelText: "Last name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // ===== PHONE (Country code + number) =====
              TextField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: countryCode,
                            items: const [
                              DropdownMenuItem(value: "+91", child: Text("+91")),
                              DropdownMenuItem(value: "+855", child: Text("+855")),
                              DropdownMenuItem(value: "+66", child: Text("+66")),
                              DropdownMenuItem(value: "+84", child: Text("+84")),
                            ],
                            onChanged: (v) {
                              if (v == null) return;
                              setState(() => countryCode = v);
                            },
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
                      ],
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.green, width: 2),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // ===== EMAIL =====
              TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email Id",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // ===== GENDER DROPDOWN =====
              DropdownButtonFormField<String>(
                value: gender,
                decoration: InputDecoration(
                  labelText: "Gender",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                items: const [
                  DropdownMenuItem(value: "Male", child: Text("Male")),
                  DropdownMenuItem(value: "Female", child: Text("Female")),
                  DropdownMenuItem(value: "Other", child: Text("Other")),
                ],
                onChanged: (v) => setState(() => gender = v),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
