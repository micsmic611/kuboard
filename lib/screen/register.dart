import 'package:flutter/material.dart';
import 'package:untitled3/screen/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();

}


class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();


  List<String> list = <String>['กรุณาเลือกเพศ','ชาย', 'หญิง','ไม่ระบุ'];
  String sex= 'กรุณาเลือกเพศ';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController myusername = TextEditingController();
  final TextEditingController myFirstname = TextEditingController();
  final TextEditingController myLastname = TextEditingController();
  final TextEditingController myEmail = TextEditingController();
  final TextEditingController mypassword = TextEditingController();
  final TextEditingController myrepassword = TextEditingController();
  final TextEditingController myphone = TextEditingController();
  final CollectionReference schedules = FirebaseFirestore.instance.collection('schedules');


  Future<void> _save([DocumentSnapshot? documentSnapshot]) async {
    try {
      final Map<String, dynamic> data = {
        "username": myusername.text,
        "firstname": myFirstname.text,
        "lastname": myLastname.text,
        "email": myEmail.text,
        "password": mypassword.text,
        "phone": myphone.text,
        "sex": sex,
      };
      await schedules.add(data);

      // ล้างข้อมูลในฟอร์ม
      myusername.clear();
      myFirstname.clear();
      myLastname.clear();
      myEmail.clear();
      mypassword.clear();
      myrepassword.clear();
      myphone.clear();
      setState(() {
        sex = 'กรุณาเลือกเพศ';
      });

      // แสดงข้อความว่า "บันทึกข้อมูลเรียบร้อยแล้ว"
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('บันทึกข้อมูลเรียบร้อยแล้ว')),
      );


    } catch (e) {
      print('เกิดข้อผิดพลาดในการสร้างหรืออัปเดตเอกสาร: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 149, 111, 1),
      appBar: AppBar(
        backgroundColor:Color.fromRGBO(24, 149, 111, 1),
        title: Text("ระบบลงทะเบียน",
          style: Theme.of(context).textTheme.titleMedium,),


      ),
      body: ListView(

        children: [
          Card(
              color: Colors.white,

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("KU BOARD",
                      style: Theme.of(context).textTheme.titleMedium,),

                  ),
                  Divider(),
                  Padding(padding: const EdgeInsets.all(20.0),
                    child:Form(
                      child: Column(
                        key: _formKey,
                        children:[
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: myusername,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: const InputDecoration(labelText: 'username'
                                    ,labelStyle: TextStyle(
                                      color: Color(0xFF6200EE),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.red),

                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกusername';
                                    }
                                    return null;
                                  },
                                ),
                              ),//-email
                            ],
                          ),//username
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(labelText: 'password'
                                    ,labelStyle: TextStyle(
                                      color: Color(0xFF6200EE),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.red),
                                  controller: mypassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกข้อมูล';
                                    }
                                    return null;
                                  },
                                ),
                              ),//-email
                            ],
                          ),//password
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(labelText: 're enter password'
                                    ,labelStyle: TextStyle(
                                      color: Color(0xFF6200EE),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.red),
                                  controller: myrepassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกข้อมูลอีกครั้ง';
                                    }
                                    return null;
                                  },
                                ),
                              ),//-email
                            ],
                          ),//repassword
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(labelText: 'ชื่อ'
                                    ,labelStyle: TextStyle(
                                      color: Color(0xFF6200EE),
                                    ),),

                                  style:TextStyle(color:Colors.red,),
                                  controller: myFirstname,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกข้อมูล';
                                    }
                                    return null;
                                  },
                                ),
                              ),//-name
                              SizedBox(width: 15.0,),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(labelText: 'นามสกุล'
                                    ,labelStyle: TextStyle(
                                      color: Color(0xFF6200EE),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.red),
                                  controller: myLastname,
                                ),
                              ),//-lastname
                            ],
                          ),//name-surname
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(labelText: 'email'
                                    ,labelStyle: TextStyle(
                                      color: Color(0xFF6200EE),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.red),
                                  controller: myEmail,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกข้อมูล';
                                    }
                                    return null;
                                  },
                                ),
                              ),//-email
                            ],
                          ),//email
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(labelText: 'phone'
                                    ,labelStyle: TextStyle(
                                      color: Color(0xFF6200EE),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.red),
                                  controller: myphone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกข้อมูล';
                                    }
                                    return null;
                                  },
                                ),
                              ),//-email
                            ],
                          ),//email
                          Row(
                            children: [
                              Expanded(
                                child:
                                ListTile(
                                  title: Text("เลือกเพศ"
                                    ,style: TextStyle(
                                      color: Color(0xFF6200EE),
                                    ),
                                  ),
                                  trailing: DropdownButton<String>(

                                    value: sex,
                                    icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        sex = value!;
                                      });

                                    },
                                    items: list.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),

                              ),//
                            ],
                          ),//sex
                        ],
                      ),
                    ),
                  )
                ],
              )
          ),
          SizedBox(height: 20), // เพิ่มระยะห่างระหว่างฟอร์มและปุ่ม Save
          Center(
            child: ElevatedButton(
              onPressed: (){
                _save();
                Navigator.push(context,MaterialPageRoute(
                    builder: (context){
                      return homeScreen();
                    })
                );
              },
              child: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }

}
