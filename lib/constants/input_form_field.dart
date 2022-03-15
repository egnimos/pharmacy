import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

convertKey(text) {
  var removedSteps = text.toString().toLowerCase().replaceAll(' ', '_');
  return removedSteps;
}

class AllInputDesign extends StatefulWidget {
  // final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final String? prefixText;
  final int? maxLine;
  final bool? enabled;
  final bool? autofocused;
  final Function()? onTap;
  final String? hintText;
  final String? labelText;
  final String? inputHeaderName;
  final TextInputAction? textInputAction;
  final String? counterText;
  final int? maxLength;
  final bool obscureText;
  final TextStyle? prefixStyle;
  final String? errorText;
  final InputBorder? inputborder;
  final double? contentPadding;
  final String? initialValue;
  final TextInputType? keyBoardType;
  final String? Function(String?)? validatorFieldValue;
  final bool alignLabelWithHint;
  final InputBorder? enabledBorder;
  final bool? expand;
  final InputBorder? disabledBorder;
  final Widget? prefixIcon;
  final InputBorder? focusedBorder;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Color? filledColor;
  final Widget? suffixIcon;

  const AllInputDesign({
    Key? key,
    this.controller,
    this.maxLine = 1,
    this.enabled,
    this.prefixText,
    this.textInputAction,
    this.onTap,
    this.autofocused,
    this.inputborder,
    this.alignLabelWithHint = false,
    this.focusedBorder,
    this.onChanged,
    this.enabledBorder,
    this.expand,
    this.onEditingComplete,
    this.disabledBorder,
    this.prefixIcon,
    this.counterText,
    this.maxLength,
    this.obscureText = false,
    this.prefixStyle,
    this.keyBoardType,
    this.contentPadding,
    this.initialValue,
    this.suffixIcon,
    this.hintText,
    this.filledColor,
    this.labelText,
    this.inputHeaderName,
    this.validatorFieldValue,
    this.errorText,
  }) : super(key: key);

  @override
  _AllInputDesignState createState() => _AllInputDesignState();
}

class _AllInputDesignState extends State<AllInputDesign> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          cursorColor: Colors.black,
          maxLines: widget.maxLine,
          initialValue: widget.initialValue,
          maxLength: widget.maxLength,

          key: Key(convertKey(widget.inputHeaderName)),
          // onSaved: widget.onSaved,
          keyboardType: widget.keyBoardType,
          validator: widget.validatorFieldValue,
          onTap: widget.onTap,
          controller: widget.controller,
          enabled: widget.enabled,
          autofocus: widget.autofocused ?? false,
          expands: widget.expand ?? false,
          obscureText: widget.obscureText,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            focusedBorder: widget.focusedBorder,
            enabledBorder: widget.enabledBorder,
            disabledBorder: widget.disabledBorder,
            prefixIcon: widget.prefixIcon,
            border: widget.inputborder,
            filled: true,
            fillColor: widget.filledColor ?? const Color(0xfff0f0f0),
            counterText: widget.counterText,
            hintText: (widget.hintText != null) ? widget.hintText : '',
            labelText: (widget.labelText != null) ? widget.labelText : '',
            alignLabelWithHint: widget.alignLabelWithHint,
            hintStyle: GoogleFonts.nunitoSans(
              fontSize: 20.0,
              color: Colors.black,
            ),
            labelStyle: GoogleFonts.nunitoSans(
              color: Colors.black54,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: widget.suffixIcon ?? const Text(''),
            ),
            prefixText: (widget.prefixText != null) ? widget.prefixText : '',
            prefixStyle: widget.prefixStyle,
            errorText: widget.errorText,
            contentPadding: EdgeInsets.all(widget.contentPadding ?? 15.0),
          ),
        ),
      ],
    );
  }
}
