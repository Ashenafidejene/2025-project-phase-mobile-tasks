import 'package:flutter/material.dart';
import 'package:product3/models/product.dart';



class ProductCard extends StatelessWidget {
  const ProductCard(
      {this.imageAspectRatio = 33 / 49, required this.product, Key? key})
      : assert(imageAspectRatio > 0),
        super(key: key);

  final double imageAspectRatio;
  final Product product;
  static const kTextBoxHeight = 65.0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final imageWidget = Image.asset(product.images, fit: BoxFit.cover);
    //final NumberFormat formatter = NumberFormat.simpleCurrency(
    //   decimalDigits: 0, locale: Localizations.localeOf(context).toString());
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AspectRatio(aspectRatio: imageAspectRatio, child: imageWidget),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              product.productName,
              style: theme.textTheme.labelLarge,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              "120",
              //  formatter.format(product.price),
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[Text("this Data ")],
        )
      ],
    );
  }
}
