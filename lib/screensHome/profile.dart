import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extinder/model/homeWidgetModel.dart';
import 'package:extinder/services/authService.dart';
import 'package:extinder/services/firebaseStorage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class profilepage extends StatefulWidget {
  const profilepage({Key? key}) : super(key: key);

  @override
  _profilepageState createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  AuthService auth = new AuthService();
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.authid())
        .collection("galeri")
        .orderBy("time", descending: true)
        .snapshots();
    final myHome = Provider.of<homeWidgetModel>(context);
    final myAuth = Provider.of<AuthService>(context);
    final myStorage = Provider.of<firebasestorage>(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              myHome.appbart(),
              FutureBuilder<DocumentSnapshot>(
                future: users.doc(myAuth.authid()).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return Text("Document does not exist");
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: InkWell(
                            child: data["profile"] != null
                                ? CircleAvatar(
                                    backgroundColor: Colors.white,
                                    maxRadius: 70,
                                    backgroundImage:
                                        NetworkImage(data["profile"]))
                                : CircleAvatar(
                                    backgroundColor: Colors.white,
                                    maxRadius: 70,
                                    backgroundImage:
                                        AssetImage("assets/icon/teamwork.png")),
                            onLongPress: () {
                              myStorage.getImage("profile");
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          data["name"].toString().toUpperCase() +
                              ", " +
                              data["age"],
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: _usersStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            return new GridView.count(
                              controller: _controller,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              crossAxisCount: 3,
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 1,
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                return Container(
                                  child: InkWell(
                                    child: Image.network(
                                      document.get("url"),
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.low,
                                    ),
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => galopenimage(
                                      //             document.id, myAuth.authid())));
                                    },
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    );
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
