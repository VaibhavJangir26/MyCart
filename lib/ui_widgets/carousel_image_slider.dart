import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class CarouselImageSlider extends StatefulWidget {
  const CarouselImageSlider({super.key});

  @override
  State<CarouselImageSlider> createState() => _CarouselImageSliderState();
}

class _CarouselImageSliderState extends State<CarouselImageSlider> {
  final ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(0);

  List<String> carouselImg = [
    "https://cdn.dummyjson.com/products/images/tablets/iPad%20Mini%202021%20Starlight/thumbnail.png",
    "https://cdn.dummyjson.com/products/images/beauty/Red%20Nail%20Polish/thumbnail.png",
    "https://cdn.dummyjson.com/products/images/womens-dresses/Black%20Women's%20Gown/thumbnail.png",
    "https://cdn.dummyjson.com/products/images/womens-shoes/Black%20&%20Brown%20Slipper/thumbnail.png",
    "https://cdn.dummyjson.com/products/images/smartphones/iPhone%205s/thumbnail.png",
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width,
      height: height * .4,
      child: Stack(
        children: [


          CarouselSlider.builder(
            itemCount: carouselImg.length,
            itemBuilder: (context, index, pageIndex) {
              return Container(
                width: width * .8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.shade100,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: carouselImg[index],
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    placeholder: (_, url) => Container(
                      color: Colors.blue.shade100,
                      width: width,
                    ),
                    errorWidget: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade300,
                      child: const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              initialPage: 0,
              enlargeCenterPage: true,
              onPageChanged: (index, _) {
                currentIndexNotifier.value = index;
              },
            ),
          ),


          Positioned(
            bottom: 15,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<int>(
              valueListenable: currentIndexNotifier,
              builder: (context, currentIndex, _) {
                return DotsIndicator(
                  decorator: const DotsDecorator(
                    color: Colors.grey,
                    activeColor: Colors.blue,
                  ),
                  dotsCount: carouselImg.length,
                  position: currentIndex,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    currentIndexNotifier.dispose();
    super.dispose();
  }
}
