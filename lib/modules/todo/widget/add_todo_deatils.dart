import 'dart:ui';

import 'package:eired_sample/constants/color_contants.dart';
import 'package:eired_sample/constants/error_message_constants.dart';
import 'package:eired_sample/constants/list_constants.dart';
import 'package:eired_sample/modules/todo/controller/add_todo_controller.dart';
import 'package:eired_sample/modules/todo/model/todo_model.dart';
import 'package:eired_sample/reusable/custom_appbar.dart';
import 'package:eired_sample/reusable/reusable_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToDoDetails extends StatefulWidget {
  bool? isEdit;
  TodoModel? data;

  AddToDoDetails({Key? key, this.isEdit, this.data}) : super(key: key);

  @override
  State<AddToDoDetails> createState() => _AddToDoDetailsState();
}

class _AddToDoDetailsState extends State<AddToDoDetails> {
  String _category = 'Business';
  String? assetImag;
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  TextEditingController timeTextController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.isEdit ?? false) {
      titleTextController.text = widget.data?.title ?? '';
      descriptionTextController.text = widget.data?.description ?? '';
      timeTextController.text = widget.data?.time ?? '';
      _category = widget.data?.category ?? '';
      assetImag = widget.data?.imageAsset ?? '';
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddTodoController>(builder: (context, controller, _) {
      return Scaffold(
        backgroundColor: ColorConstants.primaryColor,
        appBar: customAppBar(context, inputTitle: 'Add New Task'),
        body: SafeArea(
            child: Stack(
          children: [
            SingleChildScrollView(
              // height: MediaQuery.of(context).size.height,
              //width: MediaQuery.of(context).size.width,
              //color: ColorConstants.primaryColor,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white),
                        image: DecorationImage(
                            image: AssetImage(
                                assetImag ?? 'assets/images/business.png'))),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            DropdownButtonFormField(
                              value: _category,
                              focusColor: Colors.white,
                              validator: (value) {
                                if (value == null) {
                                  return ErrorMessageConstants
                                      .categoryEmptyMessage;
                                }
                                return null;
                              },

                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: Colors.white, fontSize: 16),

                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 30,
                              iconEnabledColor: Colors.white,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 0, top: 4),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),

                              selectedItemBuilder: (BuildContext context) {
                                return ListConstants.categoryjson.map((value) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 4.0, left: 4.0),
                                    child: Text(
                                      value['category'],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  );
                                }).toList();
                              },

                              // ignore: prefer_const_constructors
                              hint: Text(
                                'Please Select the category',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(color: Colors.white),
                              ),
                              items: ListConstants.categoryjson.map((item) {
                                return DropdownMenuItem(
                                    value: item['category'],
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          item['category'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset(
                                          item['image'],
                                          height: 20,
                                          width: 20,
                                        )
                                      ],
                                    ));
                              }).toList(),
                              onChanged: (newValue) {
                                //  do other stuff with _category
                                setState(() {
                                  int selectedIndex = ListConstants.categoryjson
                                      .indexWhere((item) =>
                                          item['category'] == newValue);
                                  _category = newValue.toString();

                                  assetImag = ListConstants
                                      .categoryjson[selectedIndex]['image'];
                                  // _category = newValue.toString();
                                  // print('the index was-----' + selectedIndex.toString());
                                });
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            customTextFormField('Title', titleTextController,
                                ErrorMessageConstants.titleEmptyMessage),
                            const SizedBox(
                              height: 20,
                            ),
                            customTextFormField(
                                'Description',
                                descriptionTextController,
                                ErrorMessageConstants.descriptionEmptyMessage),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: timeTextController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ErrorMessageConstants.timeEmptyMessage;
                                }
                                return null;
                              },
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: Colors.white),
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  context: context,
                                  builder: (context, child) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: false),
                                      child: child!,
                                    );
                                  },
                                );

                                if (pickedTime != null) {
                                  // print(pickedTime.format(context)); //output 10:51 PM
                                  // DateTime parsedTime = DateFormat.jm()
                                  //     .parse(pickedTime.format(context).toString());
                                  // //converting to DateTime so that we can further format on different pattern.
                                  // print(parsedTime); //output 1970-01-01 22:53:00.000
                                  // String formattedTime =
                                  //     DateFormat('HH:mm aa').format(parsedTime);
                                  // print(formattedTime); //output 14:59:00
                                  //DateFormat() is from intl package, you can format the time on any pattern you need.

                                  setState(() {
                                    timeTextController.text = pickedTime.format(
                                        context); //set the value of text field.
                                  });
                                } else {
                                  print("Time is not selected");
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Please Select The Time',
                                hintStyle: TextStyle(color: Colors.white),
                                contentPadding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 0, top: 4),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            ReusableButton(
                              buttonText: widget.isEdit ?? false
                                  ? 'Update'
                                  : 'Add Your Thing',
                              backgroundColor: Colors.blueAccent,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  controller.addTodoData(
                                      titleTextController.value.text,
                                      descriptionTextController.value.text,
                                      _category,
                                      timeTextController.value.text,
                                      context,
                                      isUpdate: widget.isEdit ?? false,
                                      documentId:
                                          widget.data?.documentId ?? '');
                                }
                              },
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
            if (controller.loadingState == AddTodoUploadingState.LOADING)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        )),
      );
    });
  }

  Widget customTextFormField(
      String hintText1, TextEditingController controller, String errorMessage) {
    return Container(
      //padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: controller,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText1,
          hintStyle: const TextStyle(color: Colors.white),
          contentPadding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 4),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorMessage;
          }
          return null;
        },
      ),
    );
  }
}
