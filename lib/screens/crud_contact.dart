import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

const String _titleAppBar = "Editar Contato";

class CrudContact extends StatefulWidget {
  Contact contact;
  final ContactDao _contactDao = ContactDao();
  CrudContact({super.key, required this.contact});

  @override
  State<CrudContact> createState() => _CrudContactState();
}

class _CrudContactState extends State<CrudContact> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerAccountNumber =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controllerName.text = widget.contact.name;
    _controllerAccountNumber.text = widget.contact.accountNumber.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text(_titleAppBar),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.00),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controllerName,
              decoration: const InputDecoration(
                hintText: "Ex: Paulo Sergio",
                labelText: "Full Name",
                suffixIcon: Icon(Icons.edit),
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
                  suffixIcon: Icon(Icons.edit),
                ),
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: ((() => widget._contactDao
                        .delete(widget.contact)
                        .then((value) => Navigator.pop(context)))),
                    icon: const Icon(Icons.delete),
                    color: Colors.red),
                IconButton(
                    onPressed: () {
                      Contact? newContact = createContact();
                      if (newContact == null) return;
                      widget._contactDao
                          .update(newContact)
                          .then((value) => Navigator.pop(context));
                    },
                    icon: const Icon(Icons.check),
                    color: Colors.green),
              ],
            )
          ],
        ),
      ),
    );
  }

  Contact? createContact() {
    final String name = (_controllerName.text);
    final int? accountNumber = int.tryParse(_controllerAccountNumber.text);
    if (name.isNotEmpty && name.trim().isNotEmpty && accountNumber != null) {
      int id = widget.contact.id;
      Contact newContact = Contact(id, name, accountNumber);
      return newContact;
    }
    return null;
  }
}
