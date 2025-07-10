
enum PartnerTabs {
  courts,
  trainers;
  static PartnerTabs fromString(String s) => switch (s) {
    "courts" => courts,
    "trainers" => trainers,
    _ => trainers
  };
}
