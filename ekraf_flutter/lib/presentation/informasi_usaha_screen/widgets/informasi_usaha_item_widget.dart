import 'package:flutter/material.dart'; 
import '../../../core/app_export.dart'; 

class InformasiUsahaItemWidget extends StatelessWidget { 
  const InformasiUsahaItemWidget({Key? key}) : super(key: key); 

  @override 
  Widget build(BuildContext context) { 
    return Container( 
      decoration: AppDecoration.outlineGray1001.copyWith( 
        borderRadius: BorderRadiusStyle.roundedBorder6, 
      ), 
      child: Row( 
        children: [ 
          CustomImageView( 
            imagePath: ImageConstant.img9adf7518b54c5a5, 
            height: 124.h, 
            width: 96.h, 
            radius: BorderRadius.horizontal( 
              left: Radius.circular(6.h), 
            ), 
          ), 
          Expanded( 
            child: Align( 
              alignment: Alignment.bottomLeft, 
              child: Padding( 
                padding: EdgeInsets.only(bottom: 6.h), 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [ 
                    Text( 
                      "Hiasan dinding", 
                      style: CustomTextStyles.titleSmallBluegray900, 
                    ), 
                    SizedBox(height: 4.h), 
                    SizedBox( 
                      width: 186.h, 
                      child: Text( 
                        "Hiasan dinding yang akan mempercantik suasana rumah anda dengan ukiran.", 
                        maxLines: 2, 
                        overflow: TextOverflow.ellipsis, 
                        style: CustomTextStyles.bodySmall10.copyWith( 
                          height: 1.60, 
                        ), 
                      ), 
                    ), 
                    SizedBox(height: 30.h), 
                    RichText( 
                      text: TextSpan( 
                        children: [ 
                          TextSpan( 
                            text: "Harga : ", 
                            style: CustomTextStyles.bodySmall10_1, 
                          ), 
                          TextSpan( 
                            text: "Rp. 30.000 - Rp. 100.000", 
                            style: theme.textTheme.labelMedium,
                          ) 
                        ], 
                      ), 
                      textAlign: TextAlign.left, 
                    ) 
                  ], 
                ), 
              ), 
            ), 
          ) 
        ], 
      ), 
    ); 
  } 
}