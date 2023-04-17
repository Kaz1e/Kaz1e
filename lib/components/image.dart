import 'package:flutter/material.dart';

class ImageViwer extends StatefulWidget {
  final String image;
  const ImageViwer({Key key, @required this.image});

  @override
  State<ImageViwer> createState() => _ImageViwerState();
}

class _ImageViwerState extends State<ImageViwer>
    with SingleTickerProviderStateMixin {
  TransformationController controller;
  AnimationController animationController;

  final double minScale = 1;
  final double maxScale = 10;

  TapDownDetails tapDownDetails;
  Animation<Matrix4> animation;
  double scale = 1;
  OverlayEntry entry;
  int rotate = 0;

  @override
  void initState() {
    super.initState();
    controller = TransformationController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )
      ..addListener(() {
        controller.value = animation.value;
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          removeOverlay();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: (details) => tapDownDetails = details,
      onDoubleTap: () {
        final position = tapDownDetails.localPosition;

        const double scale = 5;
        final x = -position.dx * (scale - 1);
        final y = -position.dy * (scale - 1);
        final zoomed = Matrix4.identity()
          ..translate(x, y)
          ..scale(scale);
        final end = controller.value.isIdentity() ? zoomed : Matrix4.identity();
        animation = Matrix4Tween(
          begin: controller.value,
          end: end,
        ).animate(
          CurveTween(curve: Curves.easeOut).animate(animationController),
        );

        animationController.forward(from: 0);
      },
      child: buildImage(widget.image),
    );
  }

  Widget buildImage(String url) {
    return Builder(builder: (context) {
      return InteractiveViewer(
        onInteractionStart: (details) {
          if (details.pointerCount < 2) return;

          showOverlay(context, url);
        },
        onInteractionUpdate: (details) {
          if (entry == null) return;

          scale = details.scale;
          entry.markNeedsBuild();
        },
        onInteractionEnd: (details) {
          resetAnimation();
        },
        clipBehavior: Clip.none,
        transformationController: controller,
        minScale: minScale,
        maxScale: maxScale,
        panEnabled: false,
        child: FadeInImage.assetNetwork(
          image: url,
          placeholderFit: BoxFit.contain,
          placeholder: "assets/gif/loading.gif",
          fit: BoxFit.contain, // Scale the image to fit within its container
        ),
      );
    });
  }

  void showOverlay(BuildContext context, String url) {
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = MediaQuery.of(context).size;

    entry = OverlayEntry(builder: (context) {
      final opacity = ((scale - 1) / (maxScale - 1)).clamp(minScale, maxScale);
      return Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Positioned(
            left: offset.dx,
            top: offset.dy,
            width: size.width,
            child: buildImage(url),
          ),
        ],
      );
    });
    final overlay = Overlay.of(context);
    overlay.insert(entry);
  }

  void removeOverlay() {
    entry?.remove();
    entry = null;
  }

  void resetAnimation() {
    animation = Matrix4Tween(
      begin: controller.value,
      end: Matrix4.identity(),
    ).animate(
      CurveTween(curve: Curves.easeOut).animate(animationController),
    );
    animationController.forward(from: 0);
  }
}
