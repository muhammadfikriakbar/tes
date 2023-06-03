import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tes/app/widgets/grid_view.dart';

import '../../../widgets/product_card.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final HomeController hc = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 50,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
          color: Colors.grey[800],
        ),
        titleSpacing: -10,
        title: Container(
          height: 35,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.only(left: 8, right: 8),
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            onChanged: (value) {
              hc.searchItem(value);
            },
            decoration: InputDecoration(
              hintText: 'Search',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: -12),
              icon: Icon(Icons.search, color: Colors.grey, size: 18),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: IconButton(
              constraints: BoxConstraints(maxWidth: 30),
              icon: Icon(Icons.shopping_cart_outlined, color: Colors.grey[800]),
              onPressed: () {
                print('Tombol keranjang ditekan!');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: IconButton(
              constraints: BoxConstraints(maxWidth: 40),
              icon: Icon(Icons.menu, color: Colors.grey[800]),
              onPressed: () {
                print('Tombol menu ditekan!');
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Obx(
                () => ListView.builder(
                  padding: EdgeInsets.all(8),
                  scrollDirection: Axis.horizontal,
                  itemCount: hc.itemCategory.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (hc.selectedCategoryIndex.value == index) {
                          hc.selectedCategoryIndex.value = -1;
                          hc.fetch();
                        } else {
                          hc.selectedCategoryIndex.value = index;
                          hc.fetchItemCategory(index);
                        }
                      },
                      child: Obx(() {
                        bool isSelected = hc.selectedCategoryIndex.value == index;
                        return Container(
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: isSelected ? Colors.blue : Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            child: Text(
                              hc.itemCategory[index],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
            Obx(() => MyGridView(controller: hc.controller, itemLength: hc.item.length, isLoading: hc.isLoading.value, items: hc.item,))
          ],
        ),
      ),
    );
  }
}
