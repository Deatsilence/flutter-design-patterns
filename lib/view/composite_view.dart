import 'package:design_patterns/enums/categories_type_enum.dart';
import 'package:design_patterns/patterns/composite/composite_product_category.dart';
import 'package:flutter/material.dart';

class CompositeView extends StatefulWidget {
  const CompositeView({super.key});

  @override
  State<CompositeView> createState() => _CompositeViewState();
}

class _CompositeViewState extends State<CompositeView> {
  final List<Category> categories = [
    Category(
      name: "Desktop Computer",
      children: [
        Product(
          title: "Main Board",
          description: "Part of the computer",
          imageUrl: "imageUrl#1",
          price: 1000,
        ),
        Product(
          title: "CPU",
          description: "Part of the computer",
          imageUrl: "imageUrl#2",
          price: 2000,
        )
      ],
    ),
    Category(
      name: "Car",
      children: [
        Product(
          title: "Electiric car",
          description: "type of the cars",
          imageUrl: "imageUrl#1",
          price: 9000,
        ),
        Product(
          title: "wheel",
          description: "Part of the cars",
          imageUrl: "imageUrl#2",
          price: 1000,
        )
      ],
    ),
  ];

  final Product product = Product(
    title: "GPU",
    description: "Part of the computer",
    imageUrl: "imageUrl#3",
    price: 24000,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  categories[index].isExpanded = !categories[index].isExpanded;
                });
              },
              children: [
                categories[CategoryType.desktopComputer.index].buildItemWidget(),
                categories[CategoryType.car.index].buildItemWidget(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: product.buildItemWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
