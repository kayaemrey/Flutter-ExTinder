import 'package:extinder/screensHome/mainpage.dart';
import 'package:extinder/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AuthService myAuth = new AuthService();

class homeWidgetModel with ChangeNotifier {
  AppBar appbar() {
    return AppBar(
      backgroundColor: Colors.orange,
      title: Text("TinderEx"),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.message))],
    );
  }

  Widget appbart() {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/icon/settings.png",
                  width: 40,
                )),
            Text(
              "TinderEx",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
            ),
            IconButton(
                onPressed: () {
                  myAuth.signout();
                },
                icon: Image.asset(
                  "assets/icon/messages.png",
                  width: 40,
                )),
          ],
        ),
      ),
    );
  }

  Drawer drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              )),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Home page'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => mainpage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Çıkış yap'),
            onTap: () {
              myAuth.signout();
            },
          ),
        ],
      ),
    );
  }
}
