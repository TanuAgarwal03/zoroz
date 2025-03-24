// import 'package:clickcart/components/common/touch_spin.dart';
import 'package:clickcart/components/product/product_card.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCart extends StatelessWidget {
  final String? category;
  final String title;
  final String price;
  final String oldPrice;
  final String image;
  final String returnday;
  final String count;
  final String offer;
  final String reviews;
  final String? bottomOption;
  final String? orderStatus;
  final String? orderRated;
  final Function()? removePress;
  final String itemNo;
  final String slug;
  final VoidCallback? onIncreaseQuantity;
  final VoidCallback? onDecreaseQuantity;
  final int totalValue;

  const ProductCart(
      {super.key,
      this.category,
      required this.title,
      required this.price,
      required this.oldPrice,
      required this.image,
      required this.returnday,
      required this.count,
      required this.offer,
      required this.reviews,
      this.bottomOption,
      this.orderStatus,
      this.orderRated,
      this.removePress,
      required this.itemNo,
      required this.slug,
      this.onIncreaseQuantity,
      this.onDecreaseQuantity,
      required this.totalValue,
      });

  @override
  Widget build(BuildContext context) {
    final total = int.parse(price) * int.parse(count);

    return Container(
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/product_detail',
                  arguments: ScreenArguments(
                      title, image, price, oldPrice, offer, slug, itemNo));
            },
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.network(
                    image,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                const SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Text(title,
                              style: Theme.of(context).textTheme.titleMedium)),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Text('₹$price',
                              style: const TextStyle(
                                  color: IKColors.primary, fontSize: 14)),
                          const SizedBox(width: 6),
                          (offer == '0')
                              ? const Text('')
                              : Text('₹$oldPrice',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.merge(const TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough))),
                          const SizedBox(width: 6),
                          // (offer == '0')
                          //     ? const Text('')
                          //     : Text(offer,
                          //         style: Theme.of(context)
                          //             .textTheme
                          //             .bodySmall
                          //             ?.merge(const TextStyle(
                          //                 color: Color(0xFFEB5757)))),
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Color(0xFFFFA048),
                          ),
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Color(0xFFFFA048),
                          ),
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Color(0xFFFFA048),
                          ),
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Color(0xFFFFA048),
                          ),
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Color(0xFFFFA048),
                          ),
                          const SizedBox(width: 6),
                          Text('($reviews Review)',
                              style: Theme.of(context).textTheme.bodySmall)
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(children: [
                        Container(
                            decoration: BoxDecoration(
                                color: IKColors.primary,
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.only(right: 4),
                            height: 14,
                            width: 14,
                            child: const Icon(Icons.reply,
                                size: 12, color: Colors.white)),
                        Text('$returnday Days return available',
                            style: Theme.of(context).textTheme.bodyMedium)
                      ]),

                      Text('Total: ₹$total',
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        width: 1, color: Theme.of(context).dividerColor))),
            child: Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).dividerColor))),
                        child: bottomOption == 'order'
                            ? (orderStatus == 'completed'
                                ? Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.check_circle,
                                            size: 16, color: IKColors.success),
                                        const SizedBox(width: 3),
                                        Text('Completed',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.merge(const TextStyle(
                                                    color: IKColors.success)))
                                      ],
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/track_order');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 7.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.string(
                                            IKSvg.truck2,
                                            width: 14,
                                            height: 14,
                                            // ignore: deprecated_member_use
                                            color: IKColors.primary,
                                          ),
                                          const SizedBox(width: 3),
                                          Text('Track Order',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium)
                                        ],
                                      ),
                                    ),
                                  ))
                            : Row(
                                children: [
                                  IconButton(
                                    icon: const Padding(
                                      padding: EdgeInsets.only(bottom: 14.0),
                                      child: Icon(Icons.minimize,
                                          color: Color(0xFF7D899D)),
                                    ),
                                    onPressed: onDecreaseQuantity,
                                  ),
                                  Text(count,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  IconButton(
                                    icon: const Icon(Icons.add,
                                        color: Color(0xFF7D899D)),
                                    onPressed: onIncreaseQuantity,
                                  ),
                                ],
                              ))),
                Expanded(
                    flex: 4,
                    child: GestureDetector(
                      onTap: removePress,
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.string(
                                IKSvg.trash,
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text('Remove',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.merge(const TextStyle(
                                          color: IKColors.danger))),
                            ],
                          )),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
  // Expanded(
                //   flex: 5,
                //   child: GestureDetector(
                //     onTap: () {
                //       bottomOption == 'order' ?
                //         orderStatus == 'completed' ?
                //           Navigator.pushNamed(context, '/write_review')
                //           :
                //           null
                //       :
                //       Navigator.pushNamed(context, '/wishlist');
                //     },
                //     child: Container(
                //       padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                //       decoration: BoxDecoration(
                //         border: Border(right: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                //       ),
                //       child: 
                //       bottomOption == 'order' ?
                //       (
                //         orderStatus == 'completed' ?
                //         (
                //           orderRated == 'yes' ?
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               const Icon(Icons.star,size: 15,color: Color(0xFFFFAC5F)),
                //               const SizedBox(width: 2),
                //               Text('4.5',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontWeight: FontWeight.w400))),
                //               Text(' Edit Review',style: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(decoration: TextDecoration.underline,decorationColor: IKColors.primary,color: IKColors.primary))),
                //             ],
                //           )
                //           :
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               const Icon(Icons.star,size: 15,color: Color(0xFFFFAC5F)),
                //               const SizedBox(width: 2),
                //               Text('Write Review',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontWeight: FontWeight.w400)))
                //             ],
                //           )
                //         )
                //         :
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Icon(Icons.star,size: 15,color: Theme.of(context).textTheme.bodyMedium?.color),
                //             const SizedBox(width: 2),
                //             Text('Write Review',style: Theme.of(context).textTheme.bodyMedium)
                //           ],
                //         )
                //       )
                //       :
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           SvgPicture.string(
                //             IKSvg.save,
                //             width: 20,
                //             height: 20,
                //           ),
                //           const SizedBox(
                //             width: 4,
                //           ),
                //           Text('Save for later',style:Theme.of(context).textTheme.bodyMedium),
                //         ],
                //       )
                //     ),
                //   )
                // ),