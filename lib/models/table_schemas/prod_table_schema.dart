class ProductTable {
  static const categoriesIDsArray = 'categories_ids_array';
  static const customerReviewsArray =
      'customer_reviews_array'; //ProdCustomerReviewsSubTable
  static const customerReviewsCount = 'customer_reviews_count';
  static const descriptionMap = 'description_map'; //ProdDescriptionMap
  static const priceDetailMap = 'price_detail'; //ProdPriceMap
  static const imgUrlsArray = 'img_urls_array';
  static const isActive = 'is_active';
  static const manufacturerDetailMap =
      'manufacturer_detail_map'; //ProdManufacturerMap
  static const sizesDetailMap = 'sizes_detail_map'; //ProdSizesDetailMap
  static const specialMsg = 'special_msg';
  static const subCategoriesIDsArray = 'sub_categories_ids_array';
  static const subSubcategoriesIDsArray = 'sub_sub_categories_ids_array';
}

class ProdCustomerReviewsSubTable {
  static const dislikesCount = 'dislikes_count';
  static const imagesArray = 'images_array';
  static const likesCount = 'likes_count';
  static const message = 'message';
  static const timeStamp = 'time_stamp';
  static const userId = 'user_id';
}

class ProdDescriptionMap {
  static const long = 'long';
  static const materialAndCare = 'material_and_care';
  static const short1 = 'short_1';
  static const short2 = 'short_2';
  static const sizeAndFit = 'size_and_fit';
}

class ProdPriceMap {
  static const discountAmount = 'discount_amount';
  static const discountMaxAmountViaPercentage =
      'discount_max_amount_via_percentage'; // 0 - Consider no limit.
  static const discountPercentage = 'discount_percentage'; //Upper limit is 100.
  static const discountType =
      'discount_type'; //0 - No disc, 1 - Amount disc, 2 - Percentage disc.
  static const price = 'price';
}

class ProdManufacturerMap {
  static const id = 'id';
  static const brandName = 'brand_name';
  static const brandId = 'brand_id';
  static const name = 'name';
  static const prodCode = 'prod_code';
}

class ProdSizesDetailMap {
  static const list = 'list'; //[ProdSizeMap]
  static const specialMsg = 'special_msg';
}

class ProdSizeMap {
  static const id = 'id';
  static const isActive = 'is_active';
  static const name = 'name';
  static const remainingQty = 'remaining_qty';
}
