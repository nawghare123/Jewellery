

// import 'package:flutter/material.dart';
// import 'package:jewellery/view/home/BannerModel.dart';

// class BannerView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {

//     return Column(
//       children: [

       

//         SizedBox(
//           height: 85,
//           child: Consumer<BannerModel>(
//             builder: (context, banner, child) {
//               return banner.bannerList != null ? banner.bannerList.length > 0 ? ListView.builder(
//                 itemCount: banner.bannerList.length,
//                 padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
//                 physics: BouncingScrollPhysics(),
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () {
//                       if(banner.bannerList[index].productId != null) {
//                         Product product;
//                         for(Product prod in banner.productList) {
//                           if(prod.id == banner.bannerList[index].productId) {
//                             product = prod;
//                             break;
//                           }
//                         }
//                         if(product != null) {
//                           Navigator.of(context).pushNamed(Routes.getProductDetailsRoute(product.id),
//                               arguments: ProductDetailsScreen(product: product));
//                         }

//                       }else if(banner.bannerList[index].categoryId != null) {
//                         CategoryModel category;
//                         for(CategoryModel categoryModel in Provider.of<CategoryProvider>(context, listen: false).categoryList) {
//                           if(categoryModel.id == banner.bannerList[index].categoryId) {
//                             category = categoryModel;
//                             break;
//                           }
//                         }
//                         if(category != null) {
//                           Navigator.pushNamed(
//                             context, Routes.getCategoryRoute(category.id),
//                             arguments: CategoryScreen(categoryModel: category),
//                           );
//                         }
//                       }
//                     },
//                     child: Container(
//                       margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
//                       decoration: BoxDecoration(
//                         boxShadow: [
//                           Provider.of<ThemeProvider>(context).darkTheme ? BoxShadow() :BoxShadow(
//                             color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 300],
//                             spreadRadius: 1, blurRadius: 5),
//                         ],
//                         color: ColorResources.COLOR_WHITE,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: FadeInImage.assetNetwork(
//                           placeholder: Images.placeholder(context),
//                           image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls.bannerImageUrl}/${banner.bannerList[index].image}',
//                           width: 250, height: 85, fit: BoxFit.cover,
//                           imageErrorBuilder: (context,a,b) => Image.asset(Images.placeholder(context),width: 250, height: 85, fit: BoxFit.cover,),

//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ) : Center(child: Text(getTranslated('no_banner_available', context))) : BannerShimmer();
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class BannerShimmer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 5,
//       shrinkWrap: true,
//       padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
//       physics: BouncingScrollPhysics(),
//       scrollDirection: Axis.horizontal,
//       itemBuilder: (context, index) {
//         return Shimmer(
//           duration: Duration(seconds: 2),
//           enabled: Provider.of<BannerProvider>(context).bannerList == null,
//           child: Container(
//             width: 250, height: 85,
//             margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
//             decoration: BoxDecoration(
//               boxShadow: [BoxShadow(color: Colors.grey[200], spreadRadius: 1, blurRadius: 5)],
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

