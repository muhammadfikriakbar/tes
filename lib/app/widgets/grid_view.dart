import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tes/app/widgets/product_card.dart';

class MyGridView extends StatelessWidget {
  ScrollController controller = ScrollController();
  int itemLength;
  bool isLoading;
  List items;

  MyGridView({
    required this.controller,
    required this.itemLength,
    required this.isLoading,
    required this.items
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        controller: controller,
        physics: ClampingScrollPhysics(),
        slivers: [
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.68,
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index < itemLength) {
                  final item = items[index];
                  return ProductCard(
                    title: item['title'],
                    imageUrl: item['thumbnail'],
                    price: item['price'],
                    rating: item['rating'].toString(),
                  );
                } else {
                  if (isLoading) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 32,),
                      child: Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }
              },
              childCount: itemLength + 1,
            ),
          ),
        ],
      ),
    );
  }
}