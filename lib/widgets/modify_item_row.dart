import 'package:flutter/material.dart';

class ModifyItemRow extends StatefulWidget {

  final ValueChanged<int?> onOrderFieldChanged;
  final String? initialValue;
  final String labelText;

  const ModifyItemRow({
    super.key, 
    required this.initialValue,
    required this.onOrderFieldChanged,
    required this.labelText,
  });

  @override
  State<ModifyItemRow> createState() {
    return _ModifyItemRowState();
  }
}

class _ModifyItemRowState extends State<ModifyItemRow> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.initialValue,
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: widget.labelText,
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              widget.onOrderFieldChanged(int.parse(value!));
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Needs some value";
              } else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }
}
