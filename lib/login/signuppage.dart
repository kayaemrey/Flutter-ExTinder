import 'package:extinder/services/authService.dart';
import 'package:extinder/services/firebaseDB.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class signuppage extends StatefulWidget {
  @override
  _signuppageState createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  TextEditingController txtmail = TextEditingController();
  TextEditingController txtpas = TextEditingController();
  TextEditingController txtname = TextEditingController();
  TextEditingController txtusername = TextEditingController();
  TextEditingController txtabout = TextEditingController();
  TextEditingController txtage = TextEditingController();
  String dropdownValueCin = 'ERKEK';
  var obst = true;
  var showd = false;

  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    final myDB = Provider.of<firebasedb>(context);
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Image.asset(
                        "assets/icon/back.png",
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
              ),
              Image.asset(
                "assets/icon/teamwork.png",
                width: 144,
                height: 144,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "TinderEx",
                style: TextStyle(fontSize: 28),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 8, top: 8),
                child: TextField(
                  controller: txtmail,
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
                  controller: txtpas,
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
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 5, bottom: 8, top: 8),
                      child: TextField(
                        controller: txtname,
                        maxLength: 20,
                        decoration: InputDecoration(
                          hintText: "İsim - soyisim",
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 5, right: 20, bottom: 8, top: 8),
                      child: TextField(
                        controller: txtusername,
                        maxLength: 17,
                        decoration: InputDecoration(
                          hintText: "Kullanıcı adı",
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 5, top: 8),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: txtage,
                  maxLength: 20,
                  decoration: InputDecoration(
                    hintText: "Yaşınız",
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Cinsiyet: "),
                  DropdownButton<String>(
                    value: dropdownValueCin,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValueCin = newValue!;
                      });
                    },
                    items: <String>["ERKEK", "KADIN"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              RaisedButton(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 70),
                  child: Text(
                    "KAYIT OL",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
                onPressed: () async {
                  if (txtmail.text.isEmpty &&
                      txtpas.text.isEmpty &&
                      txtname.text.isEmpty &&
                      txtusername.text.isEmpty &&
                      txtage.text.isEmpty) {
                    AlertDialog alert = AlertDialog(
                      title: Text("Boş kutu hatası"),
                      content:
                          Text("Lütfen tüm kutucukları eksiksiz doldurunuz."),
                      actions: [
                        TextButton(
                            child: Text("Tamam"),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  } else {
                    await myAuth.register(txtmail.text, txtpas.text);
                    await myDB.adduser(txtmail.text, txtpas.text, txtname.text,
                        txtusername.text, txtage.text, dropdownValueCin);
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
