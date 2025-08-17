import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:quickWork/core/constants/image_const.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final List<String> imageList = [bannerOne, electricalWork];
  int activeIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SizedBox(
            height: 200,
            width: double.infinity,
            child: CarouselSlider.builder(
              carouselController: _controller,
              itemCount: imageList.length,
              itemBuilder: (context, index, realIndex) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imageList[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    cacheWidth: 800,
                    cacheHeight: 370,
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.95,
                autoPlayCurve: Curves.easeInOut,
                autoPlayInterval: const Duration(seconds: 2),
                autoPlayAnimationDuration: const Duration(milliseconds: 500),
                enableInfiniteScroll: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: imageList.length,
          effect: ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: AppColor.primaryColor1,
            dotColor: Colors.grey.shade300,
          ),
          onDotClicked: (index) => _controller.animateToPage(index),
        ),
      ],
    );
  }
}
