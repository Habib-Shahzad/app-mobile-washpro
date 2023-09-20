import 'package:flutter/material.dart';

class CustomIconCard extends StatelessWidget {
  final List<IconData> icons;
  final double iconSize;
  final double elevation;
  final List<String> texts;
  final EdgeInsetsGeometry cardPadding;
  final double iconPadding;
  final VoidCallback? onTap;

  const CustomIconCard({
    Key? key,
    required this.icons,
    required this.iconSize,
    required this.elevation,
    required this.texts,
    this.cardPadding = const EdgeInsets.all(16.0),
    this.iconPadding = 30,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: cardPadding, // Apply padding to the card content
            child: SizedBox(
              width: 140,
              height: 140,
              child: Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                  if (icons.isNotEmpty)
                    Icon(
                      icons[0],
                      color: Theme.of(context).colorScheme.onSurface,
                      size: iconSize,
                    ),
                  if (icons.length == 2)
                    Padding(
                      padding: EdgeInsets.only(left: iconPadding),
                      child: Icon(
                        icons[1],
                        color: Theme.of(context).colorScheme.primary,
                        size: iconSize,
                      ),
                    ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              texts[0],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                            const SizedBox(width: 4.0), // Spacing
                            Text(
                              texts[1],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                            ),
                          ],
                        ),
                        Text(
                          texts[2],
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
