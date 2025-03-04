import 'package:flutter/material.dart';

class SelfScrollableCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final double scrollSpeed; // Speed in pixels per step

  const SelfScrollableCarousel({
    super.key,
    required this.imageUrls,
    this.scrollSpeed = 1.0, // Default speed
  });

  @override
  State<SelfScrollableCarousel> createState() => _SelfScrollableCarouselState();
}

class _SelfScrollableCarouselState extends State<SelfScrollableCarousel> {
  final ScrollController _scrollController = ScrollController();
  late double _scrollPosition = 0.0;
  bool _isUserScrolling = false;

  @override
  void initState() {
    super.initState();
    _startScrolling();
  }

  void _startScrolling() {
    if (!mounted) return;
    Future.delayed(const Duration(milliseconds: 50), () {
      if (!_isUserScrolling && mounted) {
        _scrollPosition += widget.scrollSpeed;
        if (_scrollPosition >= _scrollController.position.maxScrollExtent) {
          _scrollPosition = 0;
          _scrollController.jumpTo(0);
        } else {
          _scrollController.animateTo(
            _scrollPosition,
            duration: Duration(milliseconds: (50 / widget.scrollSpeed).round()),
            curve: Curves.linear,
          );
        }
        _startScrolling(); // Continue the loop
      } else if (mounted) {
        _startScrolling(); // Check again if user is still scrolling
      }
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isUserScrolling = false;
      _scrollPosition = _scrollController.offset; // Update position
      _startScrolling(); // Resume auto-scrolling
    });
  }

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isUserScrolling = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Listener(
        onPointerDown: _onPointerDown,
        onPointerUp: _onPointerUp,
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: widget.imageUrls
                .map((url) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.network(url, height: 90),
            ))
                .toList(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
