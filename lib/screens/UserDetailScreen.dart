import 'package:flutter/material.dart';
import '../model/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: user.avatar != null && user.avatar!.isNotEmpty
                  ? NetworkImage(user.avatar!)
                  : const AssetImage('assets/male.jpg') as ImageProvider,
            ),
            const SizedBox(height: 20.0),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text('Name'),
              subtitle: Text(user.name),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text(user.emailId),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text('Mobile'),
              subtitle: Text(user.mobile),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.flag),
              title: Text('Country'),
              subtitle: Text(user.country),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.location_city),
              title: Text('State'),
              subtitle: Text(user.state ?? 'Unknown'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: Text('District'),
              subtitle: Text(user.district ?? 'Unknown'),
            ),
          ],
        ),
      ),
    );
  }
}
