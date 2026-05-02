class AppConfig {
  static const String baseUrl = "https://dev-api.livelongfit.com/api/v2";

  static const String authToken =
      "Y8FyZBClwGhrOYaq1sOi5Kr+vqgI9ZUlRWuqzVaqljqSzejGXrxD158TZ0fSbJWbugCpYXu8w6PeRSpZjgZJ+Vur1B0ktJDByxpgVdweAJ+4CO1YQ5DltkgFjk+TmgmTmFNc/IwFAVGBtu2kCeWVZUf7t5A/dKkQUdCBdfkJaVkYHQRbM+ekxvpVLWsrBp8wLsM12O2UJiy01EMd7MlUUyErdT9K9+047LTgMTZXs5fiKkPP1GJKx7BjAjMIIF7Mf3k1Z6BQZ0bv/+orMLaGYbpoRvClPdEpRV23pZfeTqE=";

  static Map<String, String> get headers => {
        "Accept": "application/json",
        "Accept-Charset": "UTF-8",
        "Content-Type": "application/json",
        "User-Agent":
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:127.0) Gecko/20100101 Firefox/127.0",
        "auth": authToken,
        "sessiontoken": "",
      };

  static String searchRestaurantUrl(String query, int page) {
    return "$baseUrl/restaurant/search?"
        "lang=en&storeCode=KW&page=$page&perPage=20&q=$query"
        "&categoryId=&macroCategoryId=&nearBy=&sortBy=1"
        "&homeManagementId=&latlng=29.3800453,47.9744896"
        "&userId=1f60cddc-ae03-4430-b8d7-deb6bf63846c"
        "&calories=&carbs=&proteins=&fats=&isCheat=0";
  }

  static String restaurantDetailUrl(int id) {
    return "$baseUrl/restaurant/details?"
        "lang=en&storeCode=KW&currencyCode=KD"
        "&restaurantId=$id"
        "&userId=1f60cddc-ae03-4430-b8d7-deb6bf63846c"
        "&latlng=29.3800453,47.9744896";
  }
}