import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/rendering.dart';

class SelfScrollableBorderCarousel extends StatefulWidget {
  final List<String> imageUrls;

  const SelfScrollableBorderCarousel({super.key, required this.imageUrls});

  @override
  State<SelfScrollableBorderCarousel> createState() =>
      _SelfScrollableCarouselState();
}

class _SelfScrollableCarouselState extends State<SelfScrollableBorderCarousel> {
  final ScrollController _scrollController = ScrollController();
  bool _isUserScrolling = false;
  Timer? _scrollTimer;

  @override
  void initState() {
    super.initState();
    _startScrolling();
  }

  void _startScrolling() {
    _scrollTimer?.cancel(); // Cancel any existing timers
    _scrollTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!_isUserScrolling && mounted) {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent) {
          _scrollController.jumpTo(0);
        } else {
          _scrollController.animateTo(
            _scrollController.position.pixels + 1,
            duration: const Duration(milliseconds: 50),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  void _stopScrolling() {
    _scrollTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160, // Adjusted height for better fit
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is UserScrollNotification) {
            if (notification.direction != ScrollDirection.idle) {
              _isUserScrolling = true;
              _stopScrolling();
            } else {
              _isUserScrolling = false;
              _startScrolling();
            }
          }
          return false;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: widget.imageUrls.map((url) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: FutureBuilder<Size>(
                  future: _getImageSize(url),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      double aspectRatio =
                          snapshot.data!.width / snapshot.data!.height;

                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: AspectRatio(
                            aspectRatio: aspectRatio,
                            child: Image.network(
                              url,
                              fit: BoxFit.contain, // Ensures proper fitting
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox(
                        width: 60,
                        height: 60,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Future<Size> _getImageSize(String url) async {
    final Completer<Size> completer = Completer();
    final Image image = Image.network(url);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(
          Size(info.image.width.toDouble(), info.image.height.toDouble()),
        );
      }),
    );
    return completer.future;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollTimer?.cancel();
    super.dispose();
  }
}
