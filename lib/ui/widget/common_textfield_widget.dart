import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextFieldWidget extends StatelessWidget {
  const CommonTextFieldWidget(
      {super.key,
      required this.hintText,
      this.maxLine = 1,
      this.controller,
      this.onTap,
      this.textInputType = TextInputType.text,
      this.showSuffixIconButton = false,
      this.showPrefixIcon = false,
      this.suffixIconButtonOnTap,
      this.suffixIcon,
      this.prefixIcon,
      this.inputFormatters,
      this.readOnly = false});

  final String hintText;
  final TextEditingController? controller;
  final bool readOnly;
  final bool showSuffixIconButton;
  final bool showPrefixIcon;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? suffixIconButtonOnTap;
  final Function()? onTap;
  final TextInputType textInputType;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                onTap: onTap ?? () {},
                readOnly: readOnly,
                style: Theme.of(context).textTheme.titleSmall,
                controller: controller,
                inputFormatters: inputFormatters,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  hintText: hintText,
                  prefixIcon: showPrefixIcon == true
                      ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: prefixIcon,
                        )
                      : null,
                  suffixIcon: showSuffixIconButton == false
                      ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: suffixIcon,
                        )
                      : null,
                ),
                keyboardType: textInputType,
                maxLines: maxLine,
              ),
            ),
            showSuffixIconButton
                ? IconButton(
                    onPressed: suffixIconButtonOnTap,
                    icon: suffixIcon ?? const Icon(Icons.location_on_outlined))
                : const SizedBox()
          ],
        ),
      ],
    );
  }
}
