import "package:flutter/material.dart";

class FormInputField extends StatelessWidget {
  const FormInputField({
    super.key,
    required this.controller,
    required this.label,
  });

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade900,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      margin: EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: Colors.white),
              ),
            ),
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) return "Please fill up";

              return null;
            },
          ),
        ],
      ),
    );
  }
}
