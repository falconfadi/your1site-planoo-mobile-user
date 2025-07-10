import 'package:cached_network_image/cached_network_image.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/ui/widgets/loading.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double? borderRadius;
  final bool? withCorner;

  const CachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    required this.fit,
    this.borderRadius,
    this.withCorner = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius!),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: fit,
                  height: height,
                  width: width,
                  placeholder: (context, url) => Container(
                    height: height,
                    width: width,
                    color: AppColors.lightGrayColor,
                    child: const Center(child: LoadingIndicator()),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    profileHolder,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              !withCorner! ? const Center() :
              Positioned(
                top: 0,
                left: 0,
                child: ClipPath(
                  clipper: CornerClipper(),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(borderRadius ?? 0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CornerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(0, 0, size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
