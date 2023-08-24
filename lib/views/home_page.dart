import 'package:counter_demo/model/contact_model.dart';
import 'package:counter_demo/providers/contact_provider.dart';
import 'package:counter_demo/providers/counter_provider.dart';
import 'package:counter_demo/providers/theme_provider.dart';
import 'package:counter_demo/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
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
  final LocalAuthentication auth = LocalAuthentication();

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
              // leading: CircleAvatar(
              //   child: Text("${contact.name.substring(0, 1)}".toUpperCase()),
              // ),
              leading: Icon(Icons.settings),
              title: Text(contact.name),
              subtitle: Text("${contact.phoneNumber}"),
              // trailing: IconButton(
              //     onPressed: () {
              //       // launchUrl(Uri.parse("tel:${contact.phoneNumber}"));
              //       launchUrl(
              //           Uri.parse("https://wa.me/0${contact.phoneNumber}"));
              //     },
              //     icon: Icon(Icons.call)),
              trailing: PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text("Option 1"),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: Text("Option 2"),
                      value: 2,
                    )
                  ];
                },

                onSelected: (value) {
                  print(value);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var deviceSupported = await auth.isDeviceSupported();
          if (deviceSupported) {
            bool isSupport = await auth.canCheckBiometrics;
            print("isSupport $isSupport");

            List list = await auth.getAvailableBiometrics();
            print(list);

            bool isAuth = await auth.authenticate(
                localizedReason: "localizedReason",
                options: const AuthenticationOptions(
                  stickyAuth: true,
                ));
            if (isAuth) {
              Navigator.pushNamed(context, addContact);
            }
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
