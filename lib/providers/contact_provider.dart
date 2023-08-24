import 'package:counter_demo/model/contact_model.dart';
import 'package:flutter/material.dart';

class ContactProvider extends ChangeNotifier {
  List<Contact> list = [];

  void addContact(Contact contact) {
    list.add(contact);
    notifyListeners();
  }
}
