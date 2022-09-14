import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

const String _titleAppBar = "Novo Contato";

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final ContactDao _contactDao = ContactDao();

  final TextEditingController _controllerName = TextEditingController();

  final TextEditingController _controllerAccountNumber =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(_titleAppBar),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _controllerName,
                decoration: const InputDecoration(
                  hintText: "Ex: Paulo Sergio",
                  labelText: "Full Name",
                ),
                style: const TextStyle(fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: _controllerAccountNumber,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Ex: 0000",
                    labelText: "Account number",
                  ),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Contact? newContact = createContact();
                        if (newContact == null) return;
                        _contactDao
                            .save(newContact)
                            .then((id) => Navigator.pop(context));
                      },
                      child: const Text("Create")),
                ),
              ),
            ],
          ),
        ));
  }

  Contact? createContact() {
    final String name = (_controllerName.text);
    final int? accountNumber = int.tryParse(_controllerAccountNumber.text);
    if (name.isNotEmpty && name.trim().isNotEmpty && accountNumber != null) {
      Contact newContact = Contact(0, name, accountNumber);
      return newContact;
    }
    return null;
  }
}
