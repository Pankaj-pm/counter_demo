// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:counter_demo/model/contact_model.dart';
import 'package:counter_demo/providers/contact_provider.dart';
import 'package:counter_demo/providers/counter_provider.dart';
import 'package:counter_demo/providers/theme_provider.dart';
import 'package:counter_demo/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Contact"),
          actions: [
            InkWell(
              onTap: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .changeTheme();
              },
              child: Icon(Icons.dark_mode),
            )
          ],
          bottom: TabBar(
            // isScrollable: true,
            onTap: (value) {

            },
            indicatorSize: TabBarIndicatorSize.label,
            automaticIndicatorColorAdjustment: false,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.red,
            overlayColor: MaterialStatePropertyAll(Colors.red),
            tabs: [
              Tab(
                icon: Icon(Icons.person),
              ),
              Tab(text: "Contact"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Consumer<ContactProvider>(
              builder: (context, contactProvider, child) => Column(
                children: [
                  // CupertinoContextMenu(
                  //   actions: [
                  //     CupertinoContextMenuAction(child: Text("Option1"))
                  //   ],
                  //   child: SizedBox(
                  //       child: CupertinoListTile(title: Text("Hello"))),
                  // ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: contactProvider.list.length,
                      itemBuilder: (context, index) {
                        Contact contact = contactProvider.list[index];

                        return ListTile(
                          // leading: CircleAvatar(
                          //   child: Text("${contact.name.substring(0, 1)}".toUpperCase()),
                          // ),
                          leading: CupertinoContextMenu(
                            actions: [
                              CupertinoContextMenuAction(
                                child: Text("Copy"),
                                isDefaultAction: true,
                              ),
                              CupertinoContextMenuAction(
                                child: Text("Delete"),
                                isDestructiveAction: true,
                              )
                            ],
                            child: CircleAvatar(child: Text("V")),
                          ),
                          title: Text(contact.name),
                          subtitle: Text("${contact.phoneNumber}"),
                          // trailing: IconButton(
                          //     onPressed: () {
                          //       // launchUrl(Uri.parse("tel:${contact.phoneNumber}"));
                          //       launchUrl(
                          //           Uri.parse("https://wa.me/0${contact.phoneNumber}"));
                          //     },
                          //     icon: Icon(Icons.call)),
                          onTap: () {
                            Navigator.pushNamed(context, pageScreen);
                          },
                          trailing: PopupMenuButton(
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  child: Text("View"),
                                  value: 1,
                                  onTap: () {
                                    showBottomSheet(
                                      context: context,
                                      // constraints: BoxConstraints(),
                                      // shape:StarBorder(),
                                      backgroundColor: Colors.red,
                                      builder: (context) {
                                        return Container(
                                          // color: Colors.grey,
                                          width: double.infinity,
                                          padding: EdgeInsets.all(12),
                                          // height: double.infinity,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Name",
                                                style: TextStyle(
                                                    fontSize: 23,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                contact.name,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                contact.phoneNumber.toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                PopupMenuItem(
                                  child: Text("Edit"),
                                  value: 2,
                                  onTap: () {
                                    Future.delayed(
                                      Duration(milliseconds: 100),
                                      () {
                                        showModalBottomSheet(
                                          context: context,
                                          backgroundColor: Colors.red,
                                          isDismissible: false,
                                          enableDrag: false,
                                          isScrollControlled: true,
                                          useSafeArea: true,
                                          // barrierColor: Colors.white30,
                                          builder: (context) {
                                            return WillPopScope(
                                              onWillPop: () async {
                                                return false;
                                                return Future(() => false);
                                              },
                                              child: Container(
                                                // color: Colors.grey,
                                                width: double.infinity,
                                                padding: EdgeInsets.all(12),
                                                // height: double.infinity,
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Name",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          23,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  color: Colors
                                                                      .white,
                                                                  icon: Icon(Icons
                                                                      .close),
                                                                )
                                                              ],
                                                            ),
                                                            Text(
                                                              contact.name,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            TextFormField(
                                                              initialValue:
                                                                  contact
                                                                      .lastName,
                                                            ),
                                                            Text(
                                                              contact.lastName,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "Contact",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 18),
                                                            ),
                                                            TextFormField(
                                                              initialValue: contact
                                                                  .phoneNumber
                                                                  .toString(),
                                                            ),
                                                            SizedBox(height: 5),
                                                            Text(
                                                              contact
                                                                  .phoneNumber
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            TextFormField(
                                                              initialValue:
                                                                  contact.email,
                                                            ),
                                                            Text(
                                                              "Email",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 18),
                                                            ),
                                                            SizedBox(height: 5),
                                                            TextFormField(
                                                              initialValue:
                                                                  contact.email,
                                                            ),
                                                            Text(
                                                              contact.email,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            TextFormField(
                                                              initialValue:
                                                                  contact.email,
                                                            ),
                                                            TextFormField(
                                                              initialValue:
                                                                  contact.email,
                                                            ),
                                                            TextFormField(
                                                              initialValue:
                                                                  contact.email,
                                                            ),
                                                            TextFormField(
                                                              initialValue:
                                                                  contact.email,
                                                            ),
                                                            TextFormField(
                                                              initialValue:
                                                                  contact.email,
                                                            ),
                                                            TextFormField(
                                                              initialValue:
                                                                  contact.email,
                                                            ),
                                                            TextFormField(
                                                              initialValue:
                                                                  contact.email,
                                                            ),
                                                            TextFormField(
                                                              initialValue:
                                                                  contact.email,
                                                            ),
                                                            TextFormField(
                                                              initialValue:
                                                                  contact.email,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: () {},
                                                        child: Text("save"))
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                                PopupMenuItem(
                                  child: Text("Option 1"),
                                  onTap: () {
                                    Future.delayed(
                                      Duration.zero,
                                      () {
                                        showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) {
                                            return CupertinoActionSheet(
                                              title: Text("Zip"),
                                              message: Text(
                                                  "Are you want to use zip`"),
                                              actions: [
                                                CupertinoActionSheetAction(
                                                  onPressed: () {},
                                                  isDefaultAction: true,
                                                  child: Text("View"),
                                                ),
                                                CupertinoActionSheetAction(
                                                  onPressed: () {},
                                                  child: Text("Edit"),
                                                ),
                                                CupertinoActionSheetAction(
                                                  onPressed: () {},
                                                  child: Text("Delete"),
                                                )
                                              ],
                                              cancelButton:
                                                  CupertinoActionSheetAction(
                                                onPressed: () {},
                                                isDestructiveAction: true,
                                                child: Text("Cancel"),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
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
                ],
              ),
            ),
            Text("Ok")
          ],
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
            } else {
              Navigator.pushNamed(context, addContact);
            }
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
