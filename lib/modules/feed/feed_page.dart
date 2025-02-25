import 'package:flutter/material.dart';
import 'package:tacaro/modules/feed/feed_controller.dart';
import 'package:tacaro/modules/feed/repositories/feed_repository_impl.dart';
import 'package:tacaro/shared/models/order_model.dart';
import 'package:tacaro/shared/services/app_database.dart';
import 'package:tacaro/shared/theme/app_text.dart';
import 'package:tacaro/shared/widgets/card_chart/card_chart.dart';
import 'package:tacaro/shared/widgets/card_product/card_product.dart';
import 'package:tacaro/shared/widgets/list_tile/app_list_tile.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late final FeedController controller;
  @override
  void initState() {
    controller = FeedController(
      repository: FeedRepositoryImpl(database: AppDatabase.instance),
    );
    controller.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 350),
          child: AnimatedBuilder(
            animation: controller,
            builder: (_, __) => controller.state.when(
              success: (value) {
                final orders = value as List<OrderModel>;
                final products = controller.products;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CardChart(
                            value: controller.sumTotal,
                            percent: controller.calcChart(products),
                          ),
                          SizedBox(
                            height: 27,
                          ),
                          Text("Preço dos produtos").label,
                          SizedBox(
                            height: 14,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 126,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length,
                        itemBuilder: (context, index) => CardProduct(
                          product: products[index],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 27,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Suas últimas compras").label,
                          SizedBox(
                            height: 14,
                          ),
                          for (var order in orders)
                            AppListTile(
                              order: order,
                            ),
                          SizedBox(
                            height: 14,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              orElse: () => Container(),
            ),
          ),
        ),
      ),
    );
  }
}
