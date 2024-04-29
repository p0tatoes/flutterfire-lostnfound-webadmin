import "package:date_time_picker/date_time_picker.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:lostnfound_webadmin/providers/items.provider.dart";
import "package:lostnfound_webadmin/widgets/item_form_field.dart";
import "package:provider/provider.dart";

// enum ColorLabel {
//   blue('Blue', Colors.blue),
//   pink('Pink', Colors.pink),
//   green('Green', Colors.green),
//   yellow('Orange', Colors.orange),
//   grey('Grey', Colors.grey);

//   const ColorLabel(this.label, this.color);
//   final String label;
//   final Color color;
// }

final categories = [
  "Accessories",
  "Bags",
  "Clothing",
  "Electronics",
  "School supplies",
  "Sports equipment",
  "Valuables",
];

class CreateItemView extends StatefulWidget {
  const CreateItemView({super.key});

  @override
  State<CreateItemView> createState() => _CreateItemViewState();
}

class _CreateItemViewState extends State<CreateItemView> {
  final _formKey = GlobalKey<FormState>();

  final inName = TextEditingController();
  final inDescription = TextEditingController();
  String? inCategory;
  final inLocation = TextEditingController();
  final inTime = TextEditingController();
  List<Uint8List> _imageFiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text("Add Lost-n-Found Item Listing"),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // name
                FormInputField(
                  controller: inName,
                  label: "Name",
                ),

                // description
                FormInputField(
                  controller: inDescription,
                  label: "Description",
                ),

                // category
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  margin: EdgeInsets.only(bottom: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Category",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                        ),
                        iconEnabledColor: Colors.white,
                        onChanged: (value) {
                          setState(
                            () {
                              inCategory = value;
                            },
                          );
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please fill up";
                          }

                          return null;
                        },
                        items: categories
                            .map<DropdownMenuItem<String>>(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),

                // DropdownMenu(
                //   label: const Text("Categories"),
                //   controller: inCategory,
                //   dropdownMenuEntries: categories
                //       .map<DropdownMenuEntry<String>>(
                //         (category) => DropdownMenuEntry(
                //           value: category,
                //           label: category.toUpperCase(),
                //         ),
                //       )
                //       .toList(),
                // ),

                // location_found
                FormInputField(controller: inLocation, label: "Found at"),

                // time_found
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  margin: EdgeInsets.only(bottom: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Time found",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      DateTimePicker(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                          icon: const Icon(Icons.event),
                          iconColor: Colors.white,
                        ),
                        type: DateTimePickerType.dateTime,
                        controller: inTime,
                        dateMask: 'd MMM, yyyy',
                        initialValue: null,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                        dateLabelText: 'Date found',
                        timeLabelText: "Time found",
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please select a time and date";
                          }

                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                /**
                 * image
                 * 
                 * only shows if category is not "valuables"
                 */
                if (inCategory == "Valuables")
                  SizedBox()
                else
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor: MaterialStatePropertyAll(
                        _imageFiles.isEmpty ? Colors.grey : Colors.green,
                      ),
                      foregroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    onPressed: () {
                      _pickImage();
                    },
                    child: const Text("Select Image"),
                  ),

                SizedBox(
                  height: 15.0,
                ),

                // SUBMIT
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // error notification if no image and category is not "valuables"
                      if (_imageFiles.isEmpty && inCategory != "Valuables") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please add images"),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );

                        return;
                      }

                      // Loading Message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Uploading..."),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );

                      bool isUploaded = false;

                      try {
                        switch (inCategory) {
                          case "Valuables":
                            isUploaded = await Provider.of<ItemsProvider>(
                                    context,
                                    listen: false)
                                .addItem(
                                    name: inName.text,
                                    category: inCategory!,
                                    description: inDescription.text,
                                    locationFound: inLocation.text,
                                    timeFoundString: inTime.text);
                            break;
                          default:
                            isUploaded = await Provider.of<ItemsProvider>(
                                    context,
                                    listen: false)
                                .addItem(
                                    name: inName.text,
                                    category: inCategory!,
                                    description: inDescription.text,
                                    locationFound: inLocation.text,
                                    timeFoundString: inTime.text,
                                    images: _imageFiles);
                            break;
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("Failed to add item. Try again later"),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }

                      if (isUploaded) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Successfully added item"),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );

                        Navigator.pop(context, "/dashboard");
                      }

                      print({
                        "name": inName.text,
                        "category": inCategory,
                        "description": inDescription.text,
                        "time_found": inTime.text,
                        "location_found": inLocation.text,
                      });
                    }
                  },
                  child: const Text("Submit"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final selectedImage = await ImagePicker().pickMultiImage();

    if (selectedImage.isEmpty) return;

    List<Uint8List> imageData = [];

    for (var image in selectedImage) {
      imageData.add(await image.readAsBytes());
      print(image.path);
    }

    setState(() {
      _imageFiles = imageData;
    });
  }
}
