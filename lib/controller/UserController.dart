import 'dart:convert';
import 'package:employee_management/model/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  var users = <User>[].obs; // Observable list of users
  var filteredUsers = <User>[].obs;
  var isLoading = true.obs; // Observable loading state
  var isLoadingMore = false.obs; // Loading state for pagination
  var currentPage = 1.obs; // Current page for pagination

  @override
  void onInit() {
    fetchUsers(); // Fetch users when controller is initialized
    super.onInit();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading(true);

      // Replace this with your actual API URL
      final response = await http.get(Uri.parse(
          'https://669b3f09276e45187d34eb4e.mockapi.io/api/v1/employee'));

      if (response.statusCode == 200) {
        // Decode the response into a List of dynamic (raw JSON)
        List<dynamic> data = jsonDecode(response.body);

        // Convert the List of dynamic JSON into List<User>
        users.value = data.map((json) => User.fromJson(json)).toList();
        filteredUsers.value = users;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print("Error fetching users: $e");
    } finally {
      isLoading(false);
    }
  }

  void filterUsers(String query) {
    if (query.isEmpty) {
      filteredUsers.value = users;
    } else {
      filteredUsers.value = users
          .where(
              (user) => user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
