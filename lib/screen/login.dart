import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled3/model/profile.dart'; // ต้องแก้ไขตามชื่อไฟล์หน้า Home ที่คุณสร้าง

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Color.fromRGBO(24, 149, 111, 1),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(24, 149, 111, 1), // สีพื้นหลังทั้งหน้า
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              Image.asset(
                'assets/image/logo.png', // ตำแหน่งของรูปภาพ
                width: 200, // ขนาดความกว้างของรูปภาพ
                height: 200, // ขนาดความสูงของรูปภาพ
              ),
              Text("email" ,style: TextStyle(
                fontSize: 18, // ขนาดของข้อความ
                fontWeight: FontWeight.bold, // การกำหนดหน้าตาของตัวหนังสือ
                color: Colors.black, // สีของข้อความ),
                 ),),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(186, 222, 177,1), // สีพื้นหลังของช่องกรอก
                  borderRadius: BorderRadius.circular(10.0), // ทำให้มีมุมโค้ง
                ),

                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white), // สีของข้อความ Label
                    border: InputBorder.none, // ไม่มีเส้นขอบ
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0), // ระยะห่างของเนื้อหาภายในช่องกรอก
                  ),
                  style: TextStyle(color: Colors.black), // สีของข้อความในช่องกรอก
                ),
              ),
              SizedBox(height: 16.0),
              Text("password",style: TextStyle(
                fontSize: 18, // ขนาดของข้อความ
                fontWeight: FontWeight.bold, // การกำหนดหน้าตาของตัวหนังสือ
                color: Colors.black, // สีของข้อความ),
              ),),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(186, 222, 177,1), // สีพื้นหลังของช่องกรอก
                  borderRadius: BorderRadius.circular(10.0), // ทำให้มีมุมโค้ง
                ),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightGreenAccent), // สีขอบของกล่อง
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _signInWithEmailAndPassword();
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      // ตรวจสอบว่า email และ password ไม่ว่าง
      if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
        
        print('Please enter both email and password');
        return;
      }

      // ดึงข้อมูลจาก Firestore โดยใช้ email เป็นเงื่อนไขการค้นหา
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('schedules')
          .where('email', isEqualTo: _emailController.text)
          .get();

      // เช็คว่ามีข้อมูลที่ตรงกับ email ที่ป้อนหรือไม่
      if (querySnapshot.docs.isNotEmpty) {
        // หากมี ให้ดึงข้อมูล password จาก Firestore
        String passwordFromFirestore = querySnapshot.docs.first.get('password');

        // เปรียบเทียบ password ที่ป้อนกับ password ใน Firestore
        if (passwordFromFirestore == _passwordController.text) {
          // หากตรงกัน ให้เข้าสู่ระบบโดยไปยังหน้า Home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PageNews(userEmail: _emailController.text)), // ต้องแก้ไขตามชื่อหน้า Home ที่คุณสร้าง
          );
        } else {
          print('Invalid password');
        }
      } else {
        print('User not found');
      }
    } catch (e) {
      print('Failed to sign in with email and password: $e');
    }
  }
}
