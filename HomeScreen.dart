import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'ProductDetailsScreen.dart';
// import 'package:flutter_image_slider/carousel.dart';

class ApiConstants {
  static const String api = "https://dummyjson.com/products";
}

class DioHelper {
  final Dio dio = Dio();

  Future<List> getNews({required String path}) async {
    Response response = await dio.get(path);
    return response.data["products"];
  }
}

class product_cls {
  final String title;
  final String description;
  final String image;
  final double rating;
  final double price;

  product_cls({
    required this.title,
    required this.description,
    required this.image,
    required this.rating,
    required this.price,
  });

  static List<product_cls> convertToprods(List p) {
    List<product_cls> prodList = [];
    for (var any in p) {
      if (any["title"] != null ||
          any["content"] != null ||
          any["title"] != null ||
          any["rating"] != null ||
          any["price"] != null) {
        prodList.add(
          product_cls(
            title: any["title"],
            description: any["description"],
            image: any["images"][0],
            price: any["price"].toDouble(),
            rating: any["rating"].toDouble(),
          ),
        );
      }
    }
    return prodList;
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int indexValue = 0;

  bool isDarkModeEnabled = false;
  final user = FirebaseAuth.instance.currentUser;

  List<product_cls> product = [];

  Future<void> getData() async {
    List prodList = await DioHelper().getNews(path: ApiConstants.api);
    product = product_cls.convertToprods(prodList);
    setState(() {});
  }

  //for product api
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkModeEnabled ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('ShopApp'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {},
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              // header                   name of the person                          its mail
              UserAccountsDrawerHeader(
                accountName: const Text('Welcome'),
                accountEmail: Text(user!.email!),
                currentAccountPicture: GestureDetector(
                    child: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                )),
                decoration: const BoxDecoration(color: Colors.red),
              ),

              //  body

              InkWell(
                onTap: () {},
                child: const ListTile(
                  title: Text('Home Page'),
                  leading: Icon(
                    Icons.home,
                    color: Colors.green,
                  ),
                ),
              ),

              InkWell(
                onTap: () {},
                child: const ListTile(
                  title: Text('My account'),
                  leading: Icon(Icons.person),
                ),
              ),

              InkWell(
                onTap: () {},
                child: const ListTile(
                  title: Text('My Orders'),
                  leading:
                      Icon(Icons.shopping_basket, color: Colors.deepPurple),
                ),
              ),

              InkWell(
                onTap: () {},
                child: const ListTile(
                  title: Text('Categories'),
                  leading: Icon(Icons.dashboard, color: Colors.blue),
                ),
              ),

              InkWell(
                onTap: () {},
                child: const ListTile(
                  title: Text('Favourites'),
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const ListTile(
                  title: Text('LOG OUT'),
                  leading: Icon(Icons.logout),
                ),
              ),

              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Switch(
                      value: isDarkModeEnabled,
                      onChanged: (value) {
                        // Update the state when the switch is toggled
                        setState(() {
                          isDarkModeEnabled = value;
                        });
                      },
                    ),
                    Text(
                      isDarkModeEnabled ? 'Dark Mode' : 'Light Mode',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        //   The Products

        body: Column(
          children: [
            // Carousel(
            //   indicatorBarColor: Colors.black.withOpacity(0),
            //   autoScrollDuration: Duration(seconds: 2),
            //   animationPageDuration: Duration(milliseconds: 500),
            //   activateIndicatorColor: Colors.amber.shade900,
            //   indicatorBarHeight: 25,
            //   indicatorHeight: 10,
            //   indicatorWidth: 15,
            //   unActivatedIndicatorColor: Colors.grey,
            //   autoScroll: true,
            //   items: [
            //     Container(
            //       child: Image.asset(
            //         'assets/images/bts.jpg',
            //         height: 500,
            //         fit: BoxFit.fill,
            //       ),
            //     ),
            //     Container(
            //       child: Image.asset(
            //         'assets/images/watch.jpeg',
            //         fit: BoxFit.fill,
            //       ),
            //     ),
            //     Container(
            //       child: Image.asset(
            //         'assets/images/sales.jpeg',
            //         fit: BoxFit.fill,
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 5),

            Container(
              width: 360,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Trending',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: 5),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: width,
                  height: height - 120,
                  child: product.length == 0
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange,
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Set the number of columns
                            crossAxisSpacing:
                                10.0, // Set the spacing between columns
                            mainAxisSpacing:
                                10.0, // Set the spacing between rows
                          ),
                          itemCount: product.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailsScreen(
                                        product: product[index]),
                                  ),
                                );
                              },
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                        product[index].image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 8.0,
                                      ),
                                      child: Text(
                                        product[index].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //     horizontal: 16.0,
                                    //   ),
                                    //   child: Text(
                                    //     product[index].description,
                                    //     maxLines: 2,
                                    //     overflow: TextOverflow.ellipsis,
                                    //     style: const TextStyle(
                                    //       fontSize: 13,
                                    //       color: Colors.black26,
                                    //       fontWeight: FontWeight.bold,
                                    //     ),
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.money,
                                            color: Colors.green,
                                            size: 16,
                                          ),
                                          // SizedBox(width: 4),
                                          // Text(
                                          //   product[index].rating.toString(),
                                          //   style: const TextStyle(
                                          //     fontSize: 13,
                                          //     fontWeight: FontWeight.bold,
                                          //     color: Colors.black,
                                          //   ),
                                          // ),
                                          // SizedBox(width: 8),
                                          Text(
                                            '\$${product[index].price.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
