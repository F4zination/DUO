import 'dart:ui';

import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/duo_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DuoBottomNavigationItem {
  final String label;
  final String icon;
  const DuoBottomNavigationItem({
    required this.label,
    required this.icon,
  });
}

class DuoBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int index) onSelected;
  final VoidCallback? onPlay;
  final List<DuoBottomNavigationItem> items;
  const DuoBottomNavigationBar({
    this.currentIndex = -1,
    required this.onSelected,
    required this.items,
    this.onPlay,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 56 + Constants.defaultPadding * 3,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 56 + Constants.defaultPadding * 3,
            ),
            Padding(
              padding: const EdgeInsets.all(Constants.defaultPadding),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Constants.defaultRadius),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: DuoContainer(
                    backgroundColor:
                        Constants.secondaryColorDark.withOpacity(0.8),
                    height: 56,
                    width: double.infinity,
                    // margin: const EdgeInsets.all(Constants.defaultPadding),
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.defaultPadding / 2),
                  ),
                ),
              ),
            ),
            DuoContainer(
              backgroundColor: Colors.transparent,
              height: 56,
              margin: const EdgeInsets.all(Constants.defaultPadding),
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.defaultPadding / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...List.generate(
                    items.length,
                    (index) => SizedBox.square(
                      dimension: index == currentIndex ? 36 : 33,
                      child: Material(
                        color: Colors.transparent,
                        child: GestureDetector(
                          onTap: () => onSelected(index),
                          child: SvgPicture.asset(
                            items[index].icon,
                            colorFilter: ColorFilter.mode(
                              index == currentIndex
                                  ? Theme.of(context).colorScheme.onSurface
                                  : Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.7),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (onPlay != null)
              Positioned(
                left: MediaQuery.of(context).size.width / 2 - 25,
                top: 0,
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: Material(
                      child: InkWell(
                        onTap: onPlay ?? () {},
                        borderRadius: BorderRadius.circular(200),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Constants.primaryColor.withOpacity(0.7),
                          ),
                          child: Center(
                            child: Padding(
                              //Svg Picture is not placed in the center of the circle
                              padding: const EdgeInsets.only(left: 3.0),
                              child: SvgPicture.asset(
                                'res/icons/play.svg',
                                height: 30,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withOpacity(0.8),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
