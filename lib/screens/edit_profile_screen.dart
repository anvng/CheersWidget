import 'package:cheers_widget/models/user.dart';
import 'package:cheers_widget/services/database_helper.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _phoneNumber;
  late String _email;
  late DateTime _birthdate;

  get validatePhoneNumber => null;

  get validateEmail => null;

  get validateDate => null;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() async {
    User user = await DatabaseHelper.instance.getUser();
    setState(() {
      _name = user.name;
      _phoneNumber = user.phoneNumber;
      _email = user.email;
      _birthdate = user.birthdate;
    });
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      DatabaseHelper.instance.updateUser(User(
        name: _name,
        phoneNumber: _phoneNumber,
        email: _email,
        birthdate: _birthdate,
      ));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _phoneNumber,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: validatePhoneNumber,
                onSaved: (value) => _phoneNumber = value!,
              ),
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: validateEmail,
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                initialValue: _birthdate.toString(),
                decoration: const InputDecoration(labelText: 'Birthdate'),
                validator: validateDate,
                onSaved: (value) => _birthdate = DateTime.parse(value!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
