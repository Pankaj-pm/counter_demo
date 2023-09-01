// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:counter_demo/model/contact_model.dart';
import 'package:counter_demo/providers/contact_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddContact extends StatefulWidget {
  final Map<String, dynamic>? contact;
  int? index;

  AddContact({super.key, this.contact, this.index});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final TextEditingController fName = TextEditingController();
  final TextEditingController lName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController email = TextEditingController();

  InputDecoration decoration = InputDecoration(
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
    focusedErrorBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
  );

  XFile? file;
  int cStep = 0;

  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    fName.text = widget.contact?["first_name"] ?? "";
    lName.text = widget.contact?["last_name"] ?? "";
    phoneNumber.text = widget.contact?["number"] ?? "";
    email.text = widget.contact?["email"] ?? "";
    file = XFile(widget.contact?["profile"] ?? "");

    fName.text = "Virat";
    lName.text = "Kohli";
    phoneNumber.text = "8866332256";
    email.text = "abc@gmailc.com";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)?.settings.arguments;
    print(" data $data");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.contact != null ? "Edit" : "Add",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 3,
        actions: [
          InkWell(
            onTap: () async {
              var data = await showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text("Save"),
                    content: Text("Are you sure ?"),
                    actions: [
                      CupertinoDialogAction(
                        child: Text("Ok"),
                        onPressed: () {
                          print("Ok");
                          Navigator.pop(context, true);
                        },
                        isDefaultAction: true,
                      ),
                      CupertinoDialogAction(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context, false);
                          print("Cancel");
                        },
                        isDestructiveAction: true,
                      ),
                    ],
                  );
                },
              );

              print("object $data");
              if ((key.currentState?.validate() ?? false) && (data ?? false)) {
                String firstName = fName.text;
                String lastName = lName.text;
                int number = int.tryParse(phoneNumber.text) ?? 0;
                String emailAddress = email.text;

                Contact contact =
                    Contact(firstName, lastName, emailAddress, number);
                Provider.of<ContactProvider>(context, listen: false)
                    .addContact(contact);
                Navigator.pop(context);
              } else {
                print("object");
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.done),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            var pickImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            file = pickImage;
                            setState(() {});
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.black38,
                            radius: 38,
                            backgroundImage: (file?.path ?? "").isNotEmpty
                                ? FileImage(File(file?.path ?? ""))
                                : null,
                            child: Text("Add"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Stepper(
                  steps: [
                    Step(
                      title: Text("Step 1"),
                      subtitle: Text("First Name"),
                      content: TextFormField(
                        controller: fName,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: decoration,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Enter First Name";
                          } else {
                            return null;
                          }
                        },
                      ),
                      isActive: cStep == 0,
                      label: Text("Ok"),
                    ),
                    Step(
                        title: Text("Step 2"),
                        subtitle: Text("Last Name"),
                        content: TextFormField(
                          controller: lName,
                          decoration: decoration,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Enter Last Name";
                            } else {
                              return null;
                            }
                          },
                        ),
                        isActive: cStep == 1),
                    Step(
                        title: Text("Step 3"),
                        subtitle: Text("Phone Number"),
                        content: TextFormField(
                          controller: phoneNumber,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          decoration:
                              decoration.copyWith(hintText: "+91 123456789"),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Enter Phone number";
                            } else if (value!.length < 10) {
                              return "Enter Valid number";
                            } else {
                              return null;
                            }
                          },
                        ),
                        isActive: cStep == 2),
                    Step(
                        title: Text("Step 4"),
                        subtitle: Text("Email"),
                        content: TextFormField(
                          controller: email,
                          decoration: decoration,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Enter Email Address";
                            } else {
                              return null;
                            }
                          },
                        ),
                        isActive: cStep == 3),
                  ],
                  currentStep: cStep,
                  onStepCancel: () {
                    cStep--;
                    setState(() {});
                    print("onStepCancel");
                  },
                  onStepContinue: () {
                    cStep++;
                    setState(() {});
                    print("onStepContinue");
                  },
                  onStepTapped: (index) {
                    cStep = index;
                    setState(() {});
                    print(index);
                  },
                  controlsBuilder: (context, details) {
                    // details.currentStep
                    return Row(
                      children: [
                        if (details.currentStep < 3)
                          TextButton(
                            onPressed: () {
                              details.onStepContinue?.call();
                            },
                            child: Text("Continue"),
                          ),
                        if (details.currentStep != 0)
                          TextButton(
                            onPressed: () {
                              details.onStepCancel?.call();
                            },
                            child: Text("Back"),
                          ),
                      ],
                    );
                  },
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      // showDatePicker(
                      //   context: context,
                      //   initialDate: DateTime.now(),
                      //   currentDate: DateTime(2023, 08, 24),
                      //   firstDate: DateTime(1990),
                      //   lastDate: DateTime(2055),
                      //   // initialDatePickerMode: DatePickerMode.year,
                      //   // initialEntryMode: DatePickerEntryMode.inputOnly
                      // ).then((value) {
                      //   print(value);
                      // });

                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 250,
                            // width: 200,
                            color: Colors.white,
                            child: CupertinoDatePicker(
                              onDateTimeChanged: (value) {
                                print(value);
                              },
                              initialDateTime: DateTime.now(),
                              maximumDate: DateTime(2055),
                              // use24hFormat: true,
                              mode: CupertinoDatePickerMode.date,
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.calendar_month),
                    label: Text("Pick Date")),
                ElevatedButton.icon(
                    onPressed: () {
                      // showTimePicker(
                      //   context: context,
                      //   initialTime: TimeOfDay.now(),
                      // ).then((value) {
                      //   print(value);
                      // });
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return Container(
                            color: Colors.white,
                            height: 200,
                            child: CupertinoDatePicker(
                              onDateTimeChanged: (value) {},
                              mode: CupertinoDatePickerMode.time,
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.access_time),
                    label: Text("Time Date"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileGet extends StatefulWidget {
  Function(XFile file)? onFileSelect;

  ProfileGet({super.key, this.onFileSelect});

  @override
  State<ProfileGet> createState() => _ProfileGetState();
}

class _ProfileGetState extends State<ProfileGet> {
  XFile? file;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var pickImage =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        file = pickImage;
        if (pickImage != null && widget.onFileSelect != null) {
          widget.onFileSelect!(pickImage);
        }
        setState(() {});
      },
      child: CircleAvatar(
        backgroundColor: Colors.black38,
        radius: 38,
        backgroundImage: (file?.path ?? "").isNotEmpty
            ? FileImage(File(file?.path ?? ""))
            : null,
        child: Text("Add"),
      ),
    );
  }
}
