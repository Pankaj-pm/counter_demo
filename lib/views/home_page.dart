import 'package:counter_demo/model/contact_model.dart';
import 'package:counter_demo/providers/contact_provider.dart';
import 'package:counter_demo/providers/counter_provider.dart';
import 'package:counter_demo/providers/theme_provider.dart';
import 'package:counter_demo/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact"),
        actions: [
          InkWell(
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
            child: Icon(Icons.dark_mode),
          )
        ],
      ),
      body: Consumer<ContactProvider>(
        builder: (context, contactProvider, child) => ListView.builder(
          itemCount: contactProvider.list.length,
          itemBuilder: (context, index) {
            Contact contact = contactProvider.list[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text("${contact.name.substring(0, 1)}".toUpperCase()),
              ),
              title: Text(contact.name),
              subtitle: Text("${contact.phoneNumber}"),
              trailing: IconButton(
                  onPressed: () {
                    // launchUrl(Uri.parse("tel:${contact.phoneNumber}"));
                    launchUrl(Uri.parse("https://wa.me/${contact.phoneNumber}"));
                  },
                  icon: Icon(Icons.call)),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, addContact);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
