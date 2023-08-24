class Contact{
  String _name;
  String _lastName;
  String _email;
  int _phoneNumber;


  Contact(this._name, this._lastName, this._email, this._phoneNumber);

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get lastName => _lastName;

  int get phoneNumber => _phoneNumber;

  set phoneNumber(int value) {
    _phoneNumber = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  set lastName(String value) {
    _lastName = value;
  }
}