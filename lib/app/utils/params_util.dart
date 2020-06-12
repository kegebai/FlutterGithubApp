class ParamsUtil {

  ///处理分页参数
  static transformPage(String tab, int page, [int pageSize=20]) {
    if (page == null) {
      return "";
    }
    /// `per_page` is equal to `page_size` ???
    return pageSize != null ? "${tab}page=$page&per_page=$pageSize" : "${tab}page=$page";
  }
}