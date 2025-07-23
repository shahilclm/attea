import 'package:flutter/material.dart';

class CarouselViewWidget extends StatefulWidget {
  final List<Widget> items;
  final double height;
  final Duration autoScrollDuration;
  final bool autoScroll;
  final EdgeInsetsGeometry padding;
  final BoxShadow? shadow;
  final BorderRadiusGeometry borderRadius;
  final double viewportFraction;
  final ScrollPhysics? physics;
  final Color activeDotColor;
  final Color inactiveDotColor;

  const CarouselViewWidget({
    super.key,
    required this.items,
    this.height = 200,
    this.autoScroll = false,
    this.autoScrollDuration = const Duration(seconds: 3),
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.shadow,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.viewportFraction = 0.9,
    this.physics,
    this.activeDotColor = Colors.redAccent,
    this.inactiveDotColor = const Color(0xFFBDBDBD),
  });

  @override
  State<CarouselViewWidget> createState() => _CarouselViewWidgetState();
}

class _CarouselViewWidgetState extends State<CarouselViewWidget> {
  late final PageController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: widget.viewportFraction);
    if (widget.autoScroll) {
      Future.delayed(widget.autoScrollDuration, _autoScroll);
    }
  }

  void _autoScroll() {
    if (!mounted) return;
    _currentIndex = (_currentIndex + 1) % widget.items.length;
    _controller.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    Future.delayed(widget.autoScrollDuration, _autoScroll);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: widget.padding,
            child: PageView.builder(
              controller: _controller,
              physics: widget.physics ?? const BouncingScrollPhysics(),
              itemCount: widget.items.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (_, index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: widget.borderRadius,
                    boxShadow: widget.shadow != null ? [widget.shadow!] : [],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: widget.items[index],
                );
              },
            ),
          ),
          Positioned(
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.items.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: _currentIndex == index ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? widget.activeDotColor
                        : widget.inactiveDotColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
