import 'package:flutter/material.dart';

class GridItem extends StatefulWidget {
  final String title;
  final String url;
  final Widget navigateTo;
  final Color tileColor;
  const GridItem(
      {super.key,
        required this.title,
        required this.url,
        required this.tileColor,
        required this.navigateTo});

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isTapped = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget.navigateTo),
        );
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      child: AnimatedScale(
        scale: _isTapped ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: AnimatedOpacity(
          opacity: _isTapped ? 0.8 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Ink.image(
                  image: AssetImage(widget.url),
                  height: 90,
                ),
              ),
              subtitle: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              tileColor: widget.tileColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: const EdgeInsets.all(4),
            ),
          ),
        ),
      ),
    );
  }
}
