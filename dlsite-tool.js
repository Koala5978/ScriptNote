function AddAllZeroPriceToCart() {
  document.querySelectorAll('#search_result_img_box > li').forEach((e, i) => {
    let child_number = i + 1;
    let child_goods_title = document.querySelector('#search_result_img_box > li:nth-child(' + child_number + ') > dl > dd.work_name > div.multiline_truncate > a').title;
    let child_price = document.querySelector('#search_result_img_box > li:nth-child(' + child_number + ') > dl > dd.work_price_wrap > span > span > span.work_price_base').textContent;
    let child_a_element = document.querySelector('#search_result_img_box > li:nth-child(' + child_number + ') > div > dl > dd > div > ul > li.work_cart > p > a');
    
    if (child_price == '0') {
      if (child_a_element.getAttribute('class') == 'btn_cart') {
        console.log(child_goods_title, child_price, child_a_element);
        child_a_element.click();
      }
    }
  });
}
