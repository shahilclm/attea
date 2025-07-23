import 'package:flutter/material.dart';

class CustomTooltip extends StatefulWidget {
  final Widget child;
  final String message;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final Duration? showDuration;
  final Duration? hideDuration;
  final double? borderRadius;

  const CustomTooltip({
    super.key,
    required this.child,
    required this.message,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.showDuration = const Duration(seconds: 1),
    this.hideDuration = const Duration(seconds: 1),
    this.borderRadius = 8.0,
  });

  @override
  CustomTooltipState createState() => CustomTooltipState();
}

class CustomTooltipState extends State<CustomTooltip> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isTooltipVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _removeTooltip();
    super.dispose();
  }

  // Method to show the tooltip
  void _showTooltip() {
    final overlay = Overlay.of(context);
    _overlayEntry = _createOverlayEntry();

    if (_overlayEntry != null) {
      overlay.insert(_overlayEntry!);
      setState(() {
        _isTooltipVisible = true;
      });

      Future.delayed(widget.showDuration!, () {
        _hideTooltip();
      });
    }
  }

  // Method to hide the tooltip
  void _hideTooltip() {
    _removeTooltip();
    setState(() {
      _isTooltipVisible = false;
    });
  }

  // Method to remove tooltip
  void _removeTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  // Create the Tooltip Widget that will be inserted into the Overlay
  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx + size.width / 2 - 100, // Center it horizontally
        top: position.dy - 60, // Place it above the widget
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: widget.padding ?? EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? Colors.black,
                borderRadius: BorderRadius.circular(widget.borderRadius!),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 4)),
                ],
              ),
              child: Text(
                widget.message,
                style: TextStyle(
                  color: widget.textColor ?? Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isTooltipVisible ? _hideTooltip : _showTooltip,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: widget.child,
      ),
    );
  }
}
