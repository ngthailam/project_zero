import 'package:flutter/material.dart';

const appBarItems = ['Home', 'Food', 'Place'];

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    Key? key,
    required this.onAppBarItemTap,
  }) : super(key: key);

  final Function(int index) onAppBarItemTap;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  int _hoveredIndex = 0;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(top: 16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/img/logo.png',
                height: 64,
                width: 64,
              ),
            ),
          ),
          for (var i = 0; i < appBarItems.length; i++) _item(i),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _item(int index) {
    final isHighlighted = _selectedIndex == index || _hoveredIndex == index;
    return InkWell(
      onHover: (isHovered) {
        if (isHovered && _hoveredIndex != index) {
          setState(() {
            _hoveredIndex = index;
          });
          return;
        }

        if (!isHovered && _hoveredIndex == index) {
          setState(() {
            _hoveredIndex = -1;
          });
        }
      },
      onTap: () {
        if (_selectedIndex != index) {
          setState(() {
            widget.onAppBarItemTap.call(index);
            _selectedIndex = index;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Text(appBarItems[index],
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 16,
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w500,
              color: isHighlighted ? const Color(0xFFfa6d85) : Colors.black,
            )),
      ),
    );
  }
}
