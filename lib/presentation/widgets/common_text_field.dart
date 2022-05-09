import 'package:cakeapp/presentation/utils/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    Key? key,
    this.controller,
    this.onChanged,
    this.textInputAction,
    this.hintStyle,
    this.hintText,
    this.isPasswordType = false,
    this.inputFormatters,
    this.keyboardType,
    this.focusNode,
    this.styles,
    this.autoFocus,
    this.maxLength = 512,
    this.enable = true,
    this.validator,
  }) : super(key: key);

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final TextStyle? hintStyle;
  final TextStyle? styles;
  final String? hintText;
  final bool isPasswordType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final bool? autoFocus;
  final int maxLength;
  final bool enable;
  final FormFieldValidator<String>? validator;

  @override
  _CommonTextFieldState createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool _passwordVisible = false;
  bool _clearVisible = true;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _passwordVisible = !widget.isPasswordType;
    super.initState();
    _controller.addListener(_textChangeListener);
    _clearVisible = widget.controller?.text.isNotEmpty ?? false;
  }

  @override
  void dispose() {
    _controller.removeListener(_textChangeListener);
    _controller.dispose();
    super.dispose();
  }

  void _textChangeListener() {
    final controller = widget.controller ?? _controller;
    setState(() {
      _clearVisible = controller.text.isNotEmpty && !widget.isPasswordType;
    });
  }

  @override
  Widget build(BuildContext context) {
    const border =  OutlineInputBorder(
      borderSide: BorderSide(color: Colors.orangeAccent),
      borderRadius: BorderRadius.all(Radius.circular(0)),
    );
    return TextFormField(
      key: widget.key,
      enabled: widget.enable,
      keyboardAppearance: Brightness.light,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      controller: widget.controller ?? _controller,
      obscureText: !_passwordVisible,
      autofocus: widget.autoFocus ?? false,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      style: widget.styles,
      decoration: InputDecoration(
        border: border,
        focusedBorder: border,
        enabledBorder: border,
        disabledBorder: border,
        contentPadding: const EdgeInsets.all(12),
        hintStyle: widget.hintStyle,
        isDense: false,
        hintText: widget.hintText,
        counterText: '',
        suffixIcon: _buildSuffixIcon(),
      ),
      validator: widget.validator,
    );
  }

  Widget _buildSuffixIcon() {
    return widget.isPasswordType
        ? IconButton(
            key: const ValueKey('_passwordVisible'),
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          )
        : _clearVisible
            ? IconButton(
                key: const ValueKey('_clearVisible'),
                icon: const Icon(Icons.clear, color: Colors.white),
                onPressed: () {
                  final controller = widget.controller ?? _controller;
                  controller.text = '';
                  widget.onChanged?.call('');
                },
              )
            : Gaps.empty;
  }
}
