import 'package:flutter/material.dart';
import 'package:practice_api/view/intro_screen/signIn_screen.dart';
import 'package:provider/provider.dart';
import '../../viewModel/auth_provider.dart';

class SignupScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final Map<String, String> signupData = {
    "address": "amnour",
    "agent_id": "2",
    "email": "",
    "password": "",
    "fcm_token": "ksbd-m nkca",
    "first_name": "",
    "last_name": "aqib1",
    "gender": "male",
    "new_user": "0",
    "number": "",
    "other_referral_code": "dfv-dfv -sdf",
    "referral_code": "wedfv-dfv",
    "status": "1",
    "type": "user"
  };

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [

                  SizedBox(height: 35),
                  Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),

                  SizedBox(height: 30),

                  // ALL FIELDS
                  buildField("First Name", Icons.person, "first_name"),
                  buildField("Last Name", Icons.person, "last_name"),
                  buildField("Email", Icons.email, "email", keyboardType: TextInputType.emailAddress),
                  buildField("Password", Icons.lock, "password", obscureText: true),
                  buildField("Phone Number", Icons.phone, "number", keyboardType: TextInputType.phone),
                  buildField("Agent ID", Icons.badge, "agent_id"),
                  buildField("FCM Token", Icons.vpn_key, "fcm_token"),
                  buildField("Address", Icons.location_on, "address"),
                  buildField("Gender", Icons.person_outline, "gender"),
                  buildField("New User", Icons.fiber_new, "new_user"),
                  buildField("Other Referral Code", Icons.code, "other_referral_code"),
                  buildField("Referral Code", Icons.code_off, "referral_code"),
                  buildField("Status", Icons.toggle_on, "status"),
                  buildField("Type", Icons.supervised_user_circle, "type"),

                  SizedBox(height: 30),

                  authProvider.isLoading
                      ? CircularProgressIndicator()
                      : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          authProvider.signUpUser(signupData, context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "SignUp",
                        style:
                        TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen(),)),
                        child: Text("Login", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildField(String label, IconData icon, String key,
      {bool obscureText = false, TextInputType keyboardType = TextInputType.text}) {
    return Column(
      children: [
        TextFormField(
          decoration: inputDecoration(label, icon),
          keyboardType: keyboardType,
          obscureText: obscureText,
          initialValue: signupData[key],
          onChanged: (value) => signupData[key] = value,
          validator: (value) =>
          value == null || value.isEmpty ? 'Required' : null,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  InputDecoration inputDecoration(String label, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon),
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
