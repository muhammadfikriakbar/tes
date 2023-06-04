import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:tes/app/widgets/product_card.dart';

class HomeController extends GetxController {

  RxInt skip = 0.obs;
  RxList item = [].obs;
  RxList itemCategory = [].obs;
  RxString category = "".obs;
  ScrollController controller = ScrollController();
  RxBool isLoading = false.obs;
  RxInt selectedCategoryIndex = RxInt(-1);
  RxString search = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetch();
    fetchCategory();
    controller.addListener(_scrollListener);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      if (selectedCategoryIndex.value != -1) {
        addItemCategory();
      } else if (search.isNotEmpty) {
        addSearchItem();
      } else {
        addItem();
      }
    }
  }

  Future<void> fetch() async {
    skip.value = 0;
    final url = Uri.parse('https://dummyjson.com/products?limit=10');
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      item.clear();
      item.addAll(json["products"]);
    } else {
      print("Server Gagal");
    }
  }

  Future<void> addItem() async {
    if (isLoading.value) return;
    isLoading.value = true;
    skip.value += 10;
    final url = Uri.parse('https://dummyjson.com/products?limit=10&skip=${skip.value}');
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    List newItems = json["products"];
    item.addAll(newItems);
    isLoading.value = false;
  }

  Future<void> fetchItemCategory(int index) async {
    skip.value = 0;
    selectedCategoryIndex.value = index;
    category.value = itemCategory[index];
    final url = Uri.parse('https://dummyjson.com/products/category/${category.value}');
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      item.clear();
      item.addAll(json["products"]);
    } else {
      print("Server Gagal");
    }
  }

  Future<void> addItemCategory() async {
    if (isLoading.value) return;
    isLoading.value = true;
    skip.value += 10;
    final url = Uri.parse('https://dummyjson.com/products/category/${category.value}?limit=10&skip=$skip');
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    List newItems = json["products"];
    item.addAll(newItems);
    isLoading.value = false;
  }

  Future<void> fetchCategory() async {
    final url = Uri.parse('https://dummyjson.com/products/categories');
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      itemCategory.addAll(json);
    } else {
      print("Server Gagal");
    }
  }

  Future<void> searchItem(String keyword) async {
    skip.value = 0;
    search.value = keyword;
    final url = Uri.parse('https://dummyjson.com/products/search?q=${search.value}&limit=10');
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      item.clear();
      item.addAll(json["products"]);
    } else {
      print("Server Gagal");
    }
  }

  Future<void> addSearchItem() async {
    if (isLoading.value) return;
    isLoading.value = true;
    skip.value += 10;
    final url = Uri.parse('https://dummyjson.com/products/search?q=${search.value}&limit=10&skip=$skip');
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    List newItems = json["products"];
    item.addAll(newItems);
    isLoading.value = false;
  }

}
