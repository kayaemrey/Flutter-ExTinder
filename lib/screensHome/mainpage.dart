import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extinder/model/homeWidgetModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  _mainpageState createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  var gender;
  Future<void> getgender() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(myAuth.authid())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        setState(() {
          gender = documentSnapshot.get("gender");
        });
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getgender();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('users')
        .where("gender", isEqualTo: gender == "KADIN" ? "ERKEK" : "KADIN")
        .snapshots();
    final myHome = Provider.of<homeWidgetModel>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              myHome.appbart(),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _usersStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return Container(
                      child: Stack(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return Swipable(
                            onSwipeRight: (finalPosition) {
                              print("object");
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Expanded(
                                            child: Container(
                                              width: double.infinity,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.75,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: data["profile"] != null
                                                  ? Image.network(
                                                      data["profile"],
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.asset(
                                                      "assets/icon/teamwork.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 20),
                                          child: Container(
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                IconButton(
                                                    iconSize: 70,
                                                    onPressed: () {},
                                                    icon: Image.asset(
                                                      "assets/icon/reload.png",
                                                    )),
                                                IconButton(
                                                    iconSize: 60,
                                                    onPressed: () {},
                                                    icon: Image.asset(
                                                        "assets/icon/cross.png")),
                                                IconButton(
                                                    iconSize: 55,
                                                    onPressed: () {},
                                                    icon: Image.asset(
                                                        "assets/icon/love.png")),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
