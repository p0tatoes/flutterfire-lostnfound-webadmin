import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

class LabelledIcon extends StatelessWidget {
  const LabelledIcon({
    super.key,
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 7.0,
      runSpacing: 7.0,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        FaIcon(
          icon,
          color: Colors.white,
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        )
      ],
    );
  }
}
