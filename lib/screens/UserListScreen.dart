import 'package:employee_management/screens/UserDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/UserController.dart';

class UserListScreen extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beautiful User List with GetX'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                //userController.filterUsers(value); // Call the filter function
                if (value.trim().length >= 3) {
                  // Only filter if at least 3 characters are typed
                  userController.filterUsers(value.trim());
                } else {
                  userController.filteredUsers.value = userController
                      .users; // Reset list if input is less than 3 characters
                }
              },
              decoration: InputDecoration(
                labelText: 'Search Users',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    userController.filterUsers('');
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (userController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (userController.filteredUsers.isEmpty) {
                return const Center(child: Text("No users found"));
              }

              return ListView.builder(
                padding:
                    const EdgeInsets.all(8.0), // Add padding to the ListView
                itemCount: userController.filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = userController.filteredUsers[index];

                  return Card(
                    elevation: 4.0, // Shadow effect for the card
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 5.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          15.0), // Rounded corners for the card
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(
                          10.0), // Adjust padding inside the card
                      leading: CircleAvatar(
                        radius: 30.0, // Make the avatar slightly larger
                        backgroundImage: user.avatar != null
                            ? NetworkImage(user.avatar!)
                            : const AssetImage('assets/male.jpg')
                                as ImageProvider, // Placeholder for null avatars
                        backgroundColor: Colors.grey[200],
                      ),
                      title: Text(
                        user.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0, // Make name slightly larger
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5.0),
                          Text(
                            '${user.country}, ${user.state ?? 'Unknown State'}, ${user.district ?? 'Unknown District'}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            user.emailId,
                            style: const TextStyle(color: Colors.blueAccent),
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.phone, color: Colors.green),
                          const SizedBox(height: 4.0),
                          Text(user.mobile),
                        ],
                      ),
                      onTap: () {
                        // Navigate to UserDetailScreen when tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetailScreen(user: user),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
