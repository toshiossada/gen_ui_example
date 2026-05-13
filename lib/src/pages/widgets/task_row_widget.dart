import 'package:flutter/material.dart';

class TaskRowWidget extends StatelessWidget {
  final String text;
  final bool isDone;
  final ValueChanged<bool?> onChanged;

  const TaskRowWidget({
    super.key,
    required this.text,
    required this.isDone,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
      fontSize: 14,
      color: const Color(0xFF5A5E67),
      decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
      decorationColor: const Color(0xFF7E8087),
    );

    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Expanded(child: Text(text, style: labelStyle)),
          Checkbox(
            value: isDone,
            onChanged: onChanged,
            activeColor: const Color(0xFF8EB2E8),
            checkColor: Colors.white,
            side: const BorderSide(color: Color(0xFF7C7F86), width: 1.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
