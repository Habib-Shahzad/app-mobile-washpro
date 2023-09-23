import 'package:flutter/material.dart';

class IconCardProps {
  final VoidCallback onTap;
  final List<IconData> icons;
  final List<String> texts;
  final double iconPadding;

  IconCardProps({
    required this.onTap,
    required this.icons,
    required this.texts,
    required this.iconPadding,
  });
}

class CustomIconCard extends StatelessWidget {
  final IconCardProps props;
  final double iconSize;
  final double elevation;
  final EdgeInsetsGeometry cardPadding;

  const CustomIconCard({
    Key? key,
    required this.props,
    this.cardPadding = const EdgeInsets.all(16.0),
    this.iconSize = 65,
    this.elevation = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: props.onTap,
        child: Card(
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: cardPadding, // Apply padding to the card content
            child: SizedBox(
              width: 135,
              height: 135,
              child: Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                  if (props.icons.length == 2)
                    Padding(
                      padding: EdgeInsets.only(left: props.iconPadding),
                      child: Icon(
                        props.icons[1],
                        color: Theme.of(context).colorScheme.primary,
                        size: iconSize,
                      ),
                    ),
                  if (props.icons.isNotEmpty)
                    Icon(
                      props.icons[0],
                      color: Theme.of(context).colorScheme.onSurface,
                      size: iconSize,
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
                              props.texts[0],
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
                              props.texts[1],
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
                          props.texts[2],
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
