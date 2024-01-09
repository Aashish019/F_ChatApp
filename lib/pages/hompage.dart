import 'package:chatapp/components/user_tile.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

import '../components/my_drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final ChatServices chatServices = ChatServices();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.blueGrey,
      ),
      drawer: const MyDrawer(),
      body: _bodyUserList(),
    );
  }

  Widget _bodyUserList() {
    return StreamBuilder(
      stream: chatServices.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        //loding
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        //return listview

        return ListView(
          physics: const BouncingScrollPhysics(),
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != authService.getCurrentUser()!.email) {
      return UserTile(
          text: userData["email"],
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                      receiverEmail: userData["email"],
                      receiverID: userData["uid"]),
                ));
          });
    } else {
      return Container();
    }
  }
}
