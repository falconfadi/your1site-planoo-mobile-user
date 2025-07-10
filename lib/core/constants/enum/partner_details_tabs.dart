
enum PartnerDetailsTabs {
  categories,
  description,
  reviews;
  static PartnerDetailsTabs fromString(String s) => switch (s) {
    "categories" => categories,
    "description" => description,
    "reviews" => reviews,
    _ => reviews
  };
}
