var fnPaging = function() {
	
	var page = parseInt($('#currentPage').val(),10);
	
	if (page == "" || page == 0) {
		page = 1;
	}
	
	var pageSize = parseInt($('#countPerPage').val(),10);
	var totCount = parseInt($('#totalCount').val(),10);
	var pageCount = parseInt($('#pageCount').val(),10);
	
	
	var szHtml = "";
	
	var nTotalMemoPage = Math.ceil(totCount / pageSize);
	  
	var nPagePerBlock = pageCount;
	var nBlock = Math.ceil(page / nPagePerBlock);
	var nTotalBlock = Math.ceil(nTotalMemoPage / nPagePerBlock);
	var nListPage = 0;

	// 이전 페이지
	var nPrevPage = (nBlock - 1) * nPagePerBlock;
	  
	
	if (nBlock > 1) {
		szHtml += "<div id=\"sub0601_page1\">";
		szHtml += "<div style=\"margin:0 auto; text-align:center;\"><ul>";
		szHtml += "<li><img src='images/common/paging_prev1.gif' onclick='javascript:searchPage("+1+");'/></li>";
		szHtml += "<li><img src='images/common/paging_prev2.gif' onclick='javascript:searchPage("+nPrevPage+");'/></li>";
//		szHtml += "<span>";
	} else {
		szHtml += "<div id=\"sub0601_page1\">";
		szHtml += "<div style=\"margin:0 auto; text-align:center;\"><ul>";
		szHtml += "<li><img src='images/common/paging_prev1.gif' /></li>";
		szHtml += "<li><img src='images/common/paging_prev2.gif' /></li>";
//		szHtml += "<span>";
	}
	  

	for (var i = 1 ; i <= nPagePerBlock ; i++) {
		nListPage = (nBlock - 1) * nPagePerBlock + i;

		if (nListPage > nTotalMemoPage) {
			break;
		}
	
		if (nListPage < nTotalMemoPage) {
			if (nListPage == page) {
				szHtml += "<li><a href='#'><strong>" + nListPage + "</strong></a></li>";
			} else {
				szHtml += "<li><a href='javascript:searchPage(" + nListPage + ");'>" + nListPage + "</a></li>";
			}
		} else {
			if (nListPage == page) {
				szHtml += "<li><a href='#' class=\"bgnone\"><strong>" + nListPage + "</strong></a></li>";
			} else {
				szHtml += "<li><a href='javascript:searchPage(" + nListPage + ");' class=\"bgnone\">" + nListPage + "</a></li>";
			}
		}
	}
	
	
	// 다음 페이지
	var nNextPage = nBlock * nPagePerBlock + 1;
	
	if (nBlock < nTotalBlock) {
//		szHtml += "</span>";
		szHtml += "<li><img src='images/common/paging_next2.gif' onclick='javascript:searchPage("+nNextPage+");'/></li>";
		szHtml += "<li><img src='images/common/paging_next1.gif' onclick='javascript:searchPage("+nTotalMemoPage+")'/></li>";
		szHtml += "</ul></div></div>";
	} else {
//		szHtml += "</span>";
		szHtml += "<li><img src='images/common/paging_next2.gif' /></li>";
		szHtml += "<li><img src='images/common/paging_next1.gif' /></li>";	   
		szHtml += "</ul></div></div>";
	}


	$('#paging').empty();
	$('#paging').append(szHtml);

};