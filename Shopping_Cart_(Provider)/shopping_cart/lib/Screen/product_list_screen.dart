import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/cart_provider.dart';
import '../Model/dart_model.dart';
import 'cart_screen.dart';
import '../SQFlite/db_helper.dart';

class ProductListScreen extends StatelessWidget {

  List<String> productName = [
    'Ring',
    'Shirt',
    'Grapes',
    'Bangles',
    'Top',
    'Mango',
    'Kids Wear',
    'Orange',
  ];

  List<String> productUnit = [
    'Each',
    'Each',
    'KG',
    'Pair',
    'Each',
    'Kg',
    'Each',
    'Kg'
  ];

  List<int> productPrice = [100, 150, 80, 200, 200, 100, 350, 90];

  List<String> productImage = [
    'https://th.bing.com/th/id/OIP.i83CJS1dIVFFiX3GJSt4lgHaHa?rs=1&pid=ImgDetMain',
    'https://m.media-amazon.com/images/I/71I-cik1CyL._AC_UL1500_.jpg',
    'https://th.bing.com/th/id/OIP.mhEQxYzDIWGxiMAmqGtlYgHaEo?rs=1&pid=ImgDetMain',
    'https://th.bing.com/th/id/OIP.LSOTfodrzDKXJj-lG9RcZwHaHa?rs=1&pid=ImgDetMain',
    'https://i.pinimg.com/originals/1c/22/a9/1c22a99b599b07cda9b138e352510d2d.png',
    'https://th.bing.com/th/id/OIP.KRaBxFLS9GNa2Rw-Dy9IugHaFO?w=270&h=191&c=7&r=0&o=5&dpr=1.2&pid=1.7',
    'https://i5.walmartimages.com/asr/56ca1ae0-6118-44ce-8996-e3e293e7ae22_1.590ceb85d1df43f05f359c4972a7c66d.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
    'https://th.bing.com/th/id/OIP.MX4WBS-R6uEgTFvXhfa_uAHaFH?rs=1&pid=ImgDetMain',
  ];

  DBHelper? dbHelper = DBHelper();

  ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartScreen()));
            },
            child: Center(
              child: badges.Badge(
                showBadge: true,
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return Text(value.getCounter().toString(),
                        style: const TextStyle(color: Colors.white));
                  },
                ),
                badgeAnimation: const badges.BadgeAnimation.rotation(
                  animationDuration: Duration(milliseconds: 300),
                ),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          const SizedBox(width: 20.0),
        ],
        bottom: const PreferredSize(
          preferredSize:              Size.fromHeight(1), 
          child: Divider(
            height: 1,
            color: Colors.grey, 
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
                itemCount: productName.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    surfaceTintColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image(
                                height: 100,
                                width: 100,
                                image: NetworkImage(
                                    productImage[index].toString()),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productName[index].toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      productUnit[index].toString() +
                                          " " +
                                          r"$" +
                                          productPrice[index].toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          dbHelper!
                                              .insert(Cart(
                                                  id: index,
                                                  productId: index.toString(),
                                                  productName:
                                                      productName[index]
                                                          .toString(),
                                                  initialPrice:
                                                      productPrice[index],
                                                  productPrice:
                                                      productPrice[index],
                                                  quantity: 1,
                                                  unitTag: productUnit[index]
                                                      .toString(),
                                                  image: productImage[index]
                                                      .toString()))
                                              .then((value) {
                                            cart.addTotalPrice(double.parse(
                                                productPrice[index]
                                                    .toString()));
                                            cart.addCounter();

                                            const snackBar = SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                  'Product is added to cart'),
                                              duration: Duration(seconds: 1),
                                            );

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }).onError((error, stackTrace) {
                                            print("error" + error.toString());
                                            const snackBar = SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                    'Product is already added in cart'),
                                                duration: Duration(seconds: 1));

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: const Center(
                                            child: Text(
                                              'Add to cart',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
