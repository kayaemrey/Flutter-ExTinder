import 'package:extinder/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'forgotpasswordpage.dart';
import 'signuppage.dart';

class loginpage extends StatefulWidget {
  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  var obst = true;
  var showd = false;
  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.orange.shade900,
                  Colors.orange.shade400,
                  Colors.orange.shade300,
                ]),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Image.asset(
                  "assets/icon/teamwork.png",
                  width: 192,
                  height: 192,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "TinderEx",
                  style: TextStyle(fontSize: 28),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 8, top: 8),
                  child: TextField(
                    controller: t1,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "E-mail giriniz",
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 8, top: 8),
                  child: TextField(
                    controller: t2,
                    obscureText: obst,
                    decoration: InputDecoration(
                      suffixIcon: showd == false
                          ? IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  obst = false;
                                  showd = true;
                                });
                              },
                            )
                          : IconButton(
                              icon: Icon(Icons.remove_red_eye_outlined,
                                  color: Colors.black),
                              onPressed: () {
                                setState(() {
                                  obst = true;
                                  showd = false;
                                });
                              },
                            ),
                      hintText: "Şifre giriniz",
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Container(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        forgotpasswordpage()));
                          },
                          child: Text(
                            "Şifreni mi unuttun?",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ))),
                ),
                SizedBox(
                  height: 35,
                ),
                RaisedButton(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 11, horizontal: 80),
                    child: Text(
                      "GİRİŞ",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: () {
                    myAuth.signin(t1.text, t2.text);
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Hesabın yok mu ?"),
                    InkWell(
                      child: Text(
                        "Buradan kayıt olun",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => signuppage()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
