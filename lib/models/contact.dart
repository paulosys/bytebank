class Contact {
  final int id;
  final String name;
  final int accountNumber;

  Contact(this.id, this.name, this.accountNumber);

  @override
  String toString() {
    return "Contact{id: $id, name: $name, accountNumber: $accountNumber}";
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> contactMap = {};
    contactMap['name'] = name;
    contactMap['account_number'] = accountNumber;
    return contactMap;
  }


  
}
