import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Information
            const Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile-circle-svgrepo-com.png'),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Farm: Green Acres',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Location: Springfield, IL',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Email Information
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: const Text('john.doe@example.com'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Navigate to Edit Email Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EditEmailPage()),
                  );
                },
              ),
            ),
            // Password Information
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Password'),
              subtitle: const Text('********'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Navigate to Edit Password Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EditPasswordPage()),
                  );
                },
              ),
            ),
            // Edit Profile Button
            ElevatedButton(
              onPressed: () {
                // Navigate to Edit Profile Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfilePage()),
                );
              },
              child: const Text('Edit Profile'),
            )
          ],
        ),
      ),
    );
  }

  
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: const Center(
        child: Text('Edit Profile Page Content'),
      ),
    );
  }
}

class EditEmailPage extends StatefulWidget {
  const EditEmailPage({super.key});

  @override
  _EditEmailPageState createState() => _EditEmailPageState();
}

class _EditEmailPageState extends State<EditEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Email'),
      ),
      body: const Center(
        child: Text('Edit Email Page Content'),
      ),
    );
  }
}

class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({super.key});

  @override
  _EditPasswordPageState createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Password'),
      ),
      body: const Center(
        child: Text('Edit Password Page Content'),
      ),
    );
  }
}
